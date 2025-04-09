:- [carrega_dados].
:- [set_daily].
:- use_module(json_to_facts, [personagem/12, monstro/3, carregar_json/4]).
:- use_module(library(persistency)).
:- initialization(main).

:- http_handler(root(get_classic), get_classic_handler, []).
:- http_handler(root(get_quote), get_quote_handler, []).
:- http_handler(root(get_emojis), get_emojis_handler, []).
:- http_handler(root(get_monster), get_monster_handler, []).

get_classic_handler(_Request) :-
    reply_json_dict(_{message: "Hello, World!"}).

main :-
    absolute_file_name('fact.db', File, [access(write)]),
    db_attach(File, []),
    carregar,
    http_server(http_dispatch, [port(8080)]).

