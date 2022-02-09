-- Enunciado: a seguinte função deve atualizar a média na tabela matdisciplina

-- Função que estava sendo desenvolvida na aula:

set schema 'savio';

CREATE OR REPLACE FUNCTION atualizaMEDIA(pnomealuno varchar, pnomedisciplina varchar, pnomesemestre varchar)
RETURNS void as $$
BEGIN
update matdisciplina set media = (select AVG(N.NOTA) from NOTA as N
            join MATDISCIPLINA md 
			on n.cdmatdisciplina = md.cdmatdisciplina
            join matricula as m 
			on m.cdmatricula = md.cdmatricula
            join aluno as a 
			on a.cdaluno = m.cdaluno
            join semestre as s 
			on s.cdsemestre = m.cdsemestre
            join disciplina as d 
			on d.cddisciplina = md.cddisciplina
            where a.nome = pnomealuno
            AND D.NOMEDISCIPLINA = pnomedisciplina
			and cdmatricula in (select cdmatricula from matricula where cdaluno in ( select cdaluno from aluno where nome = pnomealuno)
							 and cdsemestre in (select cdsemestre from semestre where semestre = pnomesemestre)
							 and cddisciplina in (select cddisciplina from disciplina where nomedisciplina = pnomedisciplina)));
END; $$
LANGUAGE plpgsql

select atualizaMEDIA('Steve Sniack', 'ALGORITMO', '2017.1');

select * from professor; = cd = 3
select * from disciplina;= 30
select * from matricula; where cdaluno = 3 and cdsemestre = 50;
select * from semestre; where cdsemestre = 50;
cdmatricula = 102

update matdisciplina set media = (select AVG(N.NOTA) from nota as n
            inner join MATDISCIPLINA md 
			on n.cdmatdisciplina = md.cdmatdisciplina
            inner join matricula as m 
			on m.cdmatricula = md.cdmatricula
            inner join aluno as a 
			on a.cdaluno = m.cdaluno
            inner join semestre as s 
			on s.cdsemestre = m.cdsemestre
            inner join disciplina as d 
			on d.cddisciplina = md.cddisciplina
			where m.cdmatricula in (select cdmatricula from matricula where cdaluno in( select cdaluno from aluno where nome = 'Bill Gates')
							 and s.cdsemestre in (select cdsemestre from semestre where ano = '2017.1')
							 and d.cddisciplina in (select cddisciplina from disciplina where nomedisciplina = 'ALGORITMO')));
select * from matdisciplina;

									
									
select AVG(N.NOTA) from nota as n
            inner join MATDISCIPLINA md 
			on n.cdmatdisciplina = md.cdmatdisciplina
            inner join matricula as m 
			on m.cdmatricula = md.cdmatricula
            inner join aluno as a 
			on a.cdaluno = m.cdaluno
            inner join semestre as s 
			on s.cdsemestre = m.cdsemestre
            inner join disciplina as d 
			on d.cddisciplina = md.cddisciplina
			where m.cdmatricula in (select cdmatricula from matricula where cdaluno in( select cdaluno from aluno where nome = 'Bill Gates')
							 and s.cdsemestre in (select cdsemestre from semestre where ano = '2017.1')
							 and d.cddisciplina in (select cddisciplina from disciplina where nomedisciplina = 'ALGORITMO'));									
									
