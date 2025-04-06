:- [carrega_dados].
:- use_module(json_to_facts, [personagem/12, monstro/3, carregar_json/4]).
:- use_module(library(persistency)).
:- initialization(main).

main :-
    absolute_file_name('fact.db', File, [access(write)]),
    db_attach(File, []),
    carregar.
