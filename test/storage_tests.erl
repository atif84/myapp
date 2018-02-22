-module(storage_tests).
-include_lib("eunit/include/eunit.hrl").

create_a_new_storage_test() ->
    Res = storage:new(),
    ?assertEqual([], Res).

add_a_pair_into_new_storage_test() ->
    Res = storage:add(key, value, storage:new()),
    ?assertEqual([{key, value}], Res).

add_a_pair_into_storage_with_a_pair_test() ->
    Res = storage:add(key2, value2, [{key1, value1}]),
    ?assertEqual([{key2, value2}, {key1, value1}], Res).

delete_a_pair_from_storage_with_a_pair_test() ->
    Storage = [{key, value}],
    NewStorage = storage:delete(key, Storage),
    ?assertEqual([], NewStorage).

find_a_pair_associated_with_a_key_test() ->
    Storage = [{key1, value1}, {key2, value2}],
    Res = storage:find(key2, Storage), 
    ?assertEqual([{key2, value2}], Res).

key_is_defined_in_storage_test() ->
    Storage = [{key1, value1}, {key2, value2}],
    Res = storage:is_defined(key2, Storage), 
    ?assert(Res).

key_is_not_defined_in_storage_test() ->
    Storage = [{key1, value1}, {key2, value2}],
    Res = storage:is_defined(key, Storage), 
    ?assertNot(Res).
