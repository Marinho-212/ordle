:- dynamic(daily_character/12).
:- use_module(library(random)).
:- use_module(library(persistency)).

:- persistent
    daily_entity(id: integer, type: string),
    black_list(list: list(integer), type: string).

is_in_black_list([], _) :- fail.
is_in_black_list([Head | Tail], X) :-
    (Head =:= X ; is_in_black_list(Tail, X)), !.

update_black_list(List, Id, NewList) :-
    length(List, N),
    (N > 30 ->
        (List = [_ | Tail],
         append(Tail, [Id], NewList));
        append(List, [Id], NewList)).

not_valide_id(Id, Type) :-
    (Type == "quote" ->
        personagem(Id, _, _, _, _, _, _, _, _, _, _, Quote),
        Quote == ""
    ;
     Type == "emojis" ->
        personagem(Id, _, _, _, _, _, _, _, _, Emojis, _, _),
        Emojis == ""
    ).

update_and_store_blacklist(Id, Type) :-
    (black_list(List, Type) -> true ; List = []),
    update_black_list(List, Id, NewList),
    retractall_black_list(_, Type),
    assert_black_list(NewList, Type).

get_classic :-
    random_between(1, 181, Id),
    (black_list(List, "classic") -> true ; List = []),
    (is_in_black_list(List, Id) ->
        update_and_store_blacklist(Id, "classic"),
        get_classic
    ;
        assert_daily_entity(Id, "classic")
    ).

get_quote :-
    random_between(1, 181, Id),
    (black_list(List, "quote") -> true ; List = []),
    (not_valide_id(Id, "quote") ; is_in_black_list(List, Id)) ->
        update_and_store_blacklist(Id, "quote"),
        get_quote
    ;
        assert_daily_entity(Id, "quote").

get_emoji :-
    random_between(1, 181, Id),
    (black_list(List, "emoji") -> true ; List = []),
    (not_valide_id(Id, "emojis") ; is_in_black_list(List, Id)) ->
        update_and_store_blacklist(Id, "emoji"),
        get_emoji
    ;
        assert_daily_entity(Id, "emoji").

get_monster :-
    random_between(1, 73, Id),
    (black_list(List, "monster") -> true ; List = []),
    (is_in_black_list(List, Id) ->
        update_and_store_blacklist(Id, "monster"),
        get_monster
    ;
        assert_daily_entity(Id, "monster")
    ).

initializate_entitys :-
    (black_list(_, "classic") -> true ; assert_black_list([], "classic")),
    (black_list(_, "quote")   -> true ; assert_black_list([], "quote")),
    (black_list(_, "emoji")   -> true ; assert_black_list([], "emoji")),
    (black_list(_, "monster") -> true ; assert_black_list([], "monster")),
    get_classic,
    get_quote,
    get_emoji,
    get_monster.
