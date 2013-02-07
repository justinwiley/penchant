-include("defs.hrl").
-module(pen).


-export([sum/1]).
-export([get_valences/0]).
-export([create_val_table/1]).
-export([db/1]).


% db(Msg) when not is_list(Msg) ->
%   io:format("~p ~n", [Msg]);
db(Msg) when is_list(Msg) ->
  io:format("~p ~n", [string:join(Msg," ")]).


% get valences which come in as [{valence, "Abandom", 2}...]
% destructure to Val, Score for use with ets
get_valences() ->
  {_, Valences} = file:consult(?AFE),
  db("Loading valences"),
  [ {Val, Score}  || {_, Val, Score} <- Valences ].

create_val_table(Valences) ->
  db("Creating valence table for "),
  db(length(Valences)),
  db("valences"),
  ets:new(?VT),
  [ ets:insert(?VT, {Val, Score}) || {Val, Score} <- Valences ]. 



% -export([draw/1]).
% -export([rev/1]).
% -export([rev/2]).


% % [] -> []
% % [x] -> [x]
% % [x,y] -> [y,x]
% % [x,y,z] -> [z,y,x]

% % non-tail recursive
% rev([]) -> [];
% rev([X]) -> [X];
% rev([X | TheRest]) ->
%   io:format("X: ~w, TheRest: ~w ~n",[X, TheRest]),
%   rev(TheRest) ++ [X].

% % tail recursive
% rev([],Res) -> Res;
% rev([X | TheRest], Res) ->
%   io:format("X: ~w, TheRest: ~w, Res: ~w ~n",[X, TheRest, Res]),
%   rev(TheRest, [X | Res]).


sum(0) -> 0;
sum(N) ->
  io:format("sum ~w.~n",[N]),
  sum(N -1) + N.

% draw(N) when N < 0 ->
%   io:format("N < 1 ~w.~n",[N]),
%   draw(N-1) + N;
% draw(N) when N == 0 ->
%   io:format("N == 0 ~w.~n",[N]),
%   0;
% draw(N) when N >= 1 ->
%   io:format("N >= 1 ~w.~n",[N]),
%   draw(N-1) + N.