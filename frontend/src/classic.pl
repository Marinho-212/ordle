:- module(classic, [serve_classico/1]).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_open)).

serve_classico(_Request) :-
        File = 'classic.html', 
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
    