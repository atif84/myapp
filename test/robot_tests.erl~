-module(robot_tests).
-include_lib("eunit/include/eunit.hrl").

create_new_robot_test() ->
    Robo = robot:initialize({6, 1}, north),
    ?assertEqual({{6, 1}, north}, Robo).

control_return_robot_when_instruction_is_empty_test() ->
    Robo = robot:control({{6,1}, north}, []),
    ?assertEqual({{6, 1}, north}, Robo).

get_new_direction_from_proplist_test() ->
    L = robot:get_new_direction(west, "r"),
    ?assertEqual(north, L).

control_move_forward_east_test() ->
    C = robot:move_forward({{0, 6}, east}),
    ?assertEqual({1, 6}, C).

control_move_forward_west_test() ->
    C = robot:move_forward({{0, 0}, west}),
    ?assertEqual({-1, 0},C).

control_move_forward_north_test() ->
    C = robot:move_forward({{0, 0}, north}),
    ?assertEqual({0, 1}, C).

control_move_forward_south_test() ->
    C = robot:move_forward({{0, 0}, south}),
    ?assertEqual({0, -1}, C).

control_move_backward_east_test() ->
    C = robot:move_backward({{0, 6}, east}),
    ?assertEqual({-1, 6}, C).

control_move_backward_west_test() ->
    C = robot:move_backward({{0, 0}, west}),
    ?assertEqual({1, 0}, C).

control_move_backward_north_test() ->
    C = robot:move_backward({{0, 0}, north}),
    ?assertEqual({0, -1}, C).

control_move_back_south_test() ->
    C = robot:move_backward({{-10, -5}, south}),
    ?assertEqual({-10, -4}, C).

control_move_forward_AND_backward_test_control_test() ->
    L = robot:control({{0, 6}, east}, "ffbr"),
    ?assertEqual({{1, 6}, south}, L).

control_return_robot_and_input_instuction_test() ->
    L = robot:control({{6, 1}, north}, "r"),
    ?assertEqual({{6,1}, east}, L).

control_return_robot_and_input_multiple_instuctions_test() ->
    L = robot:control({{0, 0}, north}, "rrll"),
    ?assertEqual({{0, 0}, north}, L).

control_return_robot_and_input_multiple_instuctions_with_space_test() ->
    L = robot:control({{0, 0}, north}, " rrll"),
    ?assertEqual({{0,0}, north}, L).

control_return_robot_and_input_multiple_instuctions_rlfb_test() ->
    L = robot:control({{0,0}, north}, "rrllffbff"),
    ?assertEqual({{0, 3}, north}, L).
