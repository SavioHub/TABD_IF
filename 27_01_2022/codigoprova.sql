set schema 'savio';



CREATE TABLE ALUNO (
    CDALUNO INTEGER NOT NULL,
    NOME VARCHAR(40) ,
    NMATRICULA VARCHAR(15) ,
    STATUS CHAR(2) 
);


insert into ALUNO values (1, 'ANTONIO', '00001-2021', 'MT'),
                         (2, 'BILL',    '00002-2021', 'MT'),
                         (3, 'STEVE',   '00003-2021', 'MT'),
                         (4, 'LINUS',   '00004-2021', 'MT'),
                         (5, 'JOBS',    '00005-2021', 'MT'),
                         (6, 'ADA',     '00006-2021', 'MT'),
                         (7, 'TURING',   '00007-2021', 'MT');

                      



CREATE TABLE CURSO (
    CDCURSO INTEGER NOT NULL,
    NOMECURSO VARCHAR(20) ,
    VALORCURSO NUMERIC(7,2)
);


insert into CURSO values(10, 'ADS', 800.00),
                        (11, 'QUIMICA',900.00),
                        (12, 'AGRONOMIA', 1000.00),
                        (13, 'AGROINDUSTRIA', 1100.00);





CREATE TABLE PROFESSOR (
    CDPROFESSOR INTEGER NOT NULL,
    NOME VARCHAR(40)
 );

                    
insert into PROFESSOR values(20,  'GEORGE'),
                             (21, 'NAIDSON'),
                             (22, 'FABIO'),
                             (23, 'WOQUITON'),
                             (24, 'BARBARA'),
                             (25, 'ALEX'),
                             (26, 'LEANDRO');





CREATE TABLE DISCIPLINA (
    CDDISCIPLINA INTEGER NOT NULL,
    NOMEDISCIPLINA varchar(40),
    VALOR NUMERIC(7,2)
);


insert into DISCIPLINA values(30, 'ALGORITMO',500.00),
                             (31, 'BD', 600.00),
                             (32, 'TABD', 600.00),
                             (33, 'SO', 700.00),
                             (34, 'RUMINANTES', 800.00),
                             (35, 'PLANTAS', 800.00),
                             (36, 'REMEDIOS',500.00);





CREATE TABLE SEMESTRE (
    CDSEMESTRE INTEGER NOT NULL,
    ANO VARCHAR(15)
);


INSERT INTO SEMESTRE VALUES(50,'2020.2'),
                           (51,'2021.1'),
                           (52,'2021.2');





CREATE TABLE TURMA (
    CDTURMA INTEGER NOT NULL,
    NOMETURMA VARCHAR(20)
);


INSERT INTO TURMA VALUES(60,'PROGRAMADORES'),
                        (61,'ANALISTAS'),
                        (62, 'AGRONOMOS'),
                        (63, 'QUIMICOS');






CREATE TABLE MATRICULA (
    CDMATRICULA INTEGER NOT NULL,
    CDCURSO INTEGER,
    CDALUNO INTEGER,
    CDSEMESTRE INTEGER,
    VALORMATRICULA NUMERIC(7,2),
    CDTURMA INTEGER
);


INSERT INTO MATRICULA values( 100, 10, 1, 50,300.00,60),
                            ( 101, 10, 2, 50,400.00,60),
                            ( 102, 10, 3, 50,500.00,61),
                            ( 103, 10, 4, 50,500.00,61),
                            ( 104, 10, 1, 51, 300.00, 60),
                            ( 105, 10, 2, 51, 400.00, 60),
                            ( 106, 10, 3, 51, 500.00, 61),                         
                            ( 108, 10, 1, 52, 300.00, 60),
                            ( 109, 10, 2, 52, 400.00, 60),
                            ( 110, 11, 5, 52, 500.00, 63),                         
                            ( 111, 12, 6, 52, 500.00, 62),
                            ( 112, 11, 5, 50, 500.00, 63);                     





