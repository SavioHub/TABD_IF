select * from emprestimo;
select * from emprestimoexemplar;
select * from exemplar;
select * from publicacao;
select * from autor;
select * from editora;

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

1, 5 e 7
					
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
								
1, 5 e 7 emprestimo e 1, 5 e 7 EmprestimoExemplar
								

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
								
 1,5 e 7 exemplar
 
 

 
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
