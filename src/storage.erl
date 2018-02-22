-module(storage).
-export([new/0, add/3, delete/2, find/2, is_defined/2]).

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
    
