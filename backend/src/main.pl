:- [carrega_dados].
:- [set_daily].
:- [check].
:- use_module(json_to_facts, [personagem/12, monstro/3, carregar_json/4]).
:- use_module(library(persistency)).
:- use_module(library(http/http_cors)).
:- [routes].
:- initialization(main).

main :-
    absolute_file_name('fact.db', File, [access(write)]),
    db_attach(File, []),
    carregar,
    http_server(http_dispatch, [port(8080)]).

