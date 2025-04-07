:- module(json_to_facts, [carregar_json/4]).
:- use_module(library(http/json)).

carregar_json(Arquivo, Predicado, Atributos, FatoExemplo) :-
    retractall(FatoExemplo), 
    open(Arquivo, read, Stream, [encoding(utf8)]),
    json_read_dict(Stream, ListaDicts), 
    close(Stream),
    maplist(assert_fato(Predicado, Atributos), ListaDicts). 

assert_fato(Predicado, Atributos, Dict) :-
    maplist(get_field(Dict), Atributos, Valores),
    Fact =.. [Predicado | Valores],  
    assertz(Fact). 

get_field(Dict, Campo, Valor) :-
    Valor = Dict.get(Campo).  
