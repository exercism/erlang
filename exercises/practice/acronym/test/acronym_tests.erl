-module(acronym_tests).

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").




'1_basic_test_'() ->
    Input = "Portable Network Graphics",
    Expected = "PNG",
    {"basic",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.

'2_lowercase_words_test_'() ->
    Input = "Ruby on Rails",
    Expected = "ROR",
    {"lowercase words",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.

'3_punctuation_test_'() ->
    Input = "First In, First Out",
    Expected = "FIFO",
    {"punctuation",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.

'4_all_caps_words_test_'() ->
    Input = "GNU Image Manipulation Program",
    Expected = "GIMP",
    {"all caps word",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.

'5_punctuation_without_whitespace_test_'() ->
    Input = "Complementary metal-oxide semiconductor",
    Expected = "CMOS",
    {"punctuation without whitespace",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.

'6_very_long_abbreviation_test_'() ->
    Input = "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me",
    Expected = "ROTFLSHTMDCOALM",
    {"very long abbreviation",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.

'7_consecutive_delimiters_test_'() ->
    Input = "Something - I made up from thin air",
    Expected = "SIMUFTA",
    {"consecutive delimiters",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.

'8_apostrophes_test_'() ->
    Input = "Halley's Comet",
    Expected = "HC",
    {"apostrophes",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.

'9_underscore_emphasis_test_'() ->
    Input = "The Road _Not_ Taken",
    Expected = "TRNT",
    {"underscore emphasis",
     ?_assertEqual(Expected,
                   acronym:abbreviate(Input))}.