CREATE TABLE MATDISCIPLINA (
    CDMATDISCIPLINA INTEGER NOT NULL,
    CDMATRICULA INTEGER,
    CDDISCIPLINA INTEGER,
    MEDIA NUMERIC(7,2),
    STATUS CHAR(2) ,
    CDPROFESSOR INTEGER,
    VALOR NUMERIC(7,2)
);



insert into MATDISCIPLINA(cdmatdisciplina,cdmatricula,cddisciplina, status,valor) 

           values( 1,100,30,'MT', 500.00),           
				 ( 2,101,30,'MT', 600.00),
                 ( 3,102,30,'MT', 600.00),
				 ( 4,103,30,'MT', 500.00),			 
				 ( 5,100,31,'MT', 500.00),           
				 ( 6,101,31,'MT', 600.00),
                 ( 7,102,31,'MT', 600.00),
				 ( 8,103,31,'MT', 500.00),
				 ( 9,104,32,'MT', 500.00),           
				 ( 10,105,32,'MT', 600.00),
                 ( 11,106,32,'MT', 600.00),
				 (12,104,33,'MT', 500.00),           
				 ( 13,105,33,'MT', 600.00),
                 ( 14,106,33,'MT', 600.00),
				 ( 15,108,33,'MT', 600.00),
                 ( 16,109,33,'MT', 600.00),
				 ( 17,110,35,'MT', 600.00),
				 ( 18,112,35,'MT', 600.00),
				 ( 19,111,34,'MT', 600.00);







CREATE TABLE NOTA (
    CDNOTA INTEGER NOT NULL,
    CDMATDISCIPLINA INTEGER,
    NOTA NUMERIC(7,2),
    REFERENCIA VARCHAR(20) ,
    STATUS CHAR(2)
);


insert into NOTA ( CDNOTA, CDMATDISCIPLINA, NOTA, REFERENCIA, STATUS)values
   (1, 1, 8.00, 'Av I',   'AP'),
   (2, 1, 4.00, 'AV II',  'RP'),
   (3, 1, 3.00, 'AV III', 'RP'),
   (4, 2, 6.00, 'Av I',   'RP'),
   (5, 2, 4.00, 'AV II',  'RP'),
   (6, 2, 8.00, 'Av I',   'AP'),
   (8, 3, 8.00, 'AV I',   'AP'),
   (9, 3, 8.00, 'Av II',   'AP'),
   (10, 3, 4.00, 'AV III', 'RP'),
   (11, 3, 3.00, 'AV IV','RP'),
   (12, 4, 5.00, 'Av I',  'RP'),
   (13, 4, 5.00, 'AV II', 'RP'),
   (14, 5, 7.00, 'Av I',  'AP'),
   (15, 5, 3.00, 'AV II',  'RP'),
   (16, 5, 6.00, 'Av III',  'RP'),
   (17, 5, 4.00, 'AV IV',  'RP'),
   (18, 6, 9.00, 'AV I',  'AP'),
   (19, 6, 10.00, 'AV I', 'AP'),
   (20, 7, 7.00, 'AV II',  'AP'),
   (21, 8, 6.00, 'AV I',  'RP'),
   (22, 9, 6.00, 'AV I',  'RP'),
   (23, 10, 4.00, 'AV I',  'RP'),
   (24, 11, 3.00, 'AV I',  'RP'),
   (25, 12, 4.00, 'AV I',  'RP'),
   (26, 14, 2.00, 'AV I',  'RP'),
   (27, 15, 1.00, 'AV I',  'RP'),
   (28, 16, 4.00, 'AV I',  'RP'),
   (29, 17, 3.00, 'AV I',  'RP'),
   (30, 18, 2.00, 'AV I',  'RP'),
   (31, 19, 5.00, 'AV I',  'RP');


--sessão de chaves primarias e chaves estrangeiras 

