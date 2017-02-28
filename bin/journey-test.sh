#!/usr/bin/env bash

assert_installed() {
  local ok=0
  for executable in $@; do
    if [[ "`which $executable`" == "" ]]; then
      echo "Missing executable: $executable"
      ok=1
    fi
  done
  if [[ "$ok" != "0" ]]; then exit $ok; fi
}

assert_ruby_installed() {
  local app_home="$1"

  pushd "${app_home}"
  local current_ruby_ver=$(ruby --version | egrep --only-matching "[0-9]+\.[0-9]+\.[0-9]+")
  local expected_rby_ver=$(cat Gemfile | awk -F\' '/ruby /{print $2}')
  popd

  if [[ "${expected_rby_ver}" != "" && "${current_ruby_ver}" != "${expected_rby_ver}" ]]; then
    echo "${app_home} requires Ruby ${expected_rby_ver}; current Ruby version is ${current_ruby_ver}."
    echo -e "Ruby used: `which ruby`.\n"
    echo "PATH=${PATH}"
    echo "aborting."
    exit 1
  fi
}

clean() {
  local build_dir="$1"

  # empty, absolute pathes, or parent references are considered dangerous to
  # rm -rf against
  if [[ "${build_dir}" == "" || "${build_dir}" =~ "^/" || "${build_dir}" =~ "\.\." ]]; then
    echo "Value for build_dir (${build_dir}) looks dangerous, aborting!"
    exit 1
  fi

  local build_path=$(pwd)/${build_dir}
  if [[ -d "${build_path}" ]]; then
    echo "Cleaning journey script build output directory (${build_path})"
    rm -rf "${build_path}"
  fi

  for i in $(ls exercises); do
    pushd exercises/$i
    rm -rf _build deps rebar.lock
    popd
  done
}

git_clone() {
  local repo_name="$1"
  local dest_path="$2"

  git clone "https://github.com/exercism/${repo_name}" "${dest_path}"
}

make_local_trackler() {
  local trackler="$1"
  local xapi_home="$2"

  local xerlang=$(pwd)

  pushd $trackler

  git submodule init -- common
  git submodule update

  # Bake in local version of xerlang, this is what we are testing.
  rmdir tracks/erlang
  mkdir -p tracks/erlang/exercises
  cp "${xerlang}/config.json" tracks/erlang
  cp -r "${xerlang}/exercises" tracks/erlang

  # Set version to that expected by x-api
  version=$(grep -m 1 'trackler' ${xapi_home}/Gemfile.lock | sed 's/.*(//' | sed 's/)//')
  echo "module Trackler VERSION = \"${version}\" end" > lib/trackler/version.rb

  [[ $(which bundler) != "" ]] || gem install bundler
  bundle install
  gem build trackler.gemspec

  # Make this the trackler that x-api will use when we build it
  gem install --local "trackler-${version}.gem"
  popd
}

start_x_api() {
  local xapi_home="$1"

  pushd "$xapi_home"

  gem install bundler
  bundle install
  RACK_ENV=development rackup &
  xapi_pid=$!
  sleep 5

  echo "x-api is running, pid is ${xapi_pid}."

  popd
}

download_exercism_cli() {
  local os="$1"
  local arch="$2"
  local exercism_home="$3"

  local CLI_RELEASES=https://github.com/exercism/cli/releases

  local latest=${CLI_RELEASES}/latest

  # "curl..." :: HTTP 302 headers, including "Location" -- URL to redirect to.
  # "awk..." :: pluck last path segment from "Location" (i.e. the version number)
  local version="$(curl --head --silent ${latest} | awk -v FS=/ '/Location:/{print $NF}' | tr -d '\r')"

  local download_url_suffix
  local unzip_command
  local unzip_from_file_option
  if [[ ${os} == "windows" ]] ; then
    download_url_suffix="zip"
    unzip_command="unzip -d"
    unzip_from_file_option=""
  else
    download_url_suffix="tgz"
    unzip_command="tar xz -C"
    unzip_from_file_option="-f"
  fi
  local download_url=${CLI_RELEASES}/download/${version}/exercism-${os}-${arch}.${download_url_suffix}

  mkdir -p ${exercism_home}
  local temp=`mktemp`
  curl -s --location ${download_url} > ${temp}
  ${unzip_command} ${exercism_home} ${unzip_from_file_option} ${temp}
}

get_operating_system() {
  case $(uname) in
      (Darwin*)
          echo "mac";;
      (Linux*)
          echo "linux";;
      (Windows*)
          echo "windows";;
      (MINGW*)
          echo "windows";;
      (*)
          echo "linux";;
  esac
}

get_cpu_architecture() {
  case $(uname -m) in
      (*64*)
          echo 64bit;;
      (*686*)
          echo 32bit;;
      (*386*)
          echo 32bit;;
      (*)
          echo 64bit;;
  esac
}

main() {
  cd "${EXECPATH}"

  local xerlang=$(pwd)
  local build_dir="build"
  local build_path="${xerlang}/${build_dir}"

  local xapi_home="${build_path}/x-api"
  local trackler_home="${build_path}/trackler"
  local exercism_home="${build_path}/exercism"

  local exercism_config_file=".journey-test.exercism.json"
  local xapi_port=9292

  # fail fast if required tools are missing
  assert_installed "git" "erl" "rebar3"

  # clean up old cruft
  clean "${build_dir}"

  # make a version of trackler containing this sources
  git_clone "x-api" "${xapi_home}"
  git_clone "trackler" "${trackler_home}"
  assert_ruby_installed "${trackler_home}"
  make_local_trackler "${trackler_home}" "${xapi_home}"

  # Fire up the local x-api
  assert_ruby_installed "${xapi_home}"
  start_x_api "${xapi_home}"

  # Create a CLI install and config just for this build; this script does not use your CLI install.
  download_exercism_cli $(get_operating_system) $(get_cpu_architecture) "${exercism_home}"
  configure_exercism_cli "${exercism_home}" "${exercism_configfile}" "${xapi_port}"
}

# Show expanded commands
set -ex

# Determine path of this script as well as the current execution dir
SCRIPTPATH=$(pushd `dirname $0` > /dev/null && pwd && popd > /dev/null)
EXECPATH=$(pwd)

# Make output easier to read in CI
TERM=dumb


xapi_pid=""
# trap on_exit EXIT
main
