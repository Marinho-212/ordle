check_classico(id_day,id_try):-
id_day =.= id_try -> return_classico_correct(_);
check_classico_name(id_day,id_try,_),
check_classico_age(id_day,id_try,_),
check_classico_status(id_day,id_try,_),
check_classico_association(id_day,id_try,_),
check_classico_fstap(id_day,id_try,_),
check_classico_actor(id_day,id_try,_),
check_classico_affinity(id_day,id_try,_),
check_classico_gender(id_day,id_try,_).

return_classico_correct(saida_classico):-
saida_classico = 1.

check_classico_name(id_day,id_try,saida_name):-
daily_character(id_day,name_day,_,_,_,_,_,_,_,_,_,_),
test_character(id_try,name_try,_,_,_,_,_,_,_,_,_,_),
name_day =.= name_try -> saida_name = 1;
saida_name = -1.

check_classico_age(id_day,id_try,saida_age):-
daily_character(id_day,_,age_day,_,_,_,_,_,_,_,_,_),
test_character(id_try,_,age_try,_,_,_,_,_,_,_,_,_),
age_day =.= age_try -> saida_age = 1;
age_day > age_try -> saida_age = -10;
saida_age = 10.

check_classico_status(id_day,id_try,saida_status):-
daily_character(id_day,_,_,status_day,_,_,_,_,_,_,_,_),
test_character(id_try,_,_,status_try,_,_,_,_,_,_,_,_),
status_day =.= status_try -> saida_status = 1;
saida_status = -1.

check_classico_association(id_day,id_try,saida_association):-
daily_character(id_day,_,_,_,association_day,_,_,_,_,_,_,_),
test_character(id_try,_,_,_,association_try,_,_,_,_,_,_,_),
split_string(association_day, ", ", "", lista_day),
split_string(association_try, ", ", "", lista_try),
sort(lista_day, sorted_day),
sort(lista_try, sorted_try),
sorted_day =.= sorted_try -> saida_association = 1;
verifica_association(sorted_day,sorted_try,-1).

verifica_association_day([head_day|tail_day],sorted_try,saida_association):-
verifica_association_try([head_day|tail_day],sorted_try,saida_association),
verifica_association_day(tail_day,sorted_try,saida_association).

verifica_association_try([head_day|tail_day],[head_try|tail_try],saida_association):-
head_day =.= head_try -> saida_association = 0;
verifica_association_try([head_day|tail_day],tail_try).

check_classico_fstap(id_day,id_try,saida_fstap):-
daily_character(id_day,_,_,_,_,fstap_day,_,_,_,_,_,_),
test_character(id_try,_,_,_,_,fstap_try,_,_,_,_,_,_),
fstap_day =.= fstap_try -> saida_fstap = 1;
saida_fstap = -1.

check_classico_actor(id_day,id_try,saida_actor):-
daily_character(id_day,_,_,_,_,_,actor_day,_,_,_,_,_),
test_character(id_try,_,_,_,_,_,actor_try,_,_,_,_,_),
split_string(actor_day, ", ", "", lista_day),
split_string(actor_try, ", ", "", lista_try),
sort(lista_day, sorted_day),
sort(lista_try, sorted_try),
sorted_day =.= sorted_try -> saida_actor = 1;
verifica_actor_day(sorted_day,sorted_try,-1).

verifica_actor_day([head_day|tail_day],sorted_try,saida_actor):-
verifica_actor_try([head_day|tail_day],sorted_try,saida_actor),
verifica_actor_day(tail_day,sorted_try,saida_actor).

verifica_actor_try([head_day|tail_day],[head_try|tail_try],saida_actor):-
head_day =.= head_try -> saida_actor = 0;
verifica_actor_try([head_day|tail_day],tail_try).

check_classico_affinity(id_day,id_try,saida_affinity):-
daily_character(id_day,_,_,_,_,_,_,affinity_day,_,_,_,_),
test_character(id_try,_,_,_,_,_,_,affinity_try,_,_,_,_),
affinity_day =.= affinity_try -> saida_affinity = 1;
saida_affinity = -1.

check_classico_gender(id_day,id_try,saida_gender):-
daily_character(id_day,_,_,_,_,_,_,_,gender_day,_,_,_),
test_character(id_try,_,_,_,_,_,_,_,gender_try,_,_,_),
gender_day =.= gender_try -> saida_gender = 1;
saida_gender = -1.

check_monstro(id_day,id_try,saida_monstro):-
id_day =.= id_try -> saida_monstro  = 1;
saida_monstro = -1.

check_emojis(id_day,id_try,saida_emojis):-
id_day =.= id_try -> saida_emojis  = 1;
saida_emojis = -1.

check_falas(id_day,id_try,saida_falas):-
id_day =.= id_try -> saida_falas  = 1;
saida_falas = -1.