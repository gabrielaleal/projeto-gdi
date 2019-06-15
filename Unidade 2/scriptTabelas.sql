DROP TABLE tp_Premio;
DROP TABLE tp_Dirige;
DROP TABLE tp_Assiste;
DROP TABLE tp_Adiciona;
DROP TABLE tp_Episodios;
DROP TABLE tp_Filme;
DROP TABLE tp_Serie;
DROP TABLE tp_Usuario;
DROP TABLE tp_Cartao_Credito;
DROP TABLE tp_Lista;
DROP TABLE tp_Estudio;
DROP TABLE tp_Titulo;
DROP TABLE tp_Diretor;
DROP TABLE tp_Genero;

CREATE TABLE tb_Genero OF tp_Genero (
	PRIMARY KEY (Codigo_Genero)
);

CREATE TABLE tb_Diretor OF tp_Diretor (
	PRIMARY KEY (Codigo_Diretor)
);

CREATE TABLE tb_Titulo OF tp_Titulo (
	PRIMARY KEY (Codigo_Titulo),
    FOREIGN KEY (Codigo_Genero) REFERENCES tb_Genero,
    FOREIGN KEY (Codigo_Diretor) REFERENCES tb_Diretor
);

CREATE TABLE tb_Estudio OF tp_Estudio (
	PRIMARY KEY (Codigo_Estudio),
    FOREIGN KEY (ref_Titulo) REFERENCES tb_Titulo
);

CREATE TABLE tb_Lista OF tp_Lista (
    PRIMARY KEY (Codigo_Lista)
);

CREATE TABLE tb_Cartao_Credito OF tp_Cartao_Credito (
    PRIMARY KEY (Numero)
);

CREATE TABLE tb_Usuario OF tp_Usuario (
    PRIMARY KEY (Email),
    FOREIGN KEY (Numero) REFERENCES tb_Cartao_Credito,
    FOREIGN KEY (ref_Administrador) REFERENCES tb_Usuario,
);

CREATE TABLE tb_Serie OF tp_Serie (
    PRIMARY KEY (Codigo_Titulo)
);

CREATE TABLE tb_Filme OF tp_Filme (
    PRIMARY KEY (Codigo_Titulo)
);

CREATE TABLE tb_Episodios_Serie OF tp_Episodios_Serie (
    PRIMARY KEY (Codigo_Titulo, Numero_Episodio),
    FOREIGN KEY (ref_Serie) REFERENCES tb_Serie
);

CREATE TABLE tb_Adiciona OF tp_Adiciona (
    PRIMARY KEY (Email, Codigo_Lista, Codigo_Titulo),
    FOREIGN KEY (ref_Lista) REFERENCES tb_Lista,
    FOREIGN KEY (ref_Titulo) REFERENCES tb_Titulo
);

CREATE TABLE tb_Assiste OF tp_Assiste (
    PRIMARY KEY (Email, Codigo_Titulo),
    FOREIGN KEY (ref_Titulo) REFERENCES tb_Titulo
);

CREATE TABLE tb_Dirige OF tp_Dirige (
    PRIMARY KEY (Codigo_Titulo, Codigo_Diretor),
    FOREIGN KEY (ref_Titulo) REFERENCES tb_Titulo,
    FOREIGN KEY (ref_Diretor) REFERENCES tb_Diretor
);

CREATE TABLE tb_Premio OF tp_Premio (
    PRIMARY KEY (Categoria, Codigo_Titulo, Codigo_Diretor),
    FOREIGN KEY (ref_Titulo) REFERENCES tb_Titulo,
    FOREIGN KEY (ref_Diretor) REFERENCES tb_Diretor
);