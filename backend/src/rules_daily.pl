:- module(rules_daily, [get_mode/3, get_all/1, get_one/2, get_all_monsters/1, get_one_monster/2]).
:- dynamic(daily_character/12).
:- use_module(library(random)).
:- use_module(library(persistency)).
:- use_module(library(dialect/sicstus/system)).

check_time_valid(Type) :-
    (current_time(PreviousTime, Type) ->
        now(Now),
        Difference is Now - PreviousTime,
        (Difference >= 86400 ->
            retractall_current_time(_),
            assert_current_time(Now, Type)
        ;
            fail)
    ;
        now(Now),
        assert_current_time(Now,Type)).

is_in_black_list([], _) :- fail.
is_in_black_list([Head | Tail], X) :-
    (Head =:= X ; is_in_black_list(Tail, X)), !.

update_black_list(List, Id, NewList) :-
    length(List, N),
    (N > 30 ->
        (List = [_ | Tail],
         append(Tail, [Id], NewList));
        append(List, [Id], NewList)).

update_and_store_blacklist(Id, Type) :-
    (black_list(List, Type) -> true ; List = []),
    update_black_list(List, Id, NewList),
    retractall_black_list(_, Type),
    assert_black_list(NewList, Type).

not_valide_id(Id, Type) :-
    (Type == "quote" ->
        personagem(Id, _, _, _, _, _, _, _, _, _, _, Quote),
        Quote == ""
    ;
     Type == "emojis" ->
        personagem(Id, _, _, _, _, _, _, _, _, emojis, _, _),
        emojis == ""
    ).

get_mode(Type, LowerBound, UpperBound):-
    (check_time_valid(Type) ->
        random_between(LowerBound, UpperBound, Id),
        (black_list(List, Type) -> true ; List = []),

        (not_valide_id(Id, Type); is_in_black_list(List, Id) ->
            get_mode(Type,LowerBound, UpperBound);
            update_and_store_blacklist(Id, Type),
            assert_daily_entity(Id, Type))
    ; true).

get_all(List):-
    findall(
        _{id: Id, nome: Nome},
        personagem(Id, Nome,_,_,_,_,_,_,_,_,_,_),
        List
    ).

get_all_monsters(List):-
    findall(
        _{id: Id, nome: Nome},
        personagem(Id, Nome),
        List
    ).

get_one(Id,Dic):-
    personagem(Id, Nome,Idade,_,Assoc,First,Ator,Aff,Genero,Emoji,_,Quote),
    Dic = _{id: Id, nome: Nome, age: Idade, gender: Genero, actor: Ator, assoc: Assoc, aff: Aff, first: First, emoji: Emoji,quote: Quote}.

get_one_monster(Id,Dic):-
    monstro(Id,Nome,_),
    Dic = _{id: Id, nome: Nome}.