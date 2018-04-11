-module(game_tests).
-include_lib("eunit/include/eunit.hrl").

convert_string_to_list_with_strike_test() ->
    N = game:inputformatter("X|1-|5/4"),
    ?assertEqual([10,1,0,5,5,4], N).

calculate_score_with_strike_test() ->
    N = game:calc_score([10,1,0,5,5,4]),
    ?assertEqual(30, N).

convert_string_to_list_with_multipipe_test() ->
    N = game:inputformatter("9-|9-|9-|9-|9-|9-|9-|9-|9-|9-||"),
    ?assertEqual([9,0,9,0,9,0,9,0,9,0,9,0,9,0,9,0,9,0,9,0], N).

calculate_score__with_multipipe_test() ->
    N = game:calc_score([9,0,9,0,9,0,9,0,9,0,9,0,9,0,9,0,9,0,9,0]),
    ?assertEqual(90, N).

convert_string_to_list_with_spare_bonus_test() ->
    N = game:inputformatter("5/|5/|5/|5/|5/|5/|5/|5/|5/|5/||5"),
    ?assertEqual([5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5], N).

calculate_score__with_spare_bonus_test() ->
    N = game:calc_score([5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5]),
    ?assertEqual(155, N).


five_pins_hit_on_each_frame_of_all_ten_frames_test() ->
    TenFrames = "32|32|32|32|32|32|32|32|32|32||",
    Res = game:score(TenFrames),
    ?assertEqual(50, Res).

nine_pins_hit_on_the_first_ball_of_all_ten_frames_test() ->
    TenFrames = "9-|9-|9-|9-|9-|9-|9-|9-|9-|9-||",
    Res = game:score(TenFrames),
    ?assertEqual(90, Res).

nine_pins_hit_on_the_second_ball_of_all_ten_frames_test() ->
    TenFrames = "-9|-9|-9|-9|-9|-9|-9|-9|-9|-9||",
    Res = game:score(TenFrames),
    ?assertEqual(90, Res).

five_pins_on_the_first_ball_of_all_ten_frames_test() ->
    TenFrames = "5/|5/|5/|5/|5/|5/|5/|5/|5/|5/||5",
    Res = game:score(TenFrames),
    ?assertEqual(150, Res).

ten_strikes_on_the_first_ball_of_all_ten_frames_test() ->
    TenFrames = "X|X|X|X|X|X|X|X|X|X||XX",
    Res = game:score(TenFrames),
    ?assertEqual(300, Res).

mix_of_spare_and_strike_test() ->
    TenFrames = "5/|X|5/|X|5/|-/|X|-/|X|--||",
    Res = game:score(TenFrames),
    ?assertEqual(160, Res).
