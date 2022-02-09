
set schema 'savio';
-- Fazer a inserção da médias dos alunos na tabela MATDISCIPLINA
CREATE OR REPLACE FUNCTION atualizaMEDIA(pnomealuno varchar, pnomedisciplina varchar, pnomesemestre varchar)
RETURNS void as $$
BEGIN

update matdisciplina set media = (select AVG(N.NOTA) from nota as n
            inner join matdisciplina as md 
				on n.cdmatdisciplina = md.cdmatdisciplina
            inner join matricula as m 
				on m.cdmatricula = md.cdmatricula
            inner join aluno as a 
				on a.cdaluno = m.cdaluno
            inner join semestre as s 
				on s.cdsemestre = m.cdsemestre
            inner join disciplina as d 
				on d.cddisciplina = md.cddisciplina
			where a.nome = pnomealuno 
			and s.ano = pnomesemestre 
			and d.nomedisciplina = pnomedisciplina)
			where cdmatricula = (select cdmatricula from matricula where cdaluno = 
								   (SELECT cdaluno from aluno where nome = pnomealuno) 
									and cdsemestre = (SELECT cdsemestre from semestre where ano = pnomesemestre)
								    and cddisciplina = (select cddisciplina from disciplina where nomedisciplina = pnomedisciplina));
														
END; $$

LANGUAGE plpgsql

select atualizaMEDIA('BILL', 'BD', '2020.2');



/* 1 - Ajustar a procedure para atualizar na tabela matdisciplina o atributo:
status:  se media >= 7 o status será AP
              se media  < 7  o status será  RP*/
			

CREATE OR REPLACE FUNCTION atualizaStatus(pnomealuno varchar(40), pnomedisciplina varchar(40), psemestre varchar(15))
returns void AS $$
	
declare media numeric;
begin

	media = (select avg(n.nota) from nota n 
	   				inner join matdisciplina md
	   				on n.cdmatdisciplina = md.cdmatdisciplina
				   inner join matricula m 
				   on md.cdmatricula = m.cdmatricula 
				   inner join disciplina d
				   on md.cddisciplina = d.cddisciplina 
				   inner join semestre s 
				   on s.cdsemestre = m.cdsemestre 
				   inner join aluno a 
				   on a.cdaluno = m.cdaluno 
				   where a.nome = pnomealuno 
				   and d.nomedisciplina = pnomedisciplina 
				   and s.ano = psemestre);
				   
	if media >= 7 then
		update matdisciplina set status = 'AP' where cdmatricula = (select cdmatricula from matricula where cdaluno = 
											   (SELECT cdaluno from aluno where nome = pnomealuno) 
												and cdsemestre = (SELECT cdsemestre from semestre where ano = psemestre)
												and cddisciplina = (select cddisciplina from disciplina where nomedisciplina = pnomedisciplina));
	else 
		update matdisciplina set status = 'RP' where cdmatricula = (select cdmatricula from matricula where cdaluno = 
											   (SELECT cdaluno from aluno where nome = pnomealuno) 
												and cdsemestre = (SELECT cdsemestre from semestre where ano = psemestre)
												and cddisciplina = (select cddisciplina from disciplina where nomedisciplina = pnomedisciplina));
	end if;
	
end;
$$ language plpgsql;

select atualizaStatus('STEVE', 'BD', '2020.2');


/*2 - criar o atributo status na tabela matricula e atualiza-lo
se o aluno tiver perdido , ou seja tiver mais de 3 disciplinas com nota < 7 o status na tabela matricula será RP, caso contrario status será AP*/

ALTER TABLE matricula
ADD status CHAR(2) DEFAULT 'MT';

CREATE OR REPLACE FUNCTION atualizaStatusMatricula(pnomealuno varchar(40), psemestre varchar(15))
returns void AS
$$
declare pdisciplina integer;
begin

pdisciplina = (select count(md.cddisciplina) from matdisciplina md 
				   inner join matricula m 
				   on md.cdmatricula = m.cdmatricula 
				   inner join semestre s 
				   on s.cdsemestre = m.cdsemestre 
				   inner join aluno a 
				   on a.cdaluno = m.cdaluno 
				   where a.nome = pnomealuno 
				   and s.ano = psemestre
				   and md.media <7);

	if pdisciplina > 3 then
		update matricula set status = 'RP' where cdaluno = (select cdaluno from aluno where nome = pnomealuno)
			   							and cdsemestre = (select cdsemestre from semestre where ano = psemestre);
	else
		update matricula set status = 'AP' where cdaluno = (select cdaluno from aluno where nome = pnomealuno)
			   							and cdsemestre = (select cdsemestre from semestre where ano = psemestre);
	end if;
	
end;
$$ language plpgsql;

select atualizaStatusMatricula('LINUS', '2020.2');

select * from aluno;
select * from matricula;
select * from matdisciplina;
select * from nota;
select * from disciplina;
select * from semestre;

select * from matdisciplina order by cdmatdisciplina;


select count(md.cddisciplina) from matdisciplina md 
				   inner join matricula m 
				   on md.cdmatricula = m.cdmatricula 
				   inner join semestre s 
				   on s.cdsemestre = m.cdsemestre 
				   inner join aluno a 
				   on a.cdaluno = m.cdaluno 
				   where a.nome = 'BILL' 
				   and s.ano = '2020.2'
				   and md.media <7;


