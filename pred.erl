-module(pred).

-export([sum/1]).
-export([draw/1]).
-export([rev/1]).
-export([rev/2]).

% [] -> []
% [x] -> [x]
% [x,y] -> [y,x]
% [x,y,z] -> [z,y,x]

% non-tail recursive
rev([]) -> [];
rev([X]) -> [X];
rev([X | TheRest]) ->
  io:format("X: ~w, TheRest: ~w ~n",[X, TheRest]),
  rev(TheRest) ++ [X].

% tail recursive
rev([],Res) -> Res;
rev([X | TheRest], Res) ->
  io:format("X: ~w, TheRest: ~w, Res: ~w ~n",[X, TheRest, Res]),
  rev(TheRest, [X | Res]).


sum(0) -> 0;
sum(N) ->
  io:format("sum ~w.~n",[N]),
  sum(N -1) + N.

draw(N) when N < 0 ->
  io:format("N < 1 ~w.~n",[N]),
  draw(N-1) + N;
draw(N) when N == 0 ->
  io:format("N == 0 ~w.~n",[N]),
  0;
draw(N) when N >= 1 ->
  io:format("N >= 1 ~w.~n",[N]),
  draw(N-1) + N.