:- [carrega_dados].
:- use_module(json_to_facts, [personagem/12, monstro/3, carregar_json/4]).
:- initialization(main).

main :-
    carregar_monstros,
    carregar_personagens,
    writeln('Dados carregados com sucesso!').
