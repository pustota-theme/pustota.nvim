-module(syntax_test).

%% Exported functions
-export([
    start/0,
    spawn_example/0,
    record_example/0,
    macro_example/1,
    function_with_guards/1,
    handle_info/1,
    list_comprehension/1,
    case_example/1,
    if_example/1,
    try_catch_example/1,
    binary_example/1,
    ets_example/0
]).

%% Macros
-define(MY_MACRO, 42).
-define(SAY_HELLO(Name), io:format("Hello, ~p!~n", [Name])).

%% Records
-record(person, {
    name  = "undefined",
    age   = 0
}).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Entry point to call from shell
start() ->
    io:format("syntax_test: Starting...~n", []),
    spawn_example(),
    record_example(),
    ?SAY_HELLO("Erlang"),
    macro_example(?MY_MACRO),
    io:format("Function with guards, input=10 => ~p~n", [function_with_guards(10)]),
    io:format("List comprehension, limit=5 => ~p~n", [list_comprehension(5)]),
    io:format("Case example, input=ok => ~p~n", [case_example(ok)]),
    io:format("If example, input=7 => ~p~n", [if_example(7)]),
    io:format("Try/catch example, input=3 => ~p~n", [try_catch_example(3)]),
    io:format("Binary example, input=<<1,2,3>> => ~p~n", [binary_example(<<1,2,3>>)]),
    ets_example(),
    ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Spawning and messaging example
spawn_example() ->
    Pid = spawn(fun() -> process_loop() end),
    Pid ! {self(), hello},
    receive
        {Pid, Response} ->
            io:format("Received from spawned process: ~p~n", [Response])
    after 2000 ->
            io:format("No response from spawned process.~n", [])
    end,
    ok.

process_loop() ->
    receive
        {Sender, Message} ->
            Sender ! {self(), {reply, Message}},
            process_loop()
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Record usage example
record_example() ->
    Person = #person{name="Alice", age=30},
    io:format("Record example: Name=~p, Age=~p~n",
              [Person#person.name, Person#person.age]),
    ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Macro usage
macro_example(Value) ->
    io:format("Macro example: ?MY_MACRO=~p, Provided=~p~n", [?MY_MACRO, Value]),
    ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function clauses and guards
function_with_guards(N) when N < 10 ->
    small;
function_with_guards(N) when N >= 10 ->
    large.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% handle_info style pattern matching
handle_info(Message) ->
    case Message of
        {hello, Name} ->
            io:format("handle_info: Hello ~p~n", [Name]),
            ok;
        _ ->
            io:format("handle_info: Unknown message ~p~n", [Message]),
            ignore
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% List comprehensions
list_comprehension(Limit) ->
    [X*X || X <- lists:seq(1, Limit), X rem 2 =:= 1].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Case expression
case_example(Value) ->
    case Value of
        ok ->
            "Everything looks good";
        error ->
            "Something went wrong";
        _ ->
            "Unknown value"
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% If expression
if_example(X) ->
    if
        X < 5 ->
            too_small;
        X < 10 ->
            medium;
        true ->
            large
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% try...catch
try_catch_example(X) ->
    try do_something(X) of
        Result -> {ok, Result}
    catch
        error:Reason ->
            {error, Reason}
    end.

do_something(X) when X < 5 ->
    X + 100;
do_something(_X) ->
    error(too_large).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Binary pattern matching
binary_example(Bin) ->
    <<A, B, Rest/binary>> = Bin,
    {A, B, Rest}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ETS example
ets_example() ->
    Table = ets:new(my_table, [public, named_table]),
    ets:insert(my_table, {key1, "value1"}),
    ets:insert(my_table, {key2, "value2"}),
    Val1 = ets:lookup(my_table, key1),
    Val2 = ets:lookup(my_table, key2),
    io:format("ETS lookup: key1 -> ~p, key2 -> ~p~n", [Val1, Val2]),
    ets:delete(my_table),
    ok.
