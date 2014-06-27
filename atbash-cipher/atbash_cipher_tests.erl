-module(atbash_cipher_tests).
-include_lib("eunit/include/eunit.hrl").

encode_all_test() -> ?assert( lists:seq($z, $a, -1) =:= atbash_cipher:encode(lists:seq($a, $z)) ).

decode_all_test() -> ?assert( lists:seq($z, $a, -1) =:= atbash_cipher:decode(lists:seq($a, $z)) ).

encode_all_caps_test() -> ?assert( lists:seq($Z, $A, -1) =:= atbash_cipher:encode(lists:seq($A, $Z)) ).

decode_all_caps_test() -> ?assert( lists:seq($Z, $A, -1) =:= atbash_cipher:decode(lists:seq($A, $Z)) ).

examples_encode_test() -> ?assert( "gvhg" =:= atbash_cipher:encode("test") ).

examples_decode_test() -> ?assert( "test" =:= atbash_cipher:decode("gvhg") ).

encode_decode_test() ->
		     String = "The quick brown fox jumps over the lazy dog.",
		     ?assert( String =:= atbash_cipher:decode(atbash_cipher:encode(String)) ).

alphanumeric_encode_test() -> ?assert( "gvhg: 1, 2, 3." =:= atbash_cipher:encode("test: 1, 2, 3.") ).

alphanumeric_decode_test() -> ?assert( "test: 1, 2, 3." =:= atbash_cipher:encode("gvhg: 1, 2, 3.") ).
