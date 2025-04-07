:- dynamic(daily_character/12).
:- use_module(library(random)).
:- use_module(library(persistency)).
use_module(library(dialect/sicstus/system)).

:- persistent
    daily_entity(id: integer, type: string),
    black_list(list: list(integer), type: string),
    current_time(timestamp:int).

    check_time_valid :-
        (current_time(PreviousTime) ->
            now(Now),
            Difference is Now - PreviousTime,
            (Difference >= 86400 ->
                retractall_current_time(_),
                assert_current_time(Now)
            ;
                fail)
        ;
            now(Now),
            assert_current_time(Now)).


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

get_classic :-
    (check_time_valid ->
        random_between(1, 181, Id),
        (black_list(List, "classic") -> true ; List = []),

        (is_in_black_list(List, Id) ->
            get_classic;
            update_and_store_blacklist(Id, "classic"),
            assert_daily_entity(Id, "classic"))
    ; true),!.

get_quote :-
        (check_time_valid ->
            random_between(1, 181, Id),
            (black_list(List, "quote") -> true ; List = []),

            (not_valide_id(Id, "quote") ; is_in_black_list(List, Id) ->
                get_quote;
                update_and_store_blacklist(Id, "quote"),
                assert_daily_entity(Id, "quote"))
        ; true), !.

get_emojis :-
        (check_time_valid ->
            random_between(1, 181, Id),
            (black_list(List, "emojis") -> true ; List = []),

            (not_valide_id(Id, "emojis") ; is_in_black_list(List, Id) ->
                get_emojis;
                update_and_store_blacklist(Id, "emojis"),
                assert_daily_entity(Id, "emojis"))
        ; true), !.

get_monster :-
        (check_time_valid ->
            random_between(1, 73, Id),
            (black_list(List, "monster") -> true ; List = []),
            (is_in_black_list(List, Id) ->
                get_monster;
                update_and_store_blacklist(Id, "monster"),
                assert_daily_entity(Id, "monster"))
        ; true), !.

initializate_entitys :-
    (black_list(_, "classic") -> true ; assert_black_list([], "classic")),
    (black_list(_, "quote")   -> true ; assert_black_list([], "quote")),
    (black_list(_, "emojis")   -> true ; assert_black_list([], "emojis")),
    (black_list(_, "monster") -> true ; assert_black_list([], "monster")),
    get_classic,
    get_quote,
    get_emojis,
    get_monster,!.
