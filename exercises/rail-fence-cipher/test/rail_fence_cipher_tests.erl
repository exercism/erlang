%% based on canonical data version 1.1.0
%% https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/rail-fence-cipher/canonical-data.json

-module(rail_fence_cipher_tests).

-define(TEST_VERSION, 1).
-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").

encode_with_2_rails_test() ->
	Rails=2,
	Message="XOXOXOXOXOXOXOXOXO",
	Expected="XXXXXXXXXOOOOOOOOO",
	?assertMatch(Expected, rail_fence_cipher:encode(Message, Rails)).

encode_with_3_rails_test() ->
	Rails=3,
	Message="WEAREDISCOVEREDFLEEATONCE",
	Expected="WECRLTEERDSOEEFEAOCAIVDEN",
	?assertMatch(Expected, rail_fence_cipher:encode(Message, Rails)).

encode_with_ending_in_the_middle_test() ->
	Rails=4,
	Message="EXERCISES",
	Expected="ESXIEECSR",
	?assertMatch(Expected, rail_fence_cipher:encode(Message, Rails)).

decode_with_3_rails_test() ->
	Rails=3,
	Message="TEITELHDVLSNHDTISEIIEA",
	Expected="THEDEVILISINTHEDETAILS",
	?assertMatch(Expected, rail_fence_cipher:decode(Message, Rails)).

decode_with_5_rails_test() ->
	Rails=5,
	Message="EIEXMSMESAORIWSCE",
	Expected="EXERCISMISAWESOME",
	?assertMatch(Expected, rail_fence_cipher:decode(Message, Rails)).

decode_with_6_rails_test() ->
	Rails=6,
	Message="133714114238148966225439541018335470986172518171757571896261",
	Expected="112358132134558914423337761098715972584418167651094617711286",
	?assertMatch(Expected, rail_fence_cipher:decode(Message, Rails)).

version_test() ->
	?assertMatch(?TEST_VERSION, rail_fence_cipher:test_version()).
