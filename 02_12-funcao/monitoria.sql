cdaluno 2
cdmatricula 101
cdmatdisciplina 6, 7
cddisciplina 33, 34
cdnota 11,12,13,14,15,16

-- Fazer uma função	que	recebe	um	valor	inteiro	e	verifica	se	ele		é	par.
-- A função deve retornar	1	se o número	for	par	e	0	se for ímpar

CREATE or replace FUNCTION numero_par(IN numero int, OUT total numeric) AS $$
declare  pcdaluno int;
BEGIN


END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION parOUimpar(IN numero numeric ) 
RETURNS text
AS $$
BEGIN
	IF ((numero%2)=0) then
		RETURN 'numero e par' || 1;
	ELSE 
		RETURN 'numero e impar' || 0;
	END IF;
END;
$$ LANGUAGE plpgsql;

select parOUimpar(4);

-- Fazer uma função que receba 3 notas de um aluno e uma letra.
-- Se a letra	for	A	a	função	retorna amédia	aritmética	das	notas	do aluno,
-- se	for	P, a sua média ponderada (pesos: 5, 3 e 2) e se for H, a sua média harmônica.	


-- carol
create or replace function calculamedia(in nota1 int, in nota2 int, in nota3 int, in letra char(1), out resultado numeric)
returns numeric as $$ 
declare 
mmc numeric;
	begin
		if(letra = 'A' or letra = 'a') then
			resultado = (nota1 + nota2 + nota3) / 3;
		else if(letra = 'P' or letra = 'p') then
			resultado = ((nota1 * 5) + (nota2 * 3) + (nota3 * 2)) / (5*3*2);
		else if (letra = 'H' or letra = 'h') then
			mmc = ((nota1 % 5) * (nota2 % 3) * (nota3 % 2));
			resultado = (3/(((mmc/5)*nota1)+((mmc/3)*nota2)*((mmc/2)*nota3)));
		else
			raise exception 'errooo';
		end if;
	end;
$$ language plpgsql;





























