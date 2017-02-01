### Homebrew for Mac OS X

Update your Homebrew to latest:

```bash
$ brew update
```

Install Erlang:

```bash
$ brew install erlang
```

Also fetch the latest `rebar3` from rebar3.org and put it somewhere in
your `$PATH` and make it executable. (PRs that describe this better or
via `brew` are welcome).

### On Linux

Fedora 17+ and Fedora Rawhide: `sudo yum -y install erlang`
Arch Linux : Erlang is available on AUR via `yaourt -S erlang`

Also fetch the latest `rebar3` from rebar3.org and put it somewhere in
your `$PATH` and make it executable. (PRs that describe this better or
via package manager are welcome).

### On Windows

Assuming [`choco`](https://chocolatey.org/) is available (maybe you
already installed `exercism` CLI using it).

```cmd
choco install erlang
choco install rebar3
```

### Installing from Source

Get [Erlang OTP 17.1](http://www.erlang.org/download.html)
