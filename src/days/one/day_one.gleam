import gleam/io
import gleam/list
import gleam/order

fn sort_list_items(a: Int, b: Int) {
  case a == b {
    True -> order.Eq
    _ ->
      case a > b {
        True -> order.Gt
        False -> order.Lt
      }
  }
}

fn compare_two_lists(left_list: List(Int), right_list: List(Int)) {
  let sorted_left_list = list.sort(left_list, sort_list_items)
  let sorted_right_list = list.sort(right_list, sort_list_items)

  io.debug("Left list: ")
  io.debug(sorted_left_list)
  io.debug("Right list: ")
  io.debug(sorted_right_list)
}

pub fn main() {
  // Copied from the txt as file reading seems a pain in gleam
  let left_list = [
    84_283, 35_360, 17_841, 22_035, 43_645, 45_290, 47_251, 39_300, 19_278,
    85_842, 35_833, 83_505, 84_748, 89_475, 42_161, 44_380, 71_528, 70_514,
    44_413, 33_787, 90_737, 37_294, 75_263, 60_662, 84_705, 21_217, 72_906,
    93_885, 95_413, 15_097, 51_861, 86_779, 89_053, 91_473, 42_848, 75_389,
    79_784, 93_069, 47_264, 27_695, 92_063, 39_085, 51_201, 17_981, 32_685,
    98_625, 69_815, 93_402, 72_880, 97_907, 76_481, 44_842, 80_295, 97_958,
    89_545, 73_090, 72_433, 85_972, 10_582, 22_334, 43_360, 79_393, 42_302,
    61_177, 49_655, 72_005, 58_727, 37_514, 99_443, 52_137, 49_038, 94_756,
    62_268, 27_702, 98_521, 61_583, 22_777, 18_614, 38_328, 15_249, 33_863,
    46_651, 61_084, 39_251, 22_781, 53_976, 35_530, 25_493, 20_353, 84_109,
    83_893, 30_896, 97_083, 73_752, 67_790, 79_260, 65_897, 44_296, 21_934,
    77_571, 56_142, 57_117, 23_301, 73_163, 91_882, 95_331, 59_289, 15_754,
    46_398, 10_667, 69_601, 11_225, 98_793, 97_146, 86_898, 50_178, 19_563,
    37_236, 48_110, 87_813, 45_147, 18_308, 83_455, 31_167, 57_734, 28_433,
    17_114, 30_689, 32_142, 75_022, 37_954, 87_682, 75_831, 15_774, 97_448,
    11_672, 65_732, 42_222, 80_590, 58_007, 51_361, 77_212, 97_079, 14_347,
    60_311, 91_345, 98_757, 17_921, 66_116, 51_094, 67_373, 79_628, 69_987,
    27_839, 18_904, 87_664, 34_757, 59_509, 36_746, 49_422, 15_204, 76_707,
    57_263, 24_221, 66_460, 26_979, 50_113, 27_576, 10_024, 94_266, 53_098,
    49_708, 45_448, 71_075, 70_967, 79_261, 10_368, 52_272, 99_474, 62_001,
    13_025, 44_750, 53_413, 29_540, 67_424, 19_550, 47_390, 26_625, 53_218,
    96_391, 99_990, 15_308, 65_730, 65_789, 87_805, 29_236, 31_771, 18_987,
    64_300, 78_147, 48_116, 92_646, 65_185, 19_530, 52_051, 85_748, 79_421,
    80_422, 29_790, 55_576, 49_121, 72_333, 65_315, 90_550, 31_131, 24_074,
    25_162, 75_109, 43_749, 75_832, 65_214, 39_525, 63_454, 51_736, 35_556,
    21_880, 65_295, 92_624, 40_519, 17_223, 58_997, 96_291, 18_878, 83_923,
    39_873, 11_656, 70_458, 84_033, 39_535, 32_254, 61_992, 29_791, 54_348,
    19_270, 85_744, 96_599, 30_579, 45_856, 50_586, 23_436, 60_158, 60_361,
    78_825, 10_426, 96_035, 15_499, 20_954, 22_388, 81_163, 91_634, 32_022,
    91_628, 62_766, 69_120, 90_633, 10_409, 12_777, 34_714, 79_836, 10_520,
    62_340, 39_720, 46_519, 61_520, 33_304, 36_117, 70_466, 64_757, 21_216,
    18_545, 93_089, 93_798, 82_130, 25_802, 84_789, 40_909, 71_607, 58_121,
    96_176, 57_256, 45_369, 14_089, 62_274, 93_696, 87_893, 70_203, 64_881,
    25_012, 61_533, 42_375, 71_157, 83_004, 91_731, 80_380, 84_931, 84_992,
    18_938, 53_302, 54_031, 53_733, 70_053, 94_922, 51_039, 95_907, 48_755,
    71_863, 26_925, 78_898, 42_515, 73_641, 76_761, 81_003, 78_110, 43_324,
    21_609, 82_606, 81_882, 33_483, 94_856, 83_072, 95_776, 49_704, 38_311,
    18_526, 34_486, 86_291, 48_231, 58_843, 39_909, 48_028, 56_310, 99_185,
    17_336, 92_522, 13_402, 32_705, 48_232, 57_780, 81_213, 98_451, 99_334,
    20_346, 23_437, 10_188, 36_257, 56_471, 16_660, 67_004, 42_043, 73_986,
    22_940, 14_788, 17_351, 93_467, 45_821, 50_930, 97_634, 43_212, 74_266,
    54_839, 21_639, 46_195, 51_737, 42_702, 33_691, 27_068, 82_599, 39_389,
    20_089, 43_676, 40_624, 69_489, 57_102, 85_599, 28_855, 61_910, 72_866,
    89_253, 92_040, 79_472, 86_424, 37_352, 85_210, 89_903, 80_026, 88_961,
    38_159, 35_620, 93_003, 48_646, 44_325, 82_076, 74_069, 18_067, 99_684,
    21_031, 90_638, 57_199, 82_205, 71_149, 58_191, 47_303, 36_022, 72_656,
    55_308, 19_095, 46_635, 15_506, 40_226, 25_646, 44_326, 74_259, 83_125,
    85_377, 49_474, 77_096, 32_334, 88_697, 13_865, 48_113, 15_017, 61_694,
    27_654, 79_058, 32_035, 20_212, 51_434, 89_681, 38_356, 40_535, 35_913,
    20_493, 65_172, 20_026, 74_410, 63_206, 39_064, 57_312, 42_601, 56_746,
    13_866, 56_073, 89_828, 43_617, 68_234, 17_714, 91_242, 61_907, 45_542,
    56_287, 33_780, 81_704, 95_069, 54_245, 10_776, 15_551, 47_590, 71_220,
    20_160, 93_991, 59_450, 71_333, 42_520, 54_366, 31_338, 94_941, 13_396,
    74_187, 10_131, 34_774, 36_723, 45_677, 13_499, 15_009, 84_895, 74_165,
    18_259, 98_209, 80_104, 69_709, 68_814, 97_541, 73_729, 72_978, 58_000,
    63_119, 40_369, 90_150, 52_608, 71_077, 31_624, 38_760, 91_176, 63_143,
    91_823, 34_818, 59_892, 17_484, 30_905, 32_038, 36_181, 61_442, 52_676,
    84_219, 66_449, 22_863, 23_017, 79_892, 82_803, 83_319, 30_234, 73_499,
    46_440, 95_631, 81_128, 74_448, 14_447, 32_611, 57_781, 64_820, 68_420,
    47_754, 34_335, 29_717, 89_191, 82_795, 16_549, 82_556, 99_163, 18_471,
    56_195, 89_300, 46_990, 81_806, 38_774, 75_955, 56_634, 14_693, 53_016,
    73_961, 62_726, 73_112, 95_820, 89_033, 18_786, 37_161, 65_250, 37_464,
    86_725, 85_011, 67_737, 98_362, 34_884, 32_918, 44_619, 80_495, 55_837,
    60_689, 44_176, 39_854, 13_045, 40_466, 97_137, 19_527, 88_017, 31_622,
    79_812, 55_320, 99_675, 10_226, 58_609, 92_126, 85_290, 79_783, 93_581,
    90_551, 40_558, 39_089, 32_385, 16_747, 20_505, 70_730, 48_459, 66_724,
    26_340, 11_972, 85_523, 76_588, 15_882, 84_892, 17_238, 72_970, 63_431,
    90_427, 57_232, 64_933, 56_557, 89_980, 39_968, 22_733, 64_872, 58_936,
    75_725, 28_054, 72_081, 25_950, 35_455, 61_813, 41_704, 79_271, 23_953,
    46_535, 63_102, 30_834, 64_012, 68_305, 94_295, 40_622, 91_004, 64_037,
    11_981, 94_012, 78_178, 61_342, 46_974, 57_688, 64_308, 44_044, 36_812,
    46_898, 37_454, 96_884, 52_528, 56_661, 91_311, 94_931, 87_647, 57_203,
    21_346, 61_629, 93_631, 81_359, 66_314, 13_411, 15_431, 62_759, 84_813,
    71_791, 83_838, 90_129, 98_160, 33_794, 71_088, 85_754, 85_337, 54_712,
    43_618, 25_861, 59_485, 20_950, 59_143, 19_018, 99_973, 35_822, 31_306,
    92_941, 92_804, 62_182, 93_200, 79_238, 56_028, 26_131, 55_412, 40_092,
    89_193, 84_584, 58_395, 70_934, 27_303, 41_447, 15_725, 69_760, 81_266,
    95_326, 89_236, 45_408, 65_803, 23_823, 82_448, 12_317, 63_704, 31_591,
    60_656, 84_397, 15_943, 69_553, 67_670, 29_623, 45_656, 57_563, 35_401,
    29_524, 10_799, 20_503, 31_145, 24_662, 88_787, 77_284, 81_111, 96_401,
    45_881, 14_096, 31_716, 96_178, 11_460, 22_663, 17_066, 48_248, 47_906,
    60_675, 14_382, 62_222, 99_668, 16_029, 20_810, 11_971, 70_446, 95_100,
    81_776, 56_409, 78_955, 15_972, 82_762, 40_585, 82_715, 13_035, 41_208,
    75_405, 52_968, 89_777, 47_910, 17_844, 78_842, 96_933, 84_401, 22_335,
    38_772, 10_235, 64_002, 97_099, 19_165, 94_851, 11_044, 30_088, 92_285,
    90_624, 54_999, 56_563, 93_006, 77_028, 63_496, 59_288, 19_260, 65_456,
    76_020, 71_510, 38_373, 95_329, 81_785, 73_967, 55_970, 75_253, 67_687,
    26_178, 31_644, 85_675, 98_065, 47_206, 68_588, 81_859, 81_781, 12_100,
    76_959, 62_721, 47_728, 80_148, 36_073, 77_828, 60_402, 20_533, 67_535,
    86_024, 45_988, 79_733, 36_916, 91_726, 89_614, 91_991, 48_407, 41_683,
    61_197, 23_055, 76_099, 34_782, 79_495, 56_038, 75_701, 90_211, 91_105,
    26_571, 70_643, 96_461, 97_211, 83_364, 37_258, 76_258, 77_897, 90_589,
    53_899, 59_814, 99_348, 45_978, 21_550, 28_503, 70_361, 38_176, 27_681,
    34_616, 63_530, 93_477, 38_551, 30_281, 85_761, 54_185, 34_284, 90_875,
    50_159, 73_017, 70_427, 13_241, 43_718, 58_491, 61_676, 59_141, 68_941,
    99_683, 11_312, 12_988, 58_625, 38_011, 31_122, 72_187, 83_040, 35_538,
    26_926, 20_473, 65_791, 90_431, 44_240, 68_127, 88_606, 82_666, 63_367,
    66_772, 34_590, 10_183, 54_013, 88_038, 85_275, 29_557, 91_185, 91_026,
    47_846, 58_439, 17_800, 50_614, 20_747, 50_825, 92_963, 86_545, 32_892,
    41_415, 52_966, 94_229, 24_717, 90_893, 91_788, 20_609, 83_204, 25_338,
    51_397, 93_636, 37_898, 93_231, 74_840, 50_972, 24_441, 45_678, 74_739,
    40_860, 30_257, 62_026, 55_422, 78_640, 34_047, 72_688, 71_214, 29_061,
    81_733, 30_705, 45_282, 70_052, 85_605, 67_848, 29_579, 21_750, 44_657,
    14_712, 66_229, 69_289, 74_346, 63_305, 35_229, 99_323, 17_588, 17_774,
    89_787, 41_204, 62_131, 43_849, 39_529, 40_983, 24_893, 45_386, 56_318,
    68_530, 25_873, 94_040, 36_153, 88_010, 79_130, 71_226, 29_354, 87_872,
    27_909, 99_432, 10_868, 26_181, 11_684, 93_130, 63_372, 78_345, 75_999,
    87_508, 79_511, 51_818, 79_942, 84_855, 87_913, 47_101, 50_727, 20_430,
    74_052, 63_972, 32_279, 83_960, 57_325, 91_674, 78_735, 72_213, 65_775,
    78_046, 92_992, 61_673, 90_012, 73_742, 64_602, 34_277, 38_771, 83_906,
    54_798, 48_992, 39_017, 17_400, 48_587, 37_271, 59_764, 63_559, 21_472,
    70_180,
  ]
  let right_list = [
    63_343, 98_209, 84_541, 44_413, 22_440, 95_042, 69_434, 96_178, 89_783,
    65_775, 86_545, 46_651, 99_338, 33_222, 58_577, 60_478, 39_698, 65_226,
    43_676, 32_152, 63_686, 68_183, 59_626, 72_213, 69_756, 99_901, 34_754,
    69_920, 90_232, 99_343, 30_403, 81_128, 71_770, 84_748, 83_319, 16_660,
    77_290, 79_793, 51_397, 54_288, 39_301, 15_346, 25_788, 36_723, 56_814,
    47_590, 20_602, 99_803, 15_499, 62_268, 85_794, 69_492, 16_660, 94_756,
    16_660, 77_911, 16_911, 27_192, 69_368, 16_852, 63_474, 86_545, 14_040,
    58_936, 42_875, 33_787, 43_007, 33_044, 33_020, 58_953, 71_779, 37_855,
    44_413, 33_097, 65_775, 12_043, 65_011, 58_936, 73_771, 75_263, 40_144,
    46_651, 82_666, 68_710, 42_030, 41_887, 66_749, 10_759, 17_588, 65_785,
    32_822, 10_671, 33_787, 61_585, 86_677, 34_669, 82_748, 15_919, 96_178,
    39_195, 75_263, 97_137, 98_209, 86_545, 82_221, 31_680, 77_212, 71_947,
    88_874, 15_893, 15_499, 22_506, 43_676, 65_775, 27_456, 43_676, 96_178,
    83_319, 15_099, 83_628, 28_949, 15_320, 62_844, 94_756, 78_110, 71_843,
    50_003, 83_319, 84_973, 97_137, 58_936, 71_077, 51_397, 31_580, 70_574,
    91_230, 47_962, 62_092, 69_230, 43_676, 81_128, 95_485, 80_445, 51_648,
    82_950, 94_033, 43_676, 10_573, 44_413, 90_107, 80_341, 16_066, 96_086,
    76_671, 76_136, 15_499, 65_775, 77_212, 29_953, 90_054, 94_756, 10_470,
    81_128, 15_499, 34_853, 24_071, 51_397, 18_881, 58_690, 44_338, 15_499,
    26_678, 14_024, 86_545, 16_660, 17_794, 47_000, 44_413, 63_493, 62_268,
    58_936, 31_131, 78_110, 86_516, 93_231, 58_936, 36_675, 78_110, 44_473,
    67_378, 86_545, 36_723, 71_355, 52_609, 42_937, 78_110, 94_756, 59_217,
    10_605, 86_545, 86_545, 31_914, 75_151, 78_110, 95_575, 46_024, 44_413,
    93_619, 89_448, 47_590, 38_714, 55_404, 65_775, 75_308, 70_078, 84_512,
    11_398, 71_691, 47_992, 80_252, 63_054, 97_845, 51_633, 56_796, 54_493,
    78_110, 85_023, 63_420, 60_621, 26_035, 82_029, 43_676, 17_802, 86_545,
    52_247, 18_538, 98_474, 62_268, 40_947, 83_944, 45_922, 65_458, 50_197,
    33_788, 13_744, 86_043, 51_397, 97_022, 39_670, 21_616, 69_962, 46_651,
    65_775, 94_756, 97_582, 52_076, 57_704, 51_397, 58_840, 62_284, 60_129,
    83_319, 39_021, 52_720, 86_545, 56_735, 48_223, 75_263, 42_421, 75_263,
    75_043, 26_790, 39_888, 65_775, 22_157, 47_033, 26_469, 58_936, 65_775,
    47_590, 12_789, 86_967, 93_561, 82_666, 53_152, 51_397, 63_580, 46_248,
    83_150, 56_877, 81_128, 80_671, 58_936, 30_843, 11_107, 33_787, 41_883,
    88_519, 26_411, 15_214, 31_131, 53_943, 20_072, 32_606, 93_116, 82_666,
    85_274, 66_304, 25_703, 82_087, 16_035, 46_651, 15_775, 25_691, 86_545,
    52_366, 57_806, 70_700, 82_666, 13_915, 68_975, 64_780, 93_231, 32_347,
    82_998, 47_590, 81_455, 15_499, 96_178, 91_213, 15_752, 67_234, 59_510,
    73_415, 49_323, 95_736, 48_723, 94_756, 96_229, 97_137, 29_503, 24_905,
    82_666, 85_585, 73_819, 81_018, 69_309, 67_505, 58_936, 82_666, 65_775,
    83_118, 66_474, 47_428, 54_877, 83_319, 96_178, 82_666, 25_942, 23_575,
    75_135, 90_530, 83_319, 47_590, 68_349, 64_681, 35_360, 31_098, 69_116,
    31_433, 25_809, 44_054, 84_748, 86_545, 77_212, 16_406, 15_400, 67_976,
    57_521, 38_333, 36_299, 65_775, 86_545, 98_399, 77_212, 71_149, 85_822,
    93_951, 90_428, 18_069, 58_936, 44_413, 94_311, 78_875, 60_474, 99_820,
    81_128, 38_529, 52_573, 58_936, 13_961, 24_493, 81_128, 28_571, 10_225,
    82_452, 86_545, 31_313, 13_207, 73_214, 81_342, 65_775, 37_220, 49_204,
    53_561, 65_493, 71_555, 64_319, 49_581, 79_607, 44_382, 78_110, 44_570,
    51_736, 81_128, 66_424, 82_666, 91_300, 11_138, 75_493, 81_128, 93_132,
    65_809, 86_545, 84_748, 22_750, 35_768, 75_874, 91_593, 30_523, 51_397,
    78_110, 84_035, 74_404, 30_968, 31_719, 41_786, 85_504, 93_207, 31_131,
    83_100, 86_545, 68_239, 80_074, 40_950, 96_178, 93_460, 51_622, 54_328,
    98_209, 54_835, 17_337, 45_562, 83_519, 92_714, 83_089, 46_303, 47_329,
    28_184, 88_224, 97_215, 84_428, 48_130, 15_499, 44_103, 86_108, 81_924,
    93_231, 47_816, 44_413, 91_465, 34_269, 35_048, 58_120, 90_143, 83_319,
    46_651, 87_849, 96_178, 96_178, 62_370, 29_548, 39_436, 62_854, 84_748,
    81_674, 44_413, 95_171, 92_615, 38_291, 93_044, 77_212, 58_936, 40_887,
    16_660, 44_413, 11_840, 36_429, 54_199, 17_281, 79_577, 58_936, 92_055,
    94_756, 58_936, 73_911, 89_669, 94_756, 51_397, 65_016, 42_381, 45_602,
    44_587, 44_461, 76_437, 46_651, 52_123, 24_331, 22_177, 65_775, 84_266,
    67_988, 71_149, 64_219, 64_088, 57_333, 22_484, 77_514, 23_617, 93_880,
    44_413, 85_985, 17_063, 15_499, 57_907, 45_074, 53_662, 31_131, 52_394,
    91_020, 10_077, 92_012, 81_782, 43_179, 68_422, 54_313, 96_178, 43_676,
    79_195, 26_319, 69_409, 54_308, 44_086, 45_910, 52_487, 81_128, 51_397,
    40_038, 54_195, 12_679, 94_621, 56_205, 77_870, 69_865, 39_180, 21_522,
    11_165, 85_476, 95_829, 39_512, 56_835, 77_212, 36_723, 51_199, 47_590,
    41_001, 11_266, 24_707, 66_290, 34_912, 78_110, 52_705, 15_541, 82_666,
    71_149, 70_352, 91_638, 87_532, 85_803, 71_074, 46_651, 40_619, 71_149,
    85_393, 69_012, 35_643, 86_545, 84_682, 59_407, 20_816, 58_936, 26_119,
    37_733, 15_499, 31_664, 98_957, 33_324, 15_499, 25_493, 86_494, 51_653,
    41_106, 96_797, 94_721, 91_509, 51_458, 72_833, 63_182, 79_623, 88_188,
    71_149, 17_064, 71_465, 12_008, 58_318, 78_663, 23_440, 46_651, 12_527,
    96_178, 45_987, 43_676, 43_676, 72_213, 58_936, 38_918, 17_588, 46_651,
    42_051, 21_742, 48_556, 34_333, 90_524, 62_864, 82_666, 80_050, 65_775,
    51_397, 16_358, 99_706, 31_885, 77_212, 93_454, 75_521, 36_180, 43_676,
    58_936, 51_397, 84_700, 98_209, 36_723, 96_178, 62_268, 38_826, 99_043,
    31_131, 77_212, 15_499, 39_106, 66_201, 97_137, 41_721, 86_233, 64_847,
    97_749, 44_413, 69_675, 42_497, 24_086, 95_939, 64_142, 58_936, 53_614,
    57_234, 97_137, 99_439, 58_102, 89_352, 83_319, 15_499, 31_229, 46_651,
    40_668, 86_629, 71_628, 40_846, 20_397, 41_118, 11_366, 57_937, 33_787,
    92_772, 77_212, 81_128, 97_137, 17_588, 42_052, 27_806, 13_760, 77_212,
    84_748, 91_121, 44_830, 97_137, 79_257, 64_393, 53_398, 17_099, 13_089,
    18_687, 86_545, 70_385, 63_170, 71_024, 82_413, 63_222, 98_209, 19_344,
    14_882, 90_152, 66_877, 35_794, 57_101, 43_676, 32_513, 12_929, 43_676,
    51_397, 37_848, 77_408, 41_390, 92_716, 71_149, 78_110, 86_308, 83_319,
    39_043, 91_837, 91_515, 72_526, 32_320, 53_321, 81_516, 31_131, 19_663,
    43_676, 90_850, 61_111, 42_621, 44_413, 93_231, 16_304, 82_666, 78_110,
    47_590, 78_110, 15_499, 77_350, 15_499, 65_024, 81_128, 51_397, 97_112,
    22_355, 43_676, 51_397, 65_775, 22_445, 67_760, 34_895, 96_369, 17_237,
    12_327, 92_743, 82_465, 57_620, 81_128, 43_217, 51_397, 67_838, 65_775,
    93_819, 74_424, 90_048, 67_049, 78_110, 77_956, 61_361, 44_413, 34_105,
    72_068, 75_738, 31_131, 29_960, 96_116, 77_059, 79_362, 35_325, 59_877,
    55_619, 23_825, 86_872, 33_461, 41_646, 39_006, 43_478, 78_110, 15_499,
    94_756, 91_161, 15_499, 88_916, 44_413, 44_413, 93_856, 77_212, 42_058,
    32_695, 77_048, 33_487, 85_570, 56_360, 86_914, 81_927, 21_499, 28_296,
    22_467, 44_413, 75_581, 73_319, 84_796, 55_625, 44_413, 99_602, 47_529,
    74_769, 96_178, 13_264, 54_979, 19_401, 43_676, 60_980, 16_660, 72_268,
    14_779, 71_077, 97_137, 75_263, 65_302, 31_131, 59_555, 84_748, 65_186,
    36_723, 91_525, 17_103, 72_306, 86_803, 51_830, 85_444, 61_242, 98_854,
    50_418, 13_040, 79_381, 23_120, 99_140, 19_555, 46_049, 64_971, 59_315,
    49_777, 15_575, 46_570, 15_057, 73_249, 31_131, 58_936, 92_333, 93_231,
    58_936, 88_577, 88_541, 74_087, 87_061, 56_483, 62_016, 16_300, 43_676,
    67_689, 10_504, 74_316, 82_666, 31_557, 41_209, 25_384, 58_936, 25_473,
    25_169, 54_797, 97_408, 68_168, 83_319, 15_499, 11_173, 37_393, 35_203,
    43_246, 51_397, 43_240, 78_110, 48_302, 43_676, 96_098, 81_128, 30_312,
    71_712, 73_470, 77_212, 47_590, 83_224, 34_788, 43_702, 94_505, 41_455,
    55_855, 42_309, 79_923, 86_545, 54_142, 78_110, 10_679, 70_963, 74_238,
    65_520, 27_102, 48_012, 51_794, 81_810, 78_110, 55_575, 69_499, 96_178,
    35_360, 85_378, 64_013, 38_589, 88_979, 96_178, 12_601, 16_660, 78_110,
    10_988, 58_139, 32_116, 82_666, 44_413, 17_561, 86_390, 15_499, 74_982,
    31_131, 19_498, 58_879, 91_669, 23_296, 10_252, 19_600, 62_538, 75_263,
    39_169, 86_743, 27_160, 97_272, 46_651, 78_110, 98_477, 55_088, 92_869,
    11_171,
  ]

  compare_two_lists(left_list, right_list)
}