alter table aluno add primary key(cdaluno);
alter table professor add primary key(cdprofessor);
alter table CURSO add primary key(cdCURSO);
alter table DISCIPLINA add primary key(cdDISCIPLINA);
alter table SEMESTRE add primary key(cdSEMESTRE);
alter table TURMA add primary key(cdTURMA);
alter table MATRICULA add primary key(cdMATRICULA);
alter table MATdisciplina add primary key(cdMATdisciplina);

ALTER TABLE matricula ADD CONSTRAINT FK_CD_curso FOREIGN KEY (cdcurso) REFERENCES curso(CDcurso);
ALTER TABLE matricula ADD CONSTRAINT FK_CD_semestre FOREIGN KEY (cdsemestre) REFERENCES semestre(CDsemestre);
ALTER TABLE matricula ADD CONSTRAINT FK_CD_aluno FOREIGN KEY (cdaluno) REFERENCES aluno(CDaluno);
ALTER TABLE matricula ADD CONSTRAINT FK_CD_turma FOREIGN KEY (cdturma) REFERENCES turma(CDturma);
ALTER TABLE matdisciplina ADD CONSTRAINT FK_CD_matricula FOREIGN KEY (cdmatricula) REFERENCES matricula(CDmatricula);
ALTER TABLE matdisciplina ADD CONSTRAINT FK_CD_professor FOREIGN KEY (cdprofessor) REFERENCES professor(CDprofessor);
ALTER TABLE matdisciplina ADD CONSTRAINT FK_CD_diciplina FOREIGN KEY (cddisciplina) REFERENCES disciplina(CDdisciplina);
ALTER TABLE nota ADD CONSTRAINT FK_CD_matdisc FOREIGN KEY (cdmatdisciplina) REFERENCES matdisciplina(CDmatdisciplina);


----------------------------------------MODIFICAÇÕES encontradas no MER------------------------------------------------------

--Na Tabela Semestre foi  add o atributo semestreatual

    ALTER TABLE SEMESTRE add column SEMESTREATUAL varchar(10);

--Na tabela Curso foi retirado  o atributo Valorcurso

    ALTER TABLE CURSO drop COLUMN VALORCURSO;

--Aviso
--Continuou com a pegadinha da chave primária de  professor 
--estar interligada  com a tabela Disciplina, mas foi só no diagrama , 
--no codigo aqui, ele não colocou. E não é preciso mudar aqui no codigo. 

----------------------------------------TABELAS NOVAS ADICIONADAS NO DIAGRAMA------------------------------------------------------


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

 ---------------------------sessão de chaves primarias e chaves estrangeiras das novas tabelas-----------------------------

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


--------------------------------------------------------------
select * from emprestimo;
select * from emprestimoexemplar;
select * from exemplar;
select * from publicacao;
select * from autor;
select * from editora;

select * from aluno;


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
			
							
							
update exemplar set numeroexemplar = '342732432' where cdexemplar in (select cdexemplar from emprestimoexemplar where cdemprestimo in 
																			 (select cdemprestimo from emprestimo where cdaluno in 
																			  (select cdaluno from aluno where nome = 'TURING')));


create function emprestarLivro(pcdemprestimo integer, pdataemprestimo date, pdatadevolucao date, pcdaluno integer,) 

returns void AS 

$$ 

begin  

insert into emprestimo values(pcdemprestimo, pdataemprestimo, pdatadevolucao, pcdaluno); 

insert into emprestimoexemplar values(123, 1, pcdemprestimo); 

end; 

$$language plpgsql 

  

select emprestarLivro(5, '2022-01-25', '2022-02-27', 3) 

------------------------------------------------------------------------------------------------------------------------------------- 

create or replace function devolverlivro(pcdnumeroexemplar varchar(10)) 

returns void AS 

$$ 

declare pcdexemplar integer; 

begin  

  

pcdexemplar= (select cdexemplar from exemplar where numeroexemplar = pcdnumeroexemplar); 

update exemplar set status = 'devolvido' where cdexemplar = pcdexemplar; 

  

end; 

  

$$language plpgsql 

  

select devolverlivro('casmurro') 													
