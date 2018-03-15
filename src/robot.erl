-module(robot).

%% Always
%%  - indent
%%  - remove trailing whitespaces
%%  - new line after '->'
%%  - space after ','
%%  - space before and after '+'

-export([initialize/2,
    control/2,
    move_forward/2,
    move_backward/2,
    get_new_direction/2]).

%% Please update so that Robot is a tuple of Coordinate and Direction
%% whereas Coordinate is also a tuple of two, X and Y.
-spec(initialize({X, Y}, Dir) -> {{X, Y}, Dir}
initialize(C, D) ->
    [C, D].

control(R, Ins) ->
    control(R, string:trim(Ins), string:trim(Ins), 1).

control(R, _, [], _) ->
    R;

%% The control/4 function below is very heavy (too many operations and hard to read/change)
%% It is mainly because how the recursion is done.
%% Second argument is used only to calculate the legth of Instructions
%% And legth is used to check which instruction is to be handled in every recursion.
%% However in functional languages recursion is done so that the head handled first and rest is recursed.
%% The following commented out code is takes the first instruction, does something and returns a new robot.
%% Recursion uses newrobot and rest of the instructions.
%% control(R, [I | Ins]) ->
%%     NewRobot = do_something(R, I),
%%     control(NewRobot, Ins);
%% control(R, []) ->
%%     R.
control(R, Ins, Substr, N) ->
    I = string:slice(Substr, 0,1),
    D = lists:last(R),
    %% Always new line after ->
    case I of I when I == "r" ; I == "l" ->
            %% You do not need to write everything in one line
            %% It is easier to read if you make most important thing explicit.
            %% Here it is the get_newdirection function which changes the robots directions.
            %% Even better if get_new_direction function takes a robot and return a new one like following comment.
            %% NewRobot = get_new_direction(R, I)
            %% This way you do not have to make so many function call in function.
            NewRobot = [lists:nth(1, R),get_new_direction(D, I)],
            control(NewRobot, Ins, string:substr(Ins,N+1, string:length(Ins)), N+1);
        "f" ->
            %% Similar to my previous comment. Show move forward explicitly that it returns a new robot
            %% in a seperate line. Good that move_backward takes the robot and returns a new robot.
            %% However lists:nth(1, R), D) is unnecessary - use R instead.
            control([move_forward(lists:nth(1, R), D), D], Ins, string:substr(Ins,N+1, string:length(Ins)), N+1);
        "b" ->
            %% Same comment as the previous one
            control([move_backward(lists:nth(1, R), D), D], Ins, string:substr(Ins,N+1, string:length(Ins)), N+1);
        _ ->
            %% Do not prepare for things you do not expect.
            %% If you have a spec, make sure that all intructions are good.
            %% It should crash otherwise.
            io:fwrite("false instruction!", [])
    end.

%% Good idea to use proplist here.
%%Function can take a robot and return a new robot
get_new_direction(D, I) ->
    L = [{{north, "r"}, east},
         {{south, "r"}, west},
         {{west, "r"}, north},
         {{east, "r"}, south},
         {{north, "l"},west},
         {{south, "l"}, east},
         {{west, "l"}, south},
         {{east, "l"}, north}],
    proplists:get_value({D, I}, L).

%% You need first and second element.
%% Extract it once instead of calling element/2 many times.
%% live in the function head; move_forward({{X, Y}, D})
move_forward(C, D) ->
    case D of
        north ->
            {element(1, C) , element(2, C) +1};
        south ->
            {element(1, C) , element(2, C) -1};
        west ->
            {element(1, C) -1 , element(2, C)};
        east ->
            {element(1, C) +1 , element(2, C)}
    end.

%% You need first and second element.
%% Extract it once instead of calling element/2 many times.
%% live in the function head; move_backward({{X, Y}, D})
move_backward(C,D) ->
    case D of
        north ->
            {element(1, C), element(2, C) -1};
        south ->
            {element(1, C), element(2, C) +1};
        west ->
            {element(1, C) +1, element(2, C)};
        east ->
            {element(1, C) -1, element(2, C)}
    end.
