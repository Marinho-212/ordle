:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_open)).

:- http_handler(root(.), serve_html, []).
:- http_handler(root(classico), serve_classico, []).
% Função que serve o arquivo HTML
serve_html(Request) :-
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

serve_classico(Request) :-
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
    
    
start_server :-
    http_server([port(8000)]).
