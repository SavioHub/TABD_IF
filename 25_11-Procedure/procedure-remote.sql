set schema 'savio';

select * from aluno order by nome;
select * from curso;
select * from turma;
select * from matricula;
select * from matdisciplina order by cdprofessor;
select * from semestre;
select * from nota;
select * from professor order by nome;

CREATE or replace PROCEDURE UPDATE_TABLE_ALUNO(pnome varchar(40), pcdaluno integer )
language sql
as
$$
	update aluno set status = 'KK'
	where pcdaluno = (select pcdaluno from aluno where nome = pnome);

$$;

call UPDATE_TABLE_ALUNO(4, 'Bill Gates')



CREATE or replace PROCEDURE UPDATE_TABLE_ALUNO(pcdprofessor integer, pcddisciplina integer)
language sql
as
$$
	update matdisciplina set cdprofessor = pcdprofessor where cddisciplina = pcddisciplina;
$$;



create procedure atualizaprofessor (nomeprofessor varchar(40), nomedisciplina(40))
language sql
as $$
	update matdisciplina 
	set cdprofessor = (select cdprofessor from professor where nome = nomeprofessor)
	where cddisciplina = (select cddisciplina from disciplina where nomedisciplina = nomedisciplina);

$$;

call fkfbvkfk('reinalda', 'algoritmo')

create or replace procedure inseriraluno()
language sql
$$
	insert into aluno values(5, 'Zeca Pagodinho', '123456965', 'MT');

$$;
