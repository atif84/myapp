-module(robot).

-export([initialize/2,
	 control/2,
	 move_forward/1,
	 move_backward/1,
	 get_new_direction/2]).

initialize(C, D) ->
    {C, D}.

control(R, Ins) ->
    control(R, string:trim(Ins), string:trim(Ins), 1).

control(R, _, [], _) ->
    R;

control(R, Ins, Substr, N) ->
    I = string:slice(Substr, 0, 1),
    D = element(2, R),
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
