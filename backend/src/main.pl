:- [carrega_dados].
:- [set_daily].
:- use_module(json_to_facts, [personagem/12, monstro/3, carregar_json/4]).
:- use_module(library(persistency)).
:- use_module(library(http/http_server)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- initialization(main).

% :- http_handler(root(get_classic), get_classic_handler, []).
% :- http_handler(root(get_quote), get_quote_handler, []).
% :- http_handler(root(get_emojis), get_emojis_handler, []).
% :- http_handler(root(get_monster), get_monster_handler, []).

% get_classic_handler(_Request) :-
%     today_character(Classic),
%     reply_json_dict(Classic).

% get_quote_handler(_Request) :-
%     set_daily:today_quote(Quote),
%     reply_json_dict(Quote).

% get_emojis_handler(_Request) :-
%     set_daily:today_emojis(Emojis),
%     reply_json_dict(Emojis).

% get_monster_handler(_Request) :-
%     set_daily:today_monster(Monster),
%     reply_json_dict(Monster).

    main :-
        absolute_file_name('fact.db', File, [access(write)]),
        db_attach(File, []),
        carregar,
        http_server(http_dispatch, [port(8080)]).

