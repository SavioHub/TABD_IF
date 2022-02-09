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

ALTER TABLE matricula ADD status CHAR(2) DEFAULT 'MT';

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
