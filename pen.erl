-include("defs.hrl").
-module(pen).


-export([sum/1]).
-export([get_valences/0]).
-export([create_val_table/1]).
-export([db/1]).
-export([word_score/1]).
-export([sentence_scores/1]).
-export([init_val_table/0]).
-export([sentence_sentiment/1]).

-export([lookahead/1]).

% lookahead([]) -> ok;
% lookahead([X | Rest]) ->
%   % {Next, Rest} = Tail,
%   % io:format("chunk: ~p ~p~n", [X, Next]),
%   lookahead(Rest).


lookahead([]) -> [];
lookahead([A]) ->
  io:format("A ~p ~n", [A]);
lookahead([A | Tail]) -> 
  [B | _] = Tail,
  io:format("A, B ~p, ~p ~n", [A,B]),
  lookahead(Tail);
lookahead([A, B | Tail]) -> 
  [B, C | _] = Tail,
  io:format("A, B, C ~p, ~p ~p ~n", [A,B,C]),
  lookahead(Tail).




% lookahead([A]) ->
%   io:format("A ~p ~n", [A]);
% lookahead([A, B | Tail]) ->
%   io:format("A, B | Tail ~p, ~p, ~p ~n", [A,B,Tail]),
%   lookahead(Tail);
% lookahead([A | Tail]) -> 
%   io:format("A | Tail ~p, ~p ~n", [A,Tail]),
%   lookahead(Tail).
% lookahead([]) ->
%   [].
% loop([A, B | TheRest]) -> two_or_more;

% lookahead([]) -> 0.




sum([]) -> 0;
sum([X | Rest]) ->
  sum(Rest) + X.

db(Msg) ->
  io:format("~p ~n", [string:join(Msg," ")]).

get_valences() ->
  {_, Valences} = file:consult(?AFE),
  db(["Loading valences"]),
  [ {Val, Score}  || {_, Val, Score} <- Valences ].

create_val_table(Valences) ->
  db(["Creating valence table"]),
  ets:new(valence_table, [public, named_table]),
  [ ets:insert(valence_table, {Val, Score}) || {Val, Score} <- Valences ],
  ok.

init_val_table() ->
  create_val_table(get_valences()).

word_score(Valence) ->
  case ets:lookup(valence_table, Valence) of
    [{_, Score}] ->
      Score;
    [] -> 0
  end.

sentence_scores(String) ->
  [ pen:word_score(Valence) || Valence <- string:tokens(String, " ") ].

sentence_sentiment(String) ->
  sum(sentence_scores(String)).


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


% draw(N) when N < 0 ->
%   io:format("N < 1 ~w.~n",[N]),
%   draw(N-1) + N;
% draw(N) when N == 0 ->
%   io:format("N == 0 ~w.~n",[N]),
%   0;
% draw(N) when N >= 1 ->
%   io:format("N >= 1 ~w.~n",[N]),
%   draw(N-1) + N.