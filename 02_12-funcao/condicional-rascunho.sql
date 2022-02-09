CREATE or replace FUNCTION somatotalmatricula(IN pcdmatricula int,IN pnome varchar, OUT total numeric) AS $$
declare  pcdaluno int;
BEGIN

	pcdaluno = (select cdaluno from aluno where nome = pnome);
	total = (SELECT sum(m.valor) FROM matricula AS m
	WHERE m.cdaluno = pcdaluno);

if (pcdaluno != 16) then
   insert into matricula values(pcdmatricula,10,pcdaluno,50,1000,60);
elseif (pcdaluno = 15) then
   insert into matricula values(pcdmatricula,10,pcdaluno,50,1000,60);
end if;

END;
$$ LANGUAGE plpgsql;

