-module('largest_series_product_tests').
-include_lib("eunit/include/eunit.hrl").


can_find_the_largest_product_of_2_with_numbers_in_order_test() ->
  ?assertEqual(72, largest_series_product:lsp("0123456789", 2)).

can_find_the_largest_product_of_2_test() ->
  ?assertEqual(48, largest_series_product:lsp("576802143", 2)).

finds_the_largest_product_if_span_equals_length_test() ->
  ?assertEqual(18, largest_series_product:lsp("29", 2)).

can_find_the_largest_product_of_3_with_numbers_in_order_test() ->
  ?assertEqual(504, largest_series_product:lsp("0123456789", 3)).

can_find_the_largest_product_of_3_test() ->
  ?assertEqual(270, largest_series_product:lsp("1027839564", 3)).

can_find_the_largest_product_of_5_with_numbers_in_order_test() ->
  ?assertEqual(15120, largest_series_product:lsp("0123456789", 5)).

can_find_the_largest_product_of_a_big_number_test() ->
  ?assertEqual(23520, largest_series_product:lsp("73167176531330624919225119674426574742355349194934", 6)).

can_find_the_largest_product_of_a_big_number_ii_test() ->
  ?assertEqual(28350, largest_series_product:lsp("52677741234314237566414902593461595376319419139427", 6)).

can_find_the_largest_product_of_a_big_number_project_euler_test() ->
  ?assertEqual(23514624000, largest_series_product:lsp("7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450", 13)).

reports_zero_if_the_only_digits_are_zero_test() ->
  ?assertEqual(0, largest_series_product:lsp("0000", 2)).

reports_zero_if_all_spans_include_zero_test() ->
  ?assertEqual(0, largest_series_product:lsp("99099", 3)).

rejects_span_longer_than_string_length_test() ->
  ?assertMatch(error, largest_series_product:lsp("123", 4)).

reports_1_for_empty_string_and_empty_product_0_span_test() ->
  ?assertEqual(1, largest_series_product:lsp("", 0)).

reports_1_for_nonempty_string_and_empty_product_0_span_test() ->
  ?assertEqual(1, largest_series_product:lsp("123", 0)).

rejects_empty_string_and_nonzero_span_test() ->
  ?assertMatch(error, largest_series_product:lsp("", 1)).

rejects_invalid_character_in_digits_test() ->
  ?assertMatch(error, largest_series_product:lsp("1234a5", 2)).

rejects_negative_span_test() ->
  ?assertMatch(error, largest_series_product:lsp("12345", -1)).
