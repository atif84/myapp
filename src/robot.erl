-module(robot).

-export([initialize/2,
	 control/1,
	 control/2,
	 move_forward/1,
	 move_backward/1,
	 get_new_direction/2,
	 read_file/0,
	 start/0]).

initialize(C, D) ->
    {C, D}.

control(R,Ins) ->
    control(R, string:trim(Ins), string:trim(Ins), 1).

control(R) ->
    Ins = read_file(),
    control(R, string:trim(Ins), string:trim(Ins), 1).

control(R, _, [], _) ->
    write_file(R),
    R;

control(R, Ins, Substr, N) ->
    I = string:slice(Substr, 0, 1),
    D = element(2, R),
    write_file(R),
    case I of I when
	      I == "r" ; I == "l" ->
	    control({element(1, R), get_new_direction(D, I)}, Ins, string:substr(Ins, N + 1, string:length(Ins)), N + 1);
	"f" ->
	    control({move_forward(R), D}, Ins, string:substr(Ins,N + 1, string:length(Ins)), N + 1);
	"b" ->
	    control({move_backward(R), D}, Ins, string:substr(Ins,N + 1, string:length(Ins)), N + 1)
    end.

get_new_direction(D, I) ->
    L = [{{north, "r"}, east},{{south, "r"}, west}, {{west, "r"}, north},{{east, "r"}, south}, {{north, "l"},west}, {{south, "l"}, east},{{west, "l"}, south}, {{east, "l"}, north}],
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
    file:write(S,"\n"),
    file:write(S, "------"),
    file:write(S,"\n"),
    file:close(S).

print_match(DrawingCoordinates, C, D) ->
    if 
	DrawingCoordinates == C -> 
	    string:concat(string:concat("[",io_lib:format("~p",[D])),"]"); 
	true ->
	    "[]"

    end.

read_file() ->
    {ok, Dir} = file:get_cwd(),
    {ok, File} = file:open(filename:join([Dir,"commands.txt"]),[read]),
    {ok,Data} = file:read(File,1024 * 1024), 
    string:trim(Data).

start() ->
    {ok, Dir} = file:get_cwd(),
    file:delete(filename:join([Dir,"states.txt"])).

