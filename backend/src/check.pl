check_classico(IdTry, Dic):-
    daily_entity(IdDay,"classic"),
   ( check_classico_name(IdDay,IdTry,NameResult),
    check_classico_age(IdDay,IdTry, AgeResult),
    check_classico_association(IdDay,IdTry,AssociationResult),
    check_classico_fstap(IdDay,IdTry,FstapResult),
    check_classico_actor(IdDay,IdTry,ActorResult),
    check_classico_affinity(IdDay,IdTry,AffinityResult),
    check_classico_gender(IdDay,IdTry,GenderResult),
    Dic = _{fstap: FstapResult, 
            actor: ActorResult, 
            association: AssociationResult,
            affinity: AffinityResult,
            gender: GenderResult,
            age: AgeResult,
            name: NameResult 
           }).

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
    personagem(IdDay,_,_,_,AssociationDay,_,_,_,_,_,_,_),
    personagem(IdTry,_,_,_,AssociationTry,_,_,_,_,_,_,_),
    split_string(AssociationDay, ",", "", ListaDayRaw),
    split_string(AssociationTry, ",", "", ListaTryRaw),
    maplist(remove_spaces_string, ListaDayRaw, ListaDay),
    maplist(remove_spaces_string, ListaTryRaw, ListaTry),
    sort(ListaDay, SortedDay),
    sort(ListaTry, SortedTry),
    verifica(SortedDay,SortedTry,Saida).

remove_spaces_string(String, Clean) :-
    string_chars(String, Chars),
    exclude(=( ' '), Chars, CleanChars),
    string_chars(Clean, CleanChars).

verifica(List1, List2, Result) :-
    (List1 = List2 -> Result = 1;  
     (common_element(List1, List2) -> Result = 0; 
     Result = -1)).

common_element(List1, List2) :-
    member(Elem, List1), 
    member(Elem, List2), !.  
    
fstap_comp("Iniciacao",1).
fstap_comp("O Segredo na Floresta",2).
fstap_comp("Desconjuracao",3).
fstap_comp("Calamidade",4).
fstap_comp("O Segredo na Ilha",5).
fstap_comp("Sinais do Outro Lado",6).
fstap_comp("Quarentena",7).
fstap_comp("Natal Macabro",8).
fstap_comp("Enigma do Medo",9).

check_classico_fstap(IdDay,IdTry,Saida):-
    personagem(IdDay,_,_,_,_,FstapDay,_,_,_,_,_,_),
    personagem(IdTry,_,_,_,_,FstapTry,_,_,_,_,_,_),
    fstap_comp(FstapDay,NumDay),
    fstap_comp(FstapTry,NumTry),
    Dif is NumDay - NumTry,
   ( Dif == 0 -> Saida = 1;
    (Dif < 0 -> Saida = 10; Saida = -10)).

check_classico_actor(IdDay,IdTry, Saida):-
    personagem(IdDay,_,_,_,_,_,ActorDay,_,_,_,_,_),
    personagem(IdTry,_,_,_,_,_,ActorTry,_,_,_,_,_),
    split_string(ActorDay, ",", "", ListaDayRaw),
    split_string(ActorTry, ",", "", ListaTryRaw),
    maplist(remove_spaces_string, ListaDayRaw, ListaDay),
    maplist(remove_spaces_string, ListaTryRaw, ListaTry),
    sort(ListaDay, SortedDay),
    sort(ListaTry, SortedTry),
    verifica(SortedDay,SortedTry,Saida).

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

check_monster(IdTry,Saida,Dic):-
    daily_entity(IdDay,"monster"),
    (IdDay = IdTry -> Saida = 1;
    Saida = -1),
    Dic = _{monstro: Saida}.

check_emojis(IdTry,Saida,Dic):-
    daily_entity(IdDay,"emojis"),
    (IdDay = IdTry -> Saida = 1;
    Saida is -1),
    Dic = _{emoji: Saida}.

check_falas(IdTry,Saida,Dic):-
    daily_entity(IdDay,"quote"),
   (IdDay = IdTry -> Saida = 1;
    Saida is -1),
    Dic = _{fala: Saida}.