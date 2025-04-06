:- dynamic(daily_character/12).
:- use_module(library(random)).
:- use_module(library(persistency)).

:- persistent daily_entity(id: atom, type: string).
:- persistent  black_list(list: atom, type: string).

is_in_black_list([], _):- fail.
is_in_black_list([Head | Tail], X):-
    (Head =:= X; is_in_black_list(Tail, X)),!.

update_black_list(List, Id, NewList) :-
    length(List, N),
    (N > 30 ->
        (List = [_ | Tail],
        append(Tail, [Id], NewList));
        append(List, [Id], NewList)).

not_valide_id(Id, Type):-
    (Type == "quote" ->
        personagem(Id,_,_,_,_,_,_,_,_,_,_,Quote),
        (Quote == "");
        personagem(Id,_,_,_,_,_,_,_,_,Emojis,_,_),
        (Emojis == "")).

get_classic(List) :-
    random_between(1, 181, Id),
    (is_in_black_list(List, Id) ->
        (update_black_list(List, Id, NewList),
        black_list(NewList, "classic"));
        get_classic(List)),
    assert_fact(daily_entity(Id, "classic")).

get_quote(List) :-
    random_between(1, 181, Id),
    ( (not_valide_id(Id, quote); is_in_black_list(List, Id)) ->
        (update_black_list(List, Id, NewList),
        black_list(NewList, "quote"));
        get_quote(List)),
    assert_fact(daily_entity(Id, "quote")).

get_emoji(List) :-
    random_between(1, 181, Id),
    ( (not_valide_id(Id, "emojis"); is_in_black_list(List, Id)) ->
        (update_black_list(List, Id, NewList),
        black_list(NewList, "emoji"));
        get_emoji(List)),
    assert_fact(daily_entity(Id, "emoji")).

get_monster(List) :-
    random_between(1, 73, Id),
    (is_in_black_list(List, Id) ->
        (update_black_list(List, Id, NewList),
        black_list(NewList, "monster"));
        get_monster(List)),
    assert_fact(daily_entity(Id, "monster")).

initializate_entitys:-
    assert_fact(black_list([],"classic")),
    assert_fact(black_list([],"quote")),
    assert_fact(black_list([],"emoji")),
    assert_fact(black_list([],"monster")),
    get_classic([]),
    get_quote([]),
    get_emoji([]),
    get_monster([]).