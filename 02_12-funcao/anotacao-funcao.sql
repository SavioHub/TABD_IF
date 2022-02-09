##Função para inserir alunos e não retorna valores(void)

CREATE OR REPLACE FUNCTION Inserealuno(cdaluno INTEGER,
nome VARCHAR(40), nmatricula VARCHAR(15) , status CHAR(2) )
RETURNS void AS $$
BEGIN
INSERT INTO aluno
VALUES (cdaluno, nome, nmatricula, status);
END;
$$ LANGUAGE plpgsql;

select Inserealuno(15,'fff','3444','rr')

##função para fazer calculos com parametros de entrada e saida

CREATE FUNCTION calculosMatematicos(x int, y int, OUT soma int,
OUT subtracao int, OUT multiplicacao int, OUT divisao int) 
AS $$
BEGIN
soma := x + y;
subtracao := x - y;
multiplicacao := x * y;
divisao := x / y;
END;

$$ LANGUAGE plpgsql;

select * from calculosMatematicos(2,2)


##Função para somartotalmatricula
##paramentros IN -> entrada
##parametros OUT -> saida
**se usar in e out, não precisa utilizar a diretiva returns
CREATE or replace FUNCTION somatotalmatricula(IN pcdaluno int, OUT total numeric) AS $$
BEGIN
total = (SELECT sum(m.valor) FROM matricula AS m
WHERE m.cdaluno = pcdaluno);
END;
$$ LANGUAGE plpgsql;

###. ATividade assincrona ###

Criar uma função para contar a quantidade de disciplinas que um  aluno está cursando em um  semestre.
obs. semestre e alunos são parametros.
