:- use_module(rules_daily, [get_mode/3]).
:- dynamic(daily_character/12).
:- use_module(library(persistency)).
:- use_module(library(dialect/sicstus/system)).

:- persistent
    daily_entity(id: integer, type: string),
    black_list(list: list(integer), type: string),
    current_time(timestamp:integer, type:string).
    
get_classic :-
    get_mode("classic",1,181).

get_quote :-
    get_mode("quote",1,181).

get_emojis :-
    get_mode("emojis",1,181).

get_monster :-
    get_mode("monster",1,73).

initializate_entitys :-
    (black_list(_, "classic") -> true ; assert_black_list([], "classic")),
    (black_list(_, "quote")   -> true ; assert_black_list([], "quote")),
    (black_list(_, "emojis")   -> true ; assert_black_list([], "emojis")),
    (black_list(_, "monster") -> true ; assert_black_list([], "monster")),
    get_emojis,
    get_classic,
    get_quote,
    get_monster,!.
