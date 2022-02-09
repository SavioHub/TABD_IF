
set schema 'savio';
-- Crie todas as tabelas que não existem, com seus atributos, relacionamentos, chaves estrangeiras e chaves primarias

CREATE TABLE Emprestimo( 
cdemprestimo INTEGER NOT NULL,
dataemprestimo DATE, 
datadevolucao DATE,
cdaluno INTEGER NOT NULL
); 

CREATE TABLE EmprestimoExemplar( 
cdemprestimoexemplar INTEGER NOT NULL, 
cdexemplar INTEGER NOT NULL,
cdemprestimo INTEGER NOT NULL
); 

CREATE TABLE Exemplar( 
cdpublicacao INTEGER NOT NULL,
cdexemplar INTEGER NOT NULL, 
numeroexemplar VARCHAR(10),
status VARCHAR(10)
); 

CREATE TABLE Publicacao( 
cdpublicacao INTEGER NOT NULL,
cdautor INTEGER NOT NULL, 
cdeditora INTEGER NOT NULL
); 

CREATE TABLE Autor( 
cdautor INTEGER NOT NULL,
nomeautor VARCHAR(40) 
); 

CREATE TABLE Editora( 
cdeditora INTEGER NOT NULL, 
nomeeditora VARCHAR(40) 
); 

 ------------------------------------------------------------------------------------------------------------------

alter table Emprestimo add primary key(cdemprestimo); 
alter table EmprestimoExemplar add primary key(cdemprestimoexemplar); 
alter table Exemplar add primary key(cdexemplar); 
alter table Publicacao add primary key(cdpublicacao); 
alter table Autor add primary key(cdautor); 
alter table Editora add primary key(cdeditora); 

 

ALTER TABLE Emprestimo ADD CONSTRAINT FK_CD_aluno FOREIGN KEY (cdaluno) REFERENCES ALUNO(CDALUNO); 

ALTER TABLE EmprestimoExemplar ADD CONSTRAINT FK_CD_emprestimo FOREIGN KEY (cdemprestimo) REFERENCES Emprestimo(cdemprestimo); 

ALTER TABLE EmprestimoExemplar ADD CONSTRAINT FK_CD_exemplar FOREIGN KEY (cdexemplar) REFERENCES Exemplar(cdexemplar); 

ALTER TABLE Exemplar ADD CONSTRAINT FK_CD_publicacao FOREIGN KEY (cdpublicacao) REFERENCES Publicacao(cdpublicacao); 

ALTER TABLE Publicacao ADD CONSTRAINT FK_CD_autor FOREIGN KEY (cdautor) REFERENCES Autor(cdautor); 

ALTER TABLE Publicacao ADD CONSTRAINT FK_CD_editora FOREIGN KEY (cdeditora) REFERENCES Editora(cdeditora);


-- Para cada tabela insira pelo menos 3 linhas.


insert into Emprestimo( 
		cdemprestimo ,
		dataemprestimo , 
		datadevolucao ,
		cdaluno) values
					(1, '2020-01-27', '2022-01-27', 1),
					(2, '2020-03-27', '2023-01-27', 2),
					(3, '2021-10-12', '2024-01-27', 3),
					(4, '2013-11-22', '2023-01-27', 4),
					(5, '2017-05-24', '2022-01-27', 5),
					(6, '2019-01-21', '2024-01-27', 6),
					(7, '2019-06-27', '2021-01-27', 7),
					(8, '2020-09-27', '2022-01-27', 2);

					
insert into EmprestimoExemplar( 
		cdemprestimoexemplar, 
		cdexemplar,
		cdemprestimo) values
			(1, 1, 1),
			(2, 2, 2),
			(3, 3, 3),
			(4, 4, 4),
			(5, 5, 5),
			(6, 6, 6),
			(7, 7, 7),
			(8, 8, 8);
								
								

insert into Exemplar( 
		cdexemplar,
		cdpublicacao ,
		numeroexemplar ,
		status) values 
			(1, 1, '1234561', 'livre'),
			(2, 2, '1234561', 'emprestado'),
			(3, 3, '1234561', 'emprestado'),
			(4, 4, '1234561', 'emprestado'),
			(5, 1, '1234561', 'livre'),
			(6, 2, '1234561', 'emprestado'),
			(7, 3, '1234561', 'livre'),
			(8, 4, '1234561', 'emprestado');
								

