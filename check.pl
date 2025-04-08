check_classico(IdTry, Dic):-
    daily_entity(IdDay,"classic"),
   ( IdDay = IdTry -> Dic = [name: 1, age: 1, association: 1, fstap: 1, affinity: 1, gender: 1];
    check_classico_name(IdDay,IdTry,NameResult),
    check_classico_age(IdDay,IdTry, AgeResult),
    check_classico_association(IdDay,IdTry,AssociationResult),
    check_classico_fstap(IdDay,IdTry,FstapResult),
    check_classico_actor(IdDay,IdTry,ActorResult),
    check_classico_affinity(IdDay,IdTry,AffinityResult),
    check_classico_gender(IdDay,IdTry,GenderResult),
    Dic = [name: NameResult, age: AgeResult, association: AssociationResult, 
           fstap: FstapResult, actor: ActorResult, affinity: AffinityResult, gender: GenderResult]).

check_classico_name(IdDay,IdTry,Saida):-
    personagem(IdDay,NameDay,_,_,_,_,_,_,_,_,_,_),
    personagem(IdTry,NameTry,_,_,_,_,_,_,_,_,_,_),
    (NameDay = NameTry -> Saida = 1; Saida = -1).

check_classico_age(IdDay, IdTry, Saida) :-
    personagem(IdDay, _, AgeDay, _, _, _, _, _, _, _, _, _),
    personagem(IdTry, _, AgeTry, _, _, _, _, _, _, _, _, _),
    (AgeDay = AgeTry -> Saida = 1 ;
     (AgeDay > AgeTry -> Saida = -10 ;
      Saida = 10)).

check_classico_association(IdDay,IdTry, Saida):-
    personagem(IdDay,_,_,_,associationDay,_,_,_,_,_,_,_),
    personagem(IdTry,_,_,_,associationTry,_,_,_,_,_,_,_),
    split_string(associationDay, ", ", "", listaDay),
    split_string(associationTry, ", ", "", listaTry),
    sort(listaDay, sortedDay),
    sort(listaTry, sortedTry),
    verifica(sortedDay,sortedTry,Saida).

verifica(List1, List2, Result):-
    (List1 = List2 -> Result = 1;
     (common_element(List1,List2)-> Result = 0;
      Result = -1)).

common_element([Head|_], List2) :- member(Head, List2), !.
common_element([_|Tail], List2) :- common_element(Tail, List2).


check_classico_fstap(IdDay,IdTry,Saida):-
    personagem(IdDay,_,_,_,_,fstapDay,_,_,_,_,_,_),
    personagem(IdTry,_,_,_,_,fstapTry,_,_,_,_,_,_),
    fstapDay = fstapTry -> Saida = 1;
    Saida = -1.

check_classico_actor(IdDay,IdTry, Saida):-
    personagem(IdDay,_,_,_,_,_,actorDay,_,_,_,_,_),
    personagem(IdTry,_,_,_,_,_,actorTry,_,_,_,_,_),
    split_string(actorDay, ", ", "", listaDay),
    split_string(actorTry, ", ", "", listaTry),
    sort(listaDay, sortedDay),
    sort(listaTry, sortedTry),
    verifica(sortedDay,sortedTry,Saida).

check_classico_affinity(IdDay,IdTry,Saida):-
    personagem(IdDay,_,_,_,_,_,_,AffinityDay,_,_,_,_),
    personagem(IdTry,_,_,_,_,_,_,AffinityTry,_,_,_,_),
    AffinityDay = AffinityTry -> Saida = 1;
    Saida = -1.

check_classico_gender(IdDay,IdTry,Saida):-
    personagem(IdDay,_,_,_,_,_,_,_,GenderDay,_,_,_),
    personagem(IdTry,_,_,_,_,_,_,_,GenderTry,_,_,_),
    GenderDay = GenderTry -> Saida = 1;
    Saida = -1.

check_monstro(IdTry,Saida,Dic):-
    daily_entity(IdDay,"monster"),
    (IdDay = IdTry -> Saida = 1;
    Saida = -1),
    Dic = [mosntro: Saida].

check_emojis(IdTry,Saida,Dic):-
    daily_entity(IdDay,"emojis"),
    (IdDay = IdTry -> Saida = 1;
    Saida is -1),
    Dic = [emoji: Saida]

check_falas(IdTry,Saida,Dic):-
    daily_entity(IdDay,"quote"),
   (IdDay = IdTry -> Saida = 1;
    Saida is -1),
    Dic = [fala: Saida].