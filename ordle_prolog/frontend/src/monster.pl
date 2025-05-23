:- module(monster, [serve_monster/1]).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_open)).

serve_monster(_Request) :-
        File = 'monster.html', 
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
    