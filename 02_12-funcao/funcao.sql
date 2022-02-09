/*
##paramentros IN -> entrada
##parametros OUT -> saida
**se usar in e out, não precisa utilizar a diretiva returns*/
-- use || para concatenar 
-- tem q apagar a function quando alterado a extrutura dela

set schema 'savio';

create function nome_funcao(param1 tipo, param2 tipo)
returns tipo as $$
begin

end;
$$ language plpgsql;

create or replace function soma(numero1 integer, numero2 integer)
returns text as $$
begin
	return 'A multiplicação dos dois numeros é: ' || numero1 * numero2;
end;
$$ language plpgsql;

drop function soma(integer, integer);
select soma(2,3);

select nome, soma(3,9) from aluno;

select * from curso;

create or replace function valores_cursos(valor numeric(7,2))
returns text as $$
begin
	if valor <= 900 then
		return 'Quimica and ADS and Biologia';
	elsif valor <= 1100 then
		return 'Agroindustria and Agronomia and Pedagogia';
	elsif valor <= 2540 then
		return 'Contabilidade';
	else return 'Direito';
	end if;
end;
$$ language plpgsql;

select nomecurso, valor, valores_cursos(valor) from curso;


-- função para fazer calculos com parametros de entrada e saida
CREATE FUNCTION calculosMatematicos(x int, y int, OUT soma int,
OUT subtracao int, OUT multiplicacao int, OUT divisao int) AS $$
BEGIN
	soma := x + y;
	subtracao := x - y;
	multiplicacao := x * y;
	divisao := x / y;
END;
$$ LANGUAGE plpgsql;

select * from calculosMatematicos(8,2)



--Função para somartotalmatricula
CREATE or replace FUNCTION somatotalmatricula(IN pnome varchar, OUT total numeric) 
AS $$
BEGIN
	total = (SELECT sum(m.valor) FROM matricula AS m 
			 inner join aluno a
			 on m.cdaluno = a.cdaluno
			 WHERE a.nome = pnome);
END;
$$ LANGUAGE plpgsql;

select somatotalmatricula('Bill Gates');

select * from matricula m 
inner join aluno a 
on m.cdaluno = a.cdaluno;

--Criar uma função para contar a quantidade de disciplinas que um aluno está cursando em um  semestre.
--obs. semestre e alunos são parametros.

select a.nome, count(d.cddisciplina) as qtd, s.cdsemestre from aluno a
inner join matricula m
on a.cdaluno = m.cdaluno
inner join semestre s
on m.cdsemestre = s.cdsemestre
inner join matdisciplina md
on md.cdmatricula = m.cdmatricula
inner join disciplina d
on md.cddisciplina = d.cddisciplina
group by a.nome, s.cdsemestre;

select * from semestre;

create or replace function qtd_disciplina(in psemestre integer, in paluno integer, out valor numeric)
as $$
begin
	valor = (select count(d.cddisciplina) as qtd from aluno a
			inner join matricula m
			on a.cdaluno = m.cdaluno
			inner join semestre s
			on m.cdsemestre = s.cdsemestre
			inner join matdisciplina md
			on md.cdmatricula = m.cdmatricula
			inner join disciplina d
			on md.cddisciplina = d.cddisciplina
			where a.cdaluno = paluno and s.cdsemestre = psemestre);
end;
$$ language plpgsql;

drop function qtd_disciplina;


select qtd_disciplina(50,2);

create or replace function qtd_disciplina(in psemestre varchar(15), paluno varchar(40), out valor numeric)
as $$
begin
	valor = (select count(cddisciplina) as qtd_disciplinas
			from  matdisciplina md
			inner join matricula as m
			on md.cdmatricula = m.cdmatricula
			inner join aluno as a
			on m.cdaluno = a.cdaluno
			inner join semestre as s
			on m.cdsemestre = s.cdsemestre
			where a.nome = paluno and s.ano = psemestre);
end;
$$ language plpgsql;

select qtd_disciplina('2017.1', 'Bill Gates');