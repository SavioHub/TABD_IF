set schema 'savio';

CREATE OR REPLACE FUNCTION atualizaMEDIA(pnomealuno varchar, pnomedisciplina varchar, psemestre varchar)
returns void AS
$$
declare pcdmatdisciplina integer;
begin

pcdmatdisciplina=(select md.cdmatdisciplina from matdisciplina md 
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
				   
					update matdisciplina set media = (select AVG(N.NOTA) from nota as n 
								 where cdmatdisciplina = pcdmatdisciplina)
								 where cdmatdisciplina = pcdmatdisciplina;
							
end;
$$ language plpgsql;

select atualizaMEDIA('BILL', 'ALGORITMO','2020.2');

select * from aluno;
select * from matricula;
select * from matdisciplina;
select * from nota;
select * from disciplina;
select * from semestre;
select * from turma;




				   
				   
				   
				   
				   
CREATE OR REPLACE FUNCTION atualizaMEDIA(pnomealuno varchar, pnomedisciplina varchar, psemestre varchar)
returns void AS
$$
declare pcdmatdisciplina integer;
begin

pcdmatdisciplina=(select md.cdmatdisciplina from matdisciplina md 
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
				   
					update matdisciplina set media = (select AVG(N.NOTA) from nota as n 
								 where cdmatdisciplina = pcdmatdisciplina)
								 where cdmatdisciplina = pcdmatdisciplina;
							
end;
$$ language plpgsql;
