
:- use_module(rules_daily, [get_all/1, get_one/2]).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_open)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_cors)).

:- http_handler(root(get_classic), get_classic_handler, [method(get), cors([])]).
:- http_handler(root(get_quote), get_quote_handler, [method(get), cors([])]).
:- http_handler(root(get_emojis), get_emojis_handler, [method(get), cors([])]).
:- http_handler(root(get_monster), get_monster_handler, [method(get), cors([])]).
:- http_handler(root(get_all), get_all_handler, [method(get), cors([])]).
:- http_handler(root(get_one), get_one_handler, [method(get), cors([])]).
:- http_handler(root(get_correct_quote), get_correct_quote_handler, [method(get), cors([])]).
:- http_handler(root(get_correct_emoji), get_correct_emoji_handler, [method(get), cors([])]).

get_classic_handler(Request) :-
    cors_enable,
    http_parameters(Request, [id(ID, [integer])]),
    check_classico(ID, Dic),
    reply_json(Dic).

get_monster_handler(Request) :-
    http_parameters(Request, [id(ID, [integer])]),
    check_monster(ID, Dic),
    reply_json(Dic).

get_quote_handler(Request) :-
    http_parameters(Request, [id(ID, [integer])]),
    check_falas(ID, _, Dic),
    reply_json(Dic).

get_emojis_handler(Request) :-
    http_parameters(Request, [id(ID, [integer])]),
    check_emojis(ID,_, Dic),
    reply_json(Dic).

get_all_handler(_Request):-
    get_all(List),
    reply_json(List).

get_one_handler(Request):-
    http_parameters(Request, [id(ID, [integer])]),
    get_one(ID,Dic),
    reply_json(Dic).

get_correct_quote_handler(Request) :-
   % http_parameters(Request, [id(ID, [integer])]),
    daily_entity(ID, "quote"),
    personagem(ID,_,_,_,_,_,_,_,_,_,_,Quote),
    reply_json(_{quote: Quote}).

get_correct_emoji_handler(Request) :-
    % http_parameters(Request, [id(ID, [integer])]),
    daily_entity(ID, "emojis"),
    personagem(ID,_,_,_,_,_,_,_,_,Emojis,_,_),
    reply_json(_{emoji: Emojis}).




start_server :-
    http_server([port(8080)]).

