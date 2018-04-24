-module(robot).

-export([initialize/2,
	 control/2,
	 input_from_file/2]).

initialize(C, D) ->
    {C, D}.

input_from_file(R, File) ->
    Ins = read_file(File),
    control(R, string:trim(Ins)).

control(R,[]) ->
    write_file(R),
    R;

control(R, [I | Tail]) ->
    D = element(2, R),
    write_file(R),
    case I of I when
	      I == $r ; I == $l ->
	    control({element(1, R), get_new_direction(D, I)}, Tail);
	$f ->
	    control({move_forward(R), D}, Tail);
	$b ->
	    control({move_backward(R), D}, Tail);
	_ ->	
	    control(R, Tail)	   
    end.

get_new_direction(D, I) ->
    L = [{{north, $r}, east},
	 {{south, $r}, west},
	 {{west, $r}, north},
	 {{east, $r}, south}, 
	 {{north, $l},west}, 
	 {{south, $l}, east},
	 {{west, $l}, south} ,
	 {{east, $l}, north}],
    proplists:get_value({D, I}, L).

move_forward({{X, Y}, D}) ->
    case D of 
	north -> {X , Y + 1};
	south -> {X , Y - 1};
	west -> {X - 1 , Y};
	east -> {X + 1 , Y}
    end.

move_backward({{X, Y}, D}) ->
    case D of 
	north -> {X, Y - 1};
	south -> {X, Y + 1};
	west -> {X + 1, Y};
	east -> {X - 1, Y}
    end.

write_file({{X,Y},D}) ->
    {ok, Dir} = file:get_cwd(),
    {ok, S} = file:open(filename:join([Dir,"states.txt"]),[append]),
    file:write(S, print_match({0,1},{X,Y},D)), 
    file:write(S, print_match({1,1},{X,Y},D)), 
    file:write(S,"\n"),
    file:write(S, print_match({0,0},{X,Y},D)),
    file:write(S, print_match({1,0},{X,Y},D)),
    file:write(S,"\n").

print_match(DrawingCoordinates, C, D) ->
    if 
	DrawingCoordinates == C -> 
	    string:concat(string:concat("[",io_lib:format("~p",[D])),"]"); 
	true ->
	    "[]"
    end.

read_file(File_name) ->
    {ok, Dir} = file:get_cwd(),
    F = filename:join([Dir, File_name]),
    case filelib:is_file(F) of
	true ->
	    {ok, File} = file:open(F, [read]),
	    {ok,Data} = file:read(File, 1024 * 1024), 
	    string:trim(Data)

    end.
