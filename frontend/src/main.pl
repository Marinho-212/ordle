:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_open)).
:- use_module(classic).
:- use_module(quote).
:- http_handler(root(.), serve_html, []).

:- http_handler(root(.), serve_html, []).
:- http_handler(root(classico), serve_classico, []).
:- http_handler(root(quote), serve_frase, []).
:- initialization(start_server).

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

start_server :-
    http_server([port(8000)]).