insert into Publicacao( 
		cdpublicacao ,
		cdautor, 
		cdeditora  
		) values 
		(1, 1, 1),
		(2, 2, 2),
		(3, 3, 3),
		(4, 4, 4); 

 
 insert into Autor( 
		cdautor,
		nomeautor  
		) values
		(1, 'Susan Cain'),
		(2, 'Roger S. Pressman'),
		(3, 'Roger S. Pressman'),
		(4, 'Carlos Morimoto');


 
 insert into Editora( 
		cdeditora , 
		nomeeditora  
		) values 
		(1, 'Aleph'),
		(2, 'Suma'),
		(3, 'Rocco'),
		(4, 'Darkside Books');
			
							
-- Fazer  a procedure/function para executar o empréstimo de livros para alunos do curso de ads.
						

CREATE OR REPLACE FUNCTION emprestimo(IN pnomealuno VARCHAR, pnumero VARCHAR, OUT mensagem VARCHAR) 
AS $$

DECLARE pcdaluno INTEGER;
DECLARE pcdexemplar INTEGER;
DECLARE statusatual VARCHAR;
DECLARE pcdemprestimo INTEGER;

BEGIN
	
	pcdaluno = (SELECT a.cdaluno FROM aluno as a
		JOIN matricula as m
		ON a.cdaluno = m.cdaluno
		INNER JOIN curso as c
		ON m.cdcurso = c.cdcurso
		WHERE a.nome = pnomealuno 
		AND c.nomecurso = 'ADS' LIMIT 1);
	
	
	IF (pcdaluno IS NULL) THEN
		RAISE EXCEPTION 'Esse aluno não está matriculado em ADS';
	END IF;
	
	pcdexemplar = (SELECT cdexemplar FROM exemplar WHERE numeroexemplar = pnumero);
	
	statusatual = (SELECT status FROM exemplar WHERE cdexemplar = pcdexemplar);
	
	IF (statusatual = 'emprestado') THEN
		mensagem = 'O livro selecionado está indisponivel';
	ELSE
		INSERT INTO emprestimo (dataemprestimo, cdaluno)
		VALUES (CURRENT_DATE, pcdaluno) RETURNING cdemprestimo INTO pcdemprestimo;
		
		INSERT INTO emprestimoexemplar (cdexemplar, cdemprestimo)
		VALUES (pcdexemplar, pcdemprestimo);
		
		UPDATE exemplar SET status = 'emprestado' WHERE cdexemplar = pcdexemplar;
		
		mensagem = 'Emprestimo realizado!';
  END IF;

END; $$ LANGUAGE plpgsql;

SELECT emprestimo('BILL', '23.2');


-- Fazer um function para devolver os livros que foram emprestados.

CREATE OR REPLACE FUNCTION devolucao(IN pnomealuno VARCHAR, pnumero VARCHAR, OUT mensagem VARCHAR) AS $$

DECLARE pcdaluno INTEGER;
DECLARE pcdexemplar INTEGER;
DECLARE statusatual VARCHAR;
DECLARE pcdemprestimo INTEGER;

BEGIN

	pcdaluno = (SELECT cdaluno FROM aluno WHERE nome = pnomealuno);
	pcdexemplar = (SELECT cdexemplar from exemplar WHERE numeroexemplar = pnumero);
	statusatual = (SELECT status FROM exemplar WHERE cdexemplar = pcdexemplar);
	
pcdemprestimo = (
		SELECT e.cdemprestimo from emprestimo as e
		INNER JOIN emprestimoexemplar as ee
		ON e.cdemprestimo = ee.cdemprestimo
		WHERE ee.cdexemplar = pcdexemplar
		AND e.cdaluno = pcdaluno);
	
	IF (pcdemprestimo IS NULL) THEN
		RAISE EXCEPTION 'Livro não emprestado!';
	END IF;
	
	IF (statusatual = 'disponivel') THEN
		mensagem = 'Este livro não está emprestado!';
	ELSE

		UPDATE emprestimo SET datadevolucao = CURRENT_DATE
		WHERE cdemprestimo = pcdemprestimo;
		
		UPDATE exemplar SET status = 'disponivel' WHERE cdexemplar = pcdexemplar;
		
		mensagem = 'Devolução realizada!';
	END IF;

END; $$ LANGUAGE plpgsql;


 SELECT devolucao('BILL', '23.2');
