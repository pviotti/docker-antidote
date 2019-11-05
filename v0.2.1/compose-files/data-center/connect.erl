#!/usr/bin/env escript
%%! -smp enable -sname erlshell -setcookie secret
main(Args) ->
    E = (catch rpc:call(antidote@dc1n1, antidote_dc_manager, create_dc, [[antidote@dc1n1, antidote@dc1n2, antidote@dc1n3]])),
    case E of
        ok -> io:format("Data centers connected!~n");
        {badrpc, {_, {{badmatch, {error, node_still_starting}}, _}}} -> main(Args);
        _ -> io:format("Error ~p~n", [E])
    end.


