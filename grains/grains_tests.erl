-module( grains_tests ).
-include_lib( "eunit/include/eunit.hrl" ).

general_test() ->
	       Solution = {[{1,1},{2,2},{3,4},{4,8},{5,16}],31},
	       ?assert( Solution =:= grains:per_square_and_sum(5) ).

chess_test() ->
	     Solution =
{[{1,1},
  {2,2},
  {3,4},
  {4,8},
  {5,16},
  {6,32},
  {7,64},
  {8,128},
  {9,256},
  {10,512},
  {11,1024},
  {12,2048},
  {13,4096},
  {14,8192},
  {15,16384},
  {16,32768},
  {17,65536},
  {18,131072},
  {19,262144},
  {20,524288},
  {21,1048576},
  {22,2097152},
  {23,4194304},
  {24,8388608},
  {25,16777216},
  {26,33554432},
  {27,67108864},
  {28,134217728},
  {29,268435456},
  {30,536870912},
  {31,1073741824},
  {32,2147483648},
  {33,4294967296},
  {34,8589934592},
  {35,17179869184},
  {36,34359738368},
  {37,68719476736},
  {38,137438953472},
  {39,274877906944},
  {40,549755813888},
  {41,1099511627776},
  {42,2199023255552},
  {43,4398046511104},
  {44,8796093022208},
  {45,17592186044416},
  {46,35184372088832},
  {47,70368744177664},
  {48,140737488355328},
  {49,281474976710656},
  {50,562949953421312},
  {51,1125899906842624},
  {52,2251799813685248},
  {53,4503599627370496},
  {54,9007199254740992},
  {55,18014398509481984},
  {56,36028797018963968},
  {57,72057594037927936},
  {58,144115188075855872},
  {59,288230376151711744},
  {60,576460752303423488},
  {61,1152921504606846976},
  {62,2305843009213693952},
  {63,4611686018427387904},
  {64,9223372036854775808}],
 18446744073709551615},
	     ?assert( Solution =:= grains:chess() ).
