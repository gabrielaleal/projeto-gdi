--1.
CREATE OR REPLACE TYPE tp_Estudio AS OBJECT (
	Codigo_Estudio NUMBER,
    Local VARCHAR(50),
    Nome VARCHAR(50),
    Data_Lancamento DATE,
    ref_Titulo REF tp_Titulo
) FINAL;

--2.
CREATE OR REPLACE TYPE tp_Diretor AS OBJECT (
    Codigo_Diretor NUMBER,
	Nome VARCHAR2(50),
    Nacionalidade VARCHAR (50),
	Data_Nascimento DATE,
    Genero tp_Genero
) FINAL;

CREATE OR REPLACE TYPE tp_Serie under tp_Titulo (
    Qtd_Temporadas NUMBER
) FINAL;

CREATE OR REPLACE TYPE tp_Filme under tp_Titulo (
    Duracao NUMBER
) FINAL;

--3.
CREATE OR REPLACE TYPE tp_va_email AS VARRAY(3) OF VARCHAR2(40);

--12.
ALTER TYPE tp_Usuario
    MODIFY ATTRIBUTE Email tp_va_email CASCADE;

--4. 26.
CREATE OR REPLACE TYPE tp_nt_titulos AS TABLE OF VARCHAR(30); -- 4

CREATE TABLE nested_table (id NUMBER, col1 tp_nt_titulos) -- pretexto pro código da 26 funcionar
    NESTED TABLE col1 STORE AS col1_tab;

INSERT INTO nested_table VALUES (1, tp_nt_titulos('A')); -- pretexto pro código da 26 funcionar
INSERT INTO nested_table VALUES (2, tp_nt_titulos('B', 'C')); -- pretexto pro código da 26 funcionar

SELECT * FROM nested_table; -- 26

--11.
ALTER TYPE tp_Episodios_Serie
    ADD ATTRIBUTE nome_titulo tp_nt_titulos;

--5.
ALTER TYPE tp_Genero
    ADD CONSTRUCTOR FUNCTION tp_Genero(Codigo_Genero NUMBER, Nome VARCHAR2) RETURN SELF AS RESULT CASCADE;

CREATE OR REPLACE TYPE BODY tp_Genero AS    
    CONSTRUCTOR FUNCTION tp_Genero(Codigo_Genero NUMBER, Nome VARCHAR2) RETURN SELF AS RESULT AS
    BEGIN
        SELF.Codigo_Genero := Codigo_Genero;
        SELF.Nome := Nome;
        SELF.Popularidade := 'Ainda não avaliado';
        RETURN;
    END
END

-- 13.
ALTER TYPE tp_Diretor
    DROP ATTRIBUTE Data_Nascimento DATE INVALIDATE;

--14.
ALTER TYPE tp_Titulo
    MODIFY ATTRIBUTE Nome VARCHAR(40) CASCADE;

--15.
ALTER TYPE tp_Titulo
    MODIFY ATTRIBUTE Avaliacao VARCHAR2(10) INVALIDATE;

--16.
SELECT DR.Codigo_Diretor.Nome
FROM tb_Dirige DR
WHERE DR.Codigo_Diretor IS DANGLING

--17.
ALTER TABLE tb_Usuario
    MODIFY ref_Administrador SCOPE IS tb_Usuario;

--18.
DROP TYPE tp_Diretor force;
DROP TABLE tb_Diretor;

CREATE OR REPLACE TYPE tp_Diretor AS OBJECT (
	Codigo_Diretor NUMBER,
	Nome VARCHAR2(50),
    Nacionalidade VARCHAR (50),
	Data_Nascimento DATE
) FINAL;
/
-- T
CREATE TABLE tb_Diretor OF tp_Diretor (
	PRIMARY KEY (Codigo_Diretor)
);
-- T

--19.
SELECT AD.Codigo_Titulo.ref_Genero.nome
FROM tb_Adiciona
WHERE AD.Codigo_Titulo = 1

--20.
SELECT DEREF(T.ref_Genero) as GEN
FROM tb_Titulo T

--21.
SELECT VALUE(A) as TITULOS
FROM tb_Assiste A

--22. 25.
SELECT *
FROM TABLE(
    SELECT U.Email
    FROM tb_Usuario U
    WHERE U.Nome = 'João das Neves'
)

--23.
SELECT *
FROM TABLE(
    SELECT ES.nome_titulo
    FROM tb_Episodios_Serie ES
    WHERE U.Codigo_Titulo = 1
)

--6.
ALTER TYPE tp_Usuario
    ADD MEMBER FUNCTION nameToCatital RETURN VARCHAR CASCADE;
    
CREATE OR REPLACE TYPE BODY tp_Usuario AS
    MEMBER FUNCTION nameToCapital RETURN VARCHAR IS
    BEGIN
        RETURN UPPER(SELF.Nome);
    END;
END;
/
DECLARE
    usuarioAdm tp_Usuario;
BEGIN
    SELECT DEREF(ref_Administrador) INTO usuarioAdm
    FROM tb_Usuario
    WHERE Email = 'user1@gmail.com';
    DBMS_OUTPUT.PUT_LINE(usuarioAdm.nameToCapital());
