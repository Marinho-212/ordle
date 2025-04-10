:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).

:- use_module(classic).
:- use_module(quote).
:- use_module(emoji).
:- use_module(monster).

:- http_handler(root(.), serve_html, []).
:- http_handler(root(fonts), serve_files('fonts'), [prefix]).
:- http_handler(root(classico), serve_classico, []).
:- http_handler(root(quote), serve_frase, []).
:- http_handler(root(emoji), serve_emoji, []).
:- http_handler(root(monster), serve_monster, []).

serve_html(_Request) :-
    File = 'index.html',
    catch(
        open(File, read, Stream),
        _,
        (   format('Content-type: text/plain~n~n'),
            format('Erro ao carregar o arquivo HTML.~n')
        )
    ),
    format('Content-type: text/html~n~n'),
    copy_stream_data(Stream, current_output),
    close(Stream).

serve_files(Directory, Request) :-
    http_reply_from_files(Directory, [], Request).

start_server :- http_server([port(8000)]).
:- initialization(start_server).
