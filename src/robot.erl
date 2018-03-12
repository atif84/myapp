-module(robot).

-export([initialize/2,
	control/2,
	move_forward/2,
	move_backward/2, 
	get_new_direction/2]).

initialize(C, D) ->
	[C, D].

control(R, Ins) ->
	control(R, string:trim(Ins), string:trim(Ins), 1).

control(R, _, [], _) ->
	R;

control(R, Ins, Substr, N) ->
	I = string:slice(Substr, 0,1),
	D = lists:last(R),
	case I of I 
		when I == "r" ; I == "l" ->
		control([lists:nth(1, R),get_new_direction(D, I)], Ins, string:substr(Ins,N+1, string:length(Ins)), N+1);				
		"f" ->  control([move_forward(lists:nth(1, R), D), D], Ins, string:substr(Ins,N+1, string:length(Ins)), N+1);				
		"b" ->  control([move_backward(lists:nth(1, R), D), D], Ins, string:substr(Ins,N+1, string:length(Ins)), N+1);
		_ -> io:fwrite("false instruction!", [])
	end.

get_new_direction(D, I) ->
	L = [{{north, "r"}, east},{{south, "r"}, west}, {{west, "r"}, north},{{east, "r"}, south}, {{north, "l"},west}, {{south, "l"}, east},{{west, "l"}, south}, {{east, "l"}, north}],
	proplists:get_value({D, I}, L).

move_forward(C, D) ->
	case D of 
		north -> {element(1, C) , element(2, C) +1};
		south -> {element(1, C) , element(2, C) -1};	
		west -> {element(1, C) -1 , element(2, C)};
		east -> {element(1, C) +1 , element(2, C)}
	end.

move_backward(C,D) ->
	case D of 
		north -> {element(1, C), element(2, C) -1};
		south -> {element(1, C), element(2, C) +1};	
		west -> {element(1, C) +1, element(2, C)};
		east -> {element(1, C) -1, element(2, C)}
	end.