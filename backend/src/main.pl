:- [carrega_dados].
:- [set_daily].
:- [check].
:- use_module(json_to_facts, [personagem/12, monstro/3, carregar_json/4]).
:- use_module(library(persistency)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- initialization(main).

:- http_handler(root(get_classic), get_classic_handler, []).
:- http_handler(root(get_quote), get_quote_handler, []).
:- http_handler(root(get_emojis), get_emojis_handler, []).
:- http_handler(root(get_monster), get_monster_handler, []).


get_classic_handler(Request) :-
    http_parameters(Request, [id(ID, [integer])]),
    check_classico(ID, Dic),
    % json:json_write_dict(Stream, Dic, []),
    reply_json(Dic).


main :-
    absolute_file_name('fact.db', File, [access(write)]),
    db_attach(File, []),
    carregar,
    http_server(http_dispatch, [port(8080)]).

