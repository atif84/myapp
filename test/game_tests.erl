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

%% convert_string_to_list_without_pipe_test() ->
%%    N = game:inputformatter("X|1-|5/"),
%%    ?assertEqual(["X","1","_","5","/"], N).

%% convert_string_to_list_without_pipe_with_X_test() ->
%%     N = game:inputformatter("X|X|X|X|X|X|X|X|X|X||XX"),
%%     ?assertEqual(["X","X","X","X","X","X","X","X","X","X","X","X"], N).

%% replace_symbols_and_convert_input_into_integers_test() ->
%%     N = game:replace_symbol_to_int(["X","1","-","5","/","4"]),
%%     ?assertEqual([10,1,0,5,5,4], N).



