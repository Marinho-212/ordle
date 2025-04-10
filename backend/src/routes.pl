:- use_module(rules_daily, [get_all/1, get_one/2]).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_cors)).

:- set_setting(http:cors, [*]).

:- http_handler(root(get_classic), get_classic_handler, [method(get), cors]).
:- http_handler(root(get_quote), get_quote_handler, [method(get), cors]).
:- http_handler(root(get_emojis), get_emojis_handler, [method(get), cors]).
:- http_handler(root(get_monster), get_monster_handler, [method(get), cors]).
:- http_handler(root(get_all), get_all_handler, [method(get), cors]).
:- http_handler(root(get_one), get_one_handler, [method(get), cors]).
:- http_handler(root(get_correct), get_correct_handler, [method(get), cors]).
:- http_handler(root(get_correct_emoji), get_correct_emoji_handler, [method(get), cors]).
:- http_handler(root(.), root_handler, [method(get), cors]).
:- http_handler(root(.), handle_options, [method(options), prefix]).

handle_options(_Request) :-
    cors_enable,
    format('Content-type: text/plain~n~n').

root_handler(_Request) :-
    cors_enable,
    format('Content-type: text/plain~n~n'),
    format('Backend Prolog está rodando!~n').

get_classic_handler(Request) :-
    cors_enable,
    http_parameters(Request, [id(ID, [integer])]),
    check_classico(ID, Dic),
    reply_json(Dic).

get_monster_handler(Request) :-
    cors_enable,
    http_parameters(Request, [id(ID, [integer])]),
    check_monster(ID, Dic),
    reply_json(Dic).

get_quote_handler(Request) :-
    cors_enable,
    http_parameters(Request, [id(ID, [integer])]),
    check_falas(ID, _, Dic),
    reply_json(Dic).

get_emojis_handler(Request) :-
    cors_enable,
    http_parameters(Request, [id(ID, [integer])]),
    check_emojis(ID, _,Dic),
    reply_json(Dic).

get_all_handler(_Request):-
    cors_enable,
    get_all(List),
    reply_json(List).

get_one_handler(Request):-
    cors_enable,
    http_parameters(Request, [id(ID, [integer])]),
    get_one(ID,Dic),
    reply_json(Dic).

get_correct_handler(_Request) :-
    cors_enable,
    daily_entity(ID, "quote"),
    personagem(ID,_,_,_,_,_,_,_,_,_,_,Quote),
    reply_json(_{quote: Quote}).

get_correct_emoji_handler(_Request) :-
    cors_enable,
    daily_entity(ID, "emojis"),
    personagem(ID,_,_,_,_,_,_,_,_,Emojis,_,_),
    reply_json(_{emoji: Emojis}).