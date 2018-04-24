-module(robot_tests).
-include_lib("eunit/include/eunit.hrl").

join_file_with_directory(F) ->
    {ok, Dir} = file:get_cwd(),
    filename:join([Dir, F]).

readlines(FileName) ->
    {ok, Dir} = file:get_cwd(),
    F = filename:join([Dir, FileName]),
    {ok, Data} = file:read_file(F),
    L = binary:split(Data, [<<"\n">>], [global]),
    lists:map(fun erlang:binary_to_list/1, L).

check_file_test_() ->
    ?_assertEqual(true, commands_file_exsist()).

commands_file_exsist() ->
    F=join_file_with_directory("commands.txt"),
    filelib:is_file(F).

first_line_of_the_output_file_test() ->
    robot:input_from_file({{0,0}, north}, "commands.txt"), 
    F=join_file_with_directory("states.txt"),
    L=readlines(F),
    O=lists:nth(1, L),
    ?assertEqual("[][]", O).   

second_line_of_the_output_file_test() ->
    %% testing second line of the output from first_line_of_the_output_file_test()
    F=join_file_with_directory("states.txt"),   
    L=readlines(F),
    O=lists:nth(2, L),
    ?assertEqual("[north][]", O).  

second_last_line_of_the_output_file_test() ->
    F=join_file_with_directory("states.txt"),
    L=readlines(F),
    O=lists:nth(length(L) - 2, L),
    ?assertEqual("[][]", O).   

last_line_of_the_output_file_test() ->
    %% testing second line of the output from first_line_of_the_output_file_test()
    F=join_file_with_directory("states.txt"),
    L=readlines(F),
    O=lists:nth(length(L) - 1, L),
    ?assertEqual("[][east]", O). 

setup() ->
    F=join_file_with_directory("states.txt"),
    {ok, File} = file:open(F, [append]),
    File.

cleanup(File) ->
    file:close(File),
    F=join_file_with_directory("states.txt"),
    file:delete(F).

start_final_positions_of_robot_test_cases_test_() ->
    { setup,
      fun setup/0,
      fun cleanup/1,
      [fun check_file_test_/0,
       fun first_line_of_the_output_file_test/0,
       fun second_line_of_the_output_file_test/0,
       fun second_last_line_of_the_output_file_test/0,
       fun last_line_of_the_output_file_test/0 ]}.
