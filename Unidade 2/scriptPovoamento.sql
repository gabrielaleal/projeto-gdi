-- inserindo gêneros
INSERT INTO tb_Genero VALUES ('Ação', 'Alta');
INSERT INTO tb_Genero VALUES ('Comédia', 'Alta');
INSERT INTO tb_Genero VALUES ('Romance', 'Média');
INSERT INTO tb_Genero VALUES ('Drama', 'Alta');

-- inserindo diretores
INSERT INTO tb_Diretor VALUES ('Steven Spielberg', 'Americana', to_date ('29/08/1968', 'dd/mm/yyyy'));
INSERT INTO tb_Diretor VALUES ('Alan Taylor', 'Americana', to_date ('29/10/1965', 'dd/mm/yyyy'));
INSERT INTO tb_Diretor VALUES ('Tarantino', 'Americana', to_date ('12/09/1972', 'dd/mm/yyyy'));
INSERT INTO tb_Diretor VALUES ('Gary Ross', 'Americana', to_date ('03/11/1956', 'dd/mm/yyyy'));
INSERT INTO tb_Diretor VALUES ('Lisa Joy', 'Americana', to_date ('18/05/1982', 'dd/mm/yyyy'));

-- inserindo títulos (séries ou filmes)
INSERT INTO tb_Titulo VALUES (to_date ('28/11/2000', 'dd/mm/yyyy'), 'E.T.: O Extraterrestre', 'Para maiores de 10 anos', 8, 4, 1);
INSERT INTO tb_Titulo VALUES (to_date ('07/05/2016', 'dd/mm/yyyy'), 'Game Of Thrones', 'Para maiores de 16 anos', 10, 1, 2);
INSERT INTO tb_Titulo VALUES (to_date ('16/04/1997', 'dd/mm/yyyy'), 'Kill Bill', 'Para maiores de 16 anos', 9, 1, 3);
INSERT INTO tb_Titulo VALUES (to_date ('10/11/2014', 'dd/mm/yyyy'), 'Jogos Vorazes', 'Para maiores de 10 anos', 8, 3, 4);
INSERT INTO tb_Titulo VALUES (to_date ('10/11/2014', 'dd/mm/yyyy'), 'Westworld', 'Para maiores de 14 anos', 8, 1, 5);

INSERT INTO tb_Serie VALUES (2, 8);
INSERT INTO tb_Serie VALUES (5, 2);

INSERT INTO tb_Filme VALUES (1, 123);
INSERT INTO tb_Filme VALUES (3, 123);
INSERT INTO tb_Filme VALUES (4, 90);

-- inserindo episódios de série
INSERT INTO tb_Episodios_Serie VALUES (2, 1, 45, 'Winter Is Coming');
INSERT INTO tb_Episodios_Serie VALUES (2, 2, 47, 'The Kings Road');
INSERT INTO tb_Episodios_Serie VALUES (2, 3, 50, 'Lord Snow');
INSERT INTO tb_Episodios_Serie VALUES (2, 4, 48, 'Cripples, Bastards, and Broken Things');
INSERT INTO tb_Episodios_Serie VALUES (5, 1, 55, 'The Original');
INSERT INTO tb_Episodios_Serie VALUES (5, 2, 55, 'Chestnut');
INSERT INTO tb_Episodios_Serie VALUES (5, 3, 55, 'The Stray');
INSERT INTO tb_Episodios_Serie VALUES (5, 4, 55, 'Dissonance Theory');

-- inserindo estúdios
INSERT INTO tb_Estudio VALUES ('5th Avenue, 15', 'Miramax', to_date ('16/04/1997', 'dd/mm/yyyy'), 1);
INSERT INTO tb_Estudio VALUES ('7th Avenue, 30', 'HBO Sudios', to_date ('05/12/1995', 'dd/mm/yyyy'), 2);
INSERT INTO tb_Estudio VALUES ('Universal, Orlando', 'Universal Studios', to_date ('20/10/2004', 'dd/mm/yyyy'), 3);
INSERT INTO tb_Estudio VALUES ('Rodeo Drive, 140', 'Liongate', to_date ('20/10/2004', 'dd/mm/yyyy'), 4);
INSERT INTO tb_Estudio VALUES ('7th Avenue, 30', 'HBO', to_date ('20/10/2004', 'dd/mm/yyyy'), 5); 

-- inserindo listas
INSERT INTO tb_Lista VALUES (to_date ('20/04/2019', 'dd/mm/yyyy'), 'Ver mais tarde');
INSERT INTO tb_Lista VALUES (to_date ('19/04/2019', 'dd/mm/yyyy'), 'Ver mais depois');
INSERT INTO tb_Lista VALUES (to_date ('20/04/2019', 'dd/mm/yyyy'), 'Gostei');

-- inserindo cartões de crédito
INSERT INTO tb_Cartao_Credito VALUES (6661, 111, 'MasterCard');
INSERT INTO tb_Cartao_Credito VALUES (6662, 112, 'Visa');
INSERT INTO tb_Cartao_Credito VALUES (6663, 113, 'Elo');

-- inserindo usuários
INSERT INTO tb_Usuario VALUES ('user1@gmail.com', to_date ('20/04/1995', 'dd/mm/yyyy'), 'João das Neves', NULL, 6661);
INSERT INTO tb_Usuario VALUES ('user2@gmail.com', to_date ('23/08/1997', 'dd/mm/yyyy'), 'Eduardo Forte', 'user1@gmail.com', 6662);
INSERT INTO tb_Usuario VALUES ('user3@gmail.com', to_date ('15/09/1998', 'dd/mm/yyyy'), 'Samuel L Jackson', NULL, 6663);

-- inserindo títulos às listas (adiciona)
INSERT INTO tb_Adiciona VALUES ('user1@gmail.com', 1, 1);
INSERT INTO tb_Adiciona VALUES ('user2@gmail.com', 2, 2);
INSERT INTO tb_Adiciona VALUES ('user3@gmail.com', 3, 1);

-- inserindo títulos assistidos (assiste)
INSERT INTO tb_Assiste VALUES ('user1@gmail.com', 1, to_date ('20/04/2019', 'dd/mm/yyyy'));
INSERT INTO tb_Assiste VALUES ('user1@gmail.com', 3, to_date ('22/04/2019', 'dd/mm/yyyy'));
INSERT INTO tb_Assiste VALUES ('user2@gmail.com', 2, to_date ('21/04/2019', 'dd/mm/yyyy'));
INSERT INTO tb_Assiste VALUES ('user2@gmail.com', 5, to_date ('06/05/2019', 'dd/mm/yyyy'));
INSERT INTO tb_Assiste VALUES ('user3@gmail.com', 3, to_date ('24/04/2019', 'dd/mm/yyyy'));
INSERT INTO tb_Assiste VALUES ('user3@gmail.com', 4, to_date ('07/05/2019', 'dd/mm/yyyy'));

-- inserindo relação entre títulos e diretores (dirige)
INSERT INTO tb_Dirige VALUES (1, 1, 'Cannes', 'Melhor Filme', to_date ('16/04/2019', 'dd/mm/yyyy'));
INSERT INTO tb_Dirige VALUES (3, 3, 'Oscar', 'Melhor Filme', to_date ('21/04/2019', 'dd/mm/yyyy'));

-- inserindo prêmios
INSERT INTO tb_Premio VALUES ('Melhor Filme', 1, 1, 'Prêmio Luana Amado', 30000);