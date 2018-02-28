-module(storage).
-export([new/0, add/3, delete/2, find/2, is_defined/2,find_even/1,print_x/1,reminder/1,find_even_tial_recursive/2]).

new() ->
    [].

add(Key, Value, Storage) ->
    [{Key, Value} | Storage].

delete(Key, Storage) ->
    delete(Key, Storage, []).

delete(_, [], Res) ->
    Res;
delete(Key, [{Key, _} | Storage], Acc) ->
    delete(Key, Storage, Acc);
delete(Key, [Pair | Storage], Acc) ->
    delete(Key, Storage, [Pair | Acc]).

find(Key, Storage) ->
    [Pair || Pair <- Storage, element(1, Pair) == Key].
    %% [{K, V} || {K, V} <- Storage, K == Key].

is_defined(Key, Storage) ->
    proplists:is_defined(Key, Storage).

% find even number from a list - normal recursive
find_even([])->
	[];
find_even([H|T])->
	case H rem 2 == 0 of 
		true -> 
			[H|find_even(T)] ;
		false -> 
			find_even(T)
	end.

print_x(X) ->
	X.

reminder(N) -> N rem 2.

% find even number from a list - tail recursive

find_even_tial_recursive(N,0) ->
	find_even_tial_recursive(N,[]);
 
find_even_tial_recursive([],Acc) ->
	Acc;

find_even_tial_recursive([H|T],Acc) ->
	case H rem 2 == 0 of 
		true -> 
			find_even_tial_recursive(T,[H|Acc]);
		false -> 
			find_even(T)
	end.

%% is_defined(Key, Storage) ->
%%     find(Key, Storage) /= [].

%% is_defined(_, []) ->
%%     false;
%% is_defined(Key, [{Key, _} | _] ) ->
%%     true;
%% is_defined(Key, [_ | T]) ->
%%     is_defined(Key, T).


%% delete(Key, Storage) ->
%%     [{K, V} || {K, V} <- Storage, K /= Key].
                

%% delete(_, []) ->
%%     [];
%% delete(Key, [{Key, _} | Storage]) ->
%%     delete(Key, Storage);
%% delete(Key, [Pair | Storage]) ->
%%     [Pair | delete(Key, Storage)].
   
