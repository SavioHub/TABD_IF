-- FAzer uma função para a media  das notas da disciplina Banco de dados do aluno Bill Gates
--Formato da função:
--function fazmediaAluno (IN nomedisciplia varchar, IN nomealuno varchar, OUT media Numeric)

create or replace function media_aluno(in nome_disciplina varchar(40), in nomealuno varchar(40), out media numeric)
as $$
begin
	if ()
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
end;
$$ language plpgsql;

select * from aluno;
select * from matricula;
select * from matdisciplina;
select * from nota;
select * from disciplina;

select * from media_aluno('Bill Gates', 'BANCO DE DADOS');

select * from media_aluno('BANCO DE DADOS', 'Bill Gates');

