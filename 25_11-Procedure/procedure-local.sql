
select * from aluno order by nome;
select * from curso;
select * from turma;
select * from matricula;
select * from matdisciplina order by cdprofessor;
select * from semestre;
select * from nota;
select * from professor order by nome;

CREATE or replace PROCEDURE ATUALIZA_BILLGATES()
language sql
as
$$
	update aluno set status = 'AP' 
	where cdaluno = (select cdaluno from aluno where nome = 'Bill Gates');
	insert into aluno values(5, 'Zeca Pagodinho', '123456965', 'MT');
$$;

call ATUALIZA_BILLGATES()

create or replace procedure updatetablealuno()
language sql
as
$$
	delete from aluno where nome = 'Zeca' and nmatricula = '545158454';
	delete from aluno where nome = 'Zeca Pagodinho' and nmatricula = '123456965';
	
	insert into aluno (cdaluno, nome, nmatricula, status)
	values (9, 'Tio Mark', '34386333', 'MT');
	
	update aluno set status = 'MT'
	where cdaluno = (select cdaluno from aluno where nome = 'Tio Mark');
$$;

call updatetablealuno()



