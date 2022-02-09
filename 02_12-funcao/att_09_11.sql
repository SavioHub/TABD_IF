set schema 'savio';

create or replace function media_aluno(in nome_disciplina varchar(40), in nomealuno varchar(40), out media numeric)
as $$
declare
aluno integer;
begin
aluno = (select cdaluno from aluno where nome = nomealuno);

		if (aluno <> 0) then
				media = (select round(avg(n.nota)) from nota as n
				inner join matdisciplina as md
				on n.cdmatdisciplina = md.cdmatdisciplina
				inner join disciplina as d
				on md.cddisciplina = d.cddisciplina
				inner join matricula as m
				on md.cdmatricula = m.cdmatricula
				inner join aluno as a
				on m.cdaluno = a.cdaluno
				where a.nome = nomealuno
				and d.nomedisciplina = nome_disciplina);
		end if;
end;
$$ language plpgsql;


select * from aluno;
select * from matricula;
select * from matdisciplina;
select * from nota;
select * from disciplina;
select * from professor;

select * from media_aluno('BANCO DE DADOS', 'Bill');

insert into NOTA ( CDNOTA, CDMATDISCIPLINA, NOTA, REFERENCIA, STATUS)
					values
			(22, 14, 5.40, 'AV I', 'MT'),
			(23, 14, 7.20, 'AV I', 'MT'),
			(24, 14, 5.50, 'AV II', 'MT');
			
insert into MATDISCIPLINA(CDMATDISCIPLINA, CDMATRICULA, status, valor, CDDISCIPLINA, CDPROFESSOR) 
				  values
				( 14,101,'MT', 876.00, 31, 20);
		
		