END;

--7 e 9 e 10.
ALTER TYPE tp_Titulo
    ADD MAP MEMBER FUNCTION tituloToInt RETURN NUMBER CASCADE;
    
ALTER TYPE tp_Serie
    ADD OVERRIDING MAP MEMBER FUNCTION tituloToInt RETURN NUMBER CASCADE;
CREATE OR REPLACE TYPE BODY tp_Serie AS
    OVERRIDING MAP MEMBER FUNCTION tituloToInt RETURN NUMBER IS
    BEGIN
        RETURN Qtd_Temporadas;
    END;
END;
/
BEGIN
    SELECT R.ref_Serie.Nome
    FROM tb_Episodios_Serie R
    ORDER BY DEREF(R.ref_Serie);
END;

--8.
ALTER TYPE tp_Usuario
    ADD ORDER MEMBER FUNCTION isOlderThan (otherUser tp_Usuario) RETURN NUMBER CASCADE;

CREATE OR REPLACE TYPE BODY tp_Usuario AS
    ORDER MEMBER FUNCTION comp (otherUser tp_Usuario) RETURN NUMBER IS
    BEGIN
        RETURN otherUser.Data_Nascimento - SELF.Data_Nascimento;
    END;
END;
/
DECLARE
    userTest tp_Usuario;
    userTest2 tp_Usuario;
    us1 tp_Usuario;
    ct1 tp_Cartao_Credito;
BEGIN
    SELECT REF(U) INTO us1 FROM tb_Usuario U WHERE U.Email = 'user1@gmail.com';
    SELECT REF(C) FROM tb_Cartao_Credito C WHERE C.Numero = 6662;
    userTest := new tp_Usuario('usertest@gmail.com', to_date ('23/08/1971', 'dd/mm/yyyy'), 'Eduardo Fraco', us1, ct1);
    userTest2 := new tp_Usuario('usertest2@gmail.com', to_date ('23/08/1973', 'dd/mm/yyyy'), 'Eduardo Corno', us1, ct1);

    IF (userTest.isOlderThan(userTest2) > 0) THEN
        DBMS_OUTPUT.PUT_LINE('É mais velho');
    ELSE IF (userTest.isOlderThan(userTest2) < 0) THEN
        DBMS_OUTPUT.PUT_LINE('É mais novo');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Os dois têm a mesma idade');
    END IF;

END;

--23.
SELECT S.Nome
FROM tb_Serie S
ORDER BY S.Qtd_Temporadas;

SELECT S.Nome, S.Classificacao
FROM tb_Serie S
GROUP BY S.Nome, S.Classificacao;

-- Série com mais de 5 episódios
SELECT S.ref_Serie.Nome
FROM tb_Episodios_Serie S
GROUP BY S.ref_Serie.Nome
HAVING COUNT (S.ref_Serie) > 5;

SELECT U.Nome
FROM tb_Usuario U
WHERE U.Nome LIKE 'Ed%';

SELECT U.Nome
From tb_Usuario U
WHERE U.Data_Nascimento BETWEEN to_date ('23/08/1990', 'dd/mm/yyyy') AND to_date ('23/08/2000', 'dd/mm/yyyy');

--24.
SELECT S.Nome
FROM tb_Serie S
WHERE S.Qtd_Temporadas IN (1, 2, 3, 4, 5);

SELECT S.Nome
FROM tb_Serie S
WHERE S.Qtd_Temporadas = ALL (6, 8, 10, 20);

SELECT S.Nome
FROM tb_Serie S
WHERE S.Qtd_Temporadas = ANY (6, 8, 10, 20);

--27.
SELECT *
FROM tb_Diretor D
WHERE EXISTS (
    SELECT *
    FROM tb_Premio P
    WHERE DEREF(P.ref_Diretor).Codigo_Diretor = D.Codigo_Diretor
);

--28.
CREATE OR REPLACE TRIGGER novoUser
BEFORE INSERT OR UPDATE ON tb_Usuario
FOR EACH ROW
BEGIN
   dbms_output.put_line('Novo usuário cadastrado');
END novoUser;

--29.
CREATE OR REPLACE TRIGGER checkAvaliacao
BEFORE INSERT OR UPDATE OR DELETE ON tb_Serie
FOR EACH ROW
BEGIN
IF :new.Avaliacao < 5 THEN
RAISE_APPLICATION_ERROR(-20222,'Apenas séries com avaliação acima de 5!');
END IF;
END checkAvaliacao;

INSERT INTO tb_Serie VALUES (
    20,
    to_date ('07/05/2016', 'dd/mm/yyyy'),
    'Game Of Thrones',
    'Para maiores de 16 anos',
    4,
    (SELECT REF(G) FROM tb_Genero G WHERE G.Codigo_Genero = 1),
    (SELECT REF(D) FROM tb_Diretor D WHERE D.Codigo_Diretor = 2),
    8
);

--30.
CREATE OR REPLACE TRIGGER noMoreListas
BEFORE INSERT OR UPDATE OR DELETE ON tb_Lista
BEGIN
RAISE_APPLICATION_ERROR(-20222,'Não é possível adicionar mais listas.');
END noMoreListas;