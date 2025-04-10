:- use_module(json_to_facts, [carregar_json/4]).
:- dynamic monstro/3.
:- dynamic personagem/12.


carregar_monstros :-
    carregar_json("json/monstros.json", monstro, [id, monsterName, image], monstro(_,_,_)).

carregar_personagens :-
    carregar_json("json/personagens.json",personagem, [id, name, age, status, association, first_appearance, actor, affinity, gender, emojis, imageChar, quote], personagem(_,_,_,_,_,_,_,_,_,_,_,_)).

carregar:-
    carregar_monstros,
    carregar_personagens.