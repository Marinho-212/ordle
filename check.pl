check_classico(id_day,id_try):-
id_day =.= id_try -> return_classico_correct();
check_classico_name(id_day,id_try,_)
check_classico_age(id_day,id_try,_)
check_classico_status(id_day,id_try,_)
check_classico_association(id_day,id_try,_)
check_classico_fstap(id_day,id_try,_)
check_classico_actor(id_day,id_try,_)
check_classico_affinity(id_day,id_try,_)
check_classico_gender(id_day,id_try,_).

return_classico_correct():-

check_classico_name(id_day,id_try,saida_name):-
daily_character(id_day,name_day,_,_,_,_,_,_,_,_,_,_)
test_character(id_try,name_try,_,_,_,_,_,_,_,_,_,_)
name_day =.= name_try -> saida_name = 1;
saida_name = -1.

check_classico_age(id_day,id_try,saida_age):-
daily_character(id_day,_,age_day,_,_,_,_,_,_,_,_,_)
test_character(id_try,_,age_try,_,_,_,_,_,_,_,_,_)
age_day =.= age_try -> saida_age = 1;
age_day > age_try -> saida_age = -10;
saida_age = 10.

check_classico_status(id_day,id_try,saida_status):-
daily_character(id_day,_,_,status_day,_,_,_,_,_,_,_,_)
test_character(id_try,_,_,status_try,_,_,_,_,_,_,_,_)
status_day =.= status_try -> saida_status = 1;
saida_status = -1.

check_classico_association(id_day,id_try):-
daily_character(id_day,_,_,_,association_day,_,_,_,_,_,_,_)
test_character(id_try,_,_,_,association_try,_,_,_,_,_,_,_)
split_string(association_day, ", ", "", lista_day).
split_string(association_try, ", ", "", lista_try).

/*verifica_associations(lista_day,lista_try,i,j,saida_association):-/

check_classico_fstap(id_day,id_try,saida_fstap):-
daily_character(id_day,_,_,_,_,fstap_day,_,_,_,_,_,_)
test_character(id_try,_,_,_,_,fstap_try,_,_,_,_,_,_)
fstap_day =.= fstap_try -> saida_fstap = 1;
saida_fstap = -1.

check_classico_actor(id_day,id_try,saida_actor):-
daily_character(id_day,_,_,_,_,_,actor_day,_,_,_,_,_)
test_character(id_try,_,_,_,_,_,actor_try,_,_,_,_,_)
split_string(actor_day, ", ", "", lista_day).
split_string(actor_try, ", ", "", lista_try).

check_classico_affinity(id_day,id_try,saida_affinity):-
daily_character(id_day,_,_,_,_,_,_,affinity_day,_,_,_,_)
test_character(id_try,_,_,_,_,_,_,affinity_try,_,_,_,_)
affinity_day =.= affinity_try -> saida_affinity = 1;
saida_affinity = -1.

check_classico_gender(id_day,id_try,saida_gender):-
daily_character(id_day,_,_,_,_,_,_,_,gender_day,_,_,_)
test_character(id_try,_,_,_,_,_,_,_,gender_try,_,_,_)
gender_day =.= gender_try -> saida_gender = 1;
saida_gender = -1.