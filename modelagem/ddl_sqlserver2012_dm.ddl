-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-05-18 01:19:35 BRT
--   site:      SQL Server 2012
--   tipo:      SQL Server 2012



CREATE TABLE AKUMADEX 
    (
     id_nivel INTEGER NOT NULL , 
     id_usuario INTEGER NOT NULL , 
     data_descoberta DATETIME NOT NULL 
    )
GO

ALTER TABLE AKUMADEX ADD CONSTRAINT PK_AKUMADEX PRIMARY KEY CLUSTERED (id_nivel, id_usuario)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE CATEGORIA 
    (
     id_categoria INTEGER NOT NULL , 
     nome_categoria VARCHAR (50) NOT NULL , 
     ds_categoria TEXT NOT NULL 
    )
GO

ALTER TABLE CATEGORIA ADD CONSTRAINT PK_CATEGORIA PRIMARY KEY CLUSTERED (id_categoria)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE EVOLUCAO 
    (
     id_evolucao INTEGER NOT NULL , 
     id_nivel INTEGER NOT NULL , 
     qt_instancias INTEGER NOT NULL , 
     nivel_resultado TINYINT NOT NULL 
    )
GO

ALTER TABLE EVOLUCAO ADD CONSTRAINT PK_EVOLUCAO PRIMARY KEY CLUSTERED (id_evolucao)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE EVOLUCAO ADD CONSTRAINT UN_NIVEL_EVOLUCAO UNIQUE NONCLUSTERED (id_nivel, nivel_resultado)
GO

CREATE TABLE FRUTA 
    (
     id_fruta INTEGER NOT NULL , 
     id_nivel INTEGER NOT NULL , 
     id_usuario INTEGER NOT NULL , 
     status_fruta CHAR (1) NOT NULL 
    )
GO

ALTER TABLE FRUTA ADD CONSTRAINT PK_FRUTA PRIMARY KEY CLUSTERED (id_fruta)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE FRUTA ADD CONSTRAINT CK_STATUS_FRUTA CHECK ( status_fruta IN ('D','S','T') ) 
GO

CREATE TABLE FRUTA_TROCA 
    (
     id_troca INTEGER NOT NULL , 
     id_fruta INTEGER NOT NULL , 
     papel_fruta CHAR (1) NOT NULL 
    )
GO

ALTER TABLE FRUTA_TROCA ADD CONSTRAINT PK_FRUTA_TROCA PRIMARY KEY CLUSTERED (id_troca, id_fruta)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE FRUTA_TROCA ADD CONSTRAINT CK_PAPEL_FRUTA CHECK ( papel_fruta IN ('O','S') ) 
GO

CREATE TABLE HISTORICO 
    (
     id_registro INTEGER NOT NULL , 
     id_grupo INTEGER NOT NULL , 
     id_nivel_fruta INTEGER NOT NULL , 
     tipo_transacao CHAR (1) NOT NULL , 
     origem INTEGER NOT NULL , 
     destino INTEGER NOT NULL , 
     valor_belis INTEGER NOT NULL , 
     data_registro DATETIME NOT NULL 
    )
GO

ALTER TABLE HISTORICO ADD CONSTRAINT PK_HISTORICO PRIMARY KEY CLUSTERED (id_registro, id_grupo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE HISTORICO ADD CONSTRAINT CK_TIPO_TRANSACAO CHECK ( tipo_transacao IN ('T', 'C', 'V', 'G') ) 
GO

CREATE TABLE MODELO 
    (
     id_modelo INTEGER NOT NULL , 
     id_categoria INTEGER NOT NULL , 
     nome_conhecido VARCHAR (100) NOT NULL , 
     nome_cientifico VARCHAR (100) NOT NULL , 
     max_evolucao TINYINT NOT NULL 
    )
GO

ALTER TABLE MODELO ADD CONSTRAINT PK_MODELO PRIMARY KEY CLUSTERED (id_modelo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE NIVEL 
    (
     id_nivel INTEGER NOT NULL , 
     id_modelo INTEGER NOT NULL , 
     nome_atribuído VARCHAR (100) , 
     nivel_fruta TINYINT NOT NULL , 
     raridade_fruta INTEGER NOT NULL , 
     preco_base INTEGER NOT NULL , 
     limite_loja INTEGER NOT NULL , 
     ds_fruta TEXT NOT NULL , 
     img_fruta VARCHAR (255) NOT NULL 
    )
GO

ALTER TABLE NIVEL ADD CONSTRAINT PK_NIVEL PRIMARY KEY CLUSTERED (id_nivel)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE NIVEL ADD CONSTRAINT UN_NIVEL_MODELO UNIQUE NONCLUSTERED (id_nivel, id_modelo)
GO

CREATE TABLE PORTADOR 
    (
     id_portador INTEGER NOT NULL , 
     id_modelo INTEGER NOT NULL , 
     nome_portador VARCHAR (100) NOT NULL , 
     portador_vivo BIT NOT NULL , 
     ds_portador TEXT NOT NULL 
    )
GO

ALTER TABLE PORTADOR ADD CONSTRAINT PK_PORTADOR PRIMARY KEY CLUSTERED (id_portador)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE PORTADOR ADD CONSTRAINT CK_PORTADOR_VIVO CHECK ( portador_vivo IN ('V', 'M') ) 
GO

CREATE TABLE TROCA 
    (
     id_troca INTEGER NOT NULL , 
     status_troca CHAR (1) NOT NULL , 
     dt_oferta DATETIME NOT NULL , 
     dt_finalizado DATETIME 
    )
GO

ALTER TABLE TROCA ADD CONSTRAINT PK_TROCA PRIMARY KEY CLUSTERED (id_troca)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE TROCA ADD CONSTRAINT CK_STATUS_TROCA CHECK ( status_troca IN ('P','A','R','E') ) 
GO

CREATE TABLE USUARIO 
    (
     id_usuario INTEGER NOT NULL , 
     nome_usuario VARCHAR (50) NOT NULL , 
     email_usuario VARCHAR (100) NOT NULL , 
     hash_senha VARCHAR (255) NOT NULL , 
     qt_belis INTEGER NOT NULL , 
     streak_login INTEGER NOT NULL , 
     ultimo_login DATETIME NOT NULL , 
     email_verificado BIT NOT NULL , 
     status_usuario CHAR (1) NOT NULL , 
     dt_cadastro DATETIME NOT NULL 
    )
GO

ALTER TABLE USUARIO ADD CONSTRAINT PK_USUARIO PRIMARY KEY CLUSTERED (id_usuario)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE USUARIO ADD CONSTRAINT UN_EMAIL_USUARIO UNIQUE NONCLUSTERED (email_usuario)
GO
ALTER TABLE USUARIO ADD CONSTRAINT UN_NOME_USUARIO UNIQUE NONCLUSTERED (nome_usuario)
GO

ALTER TABLE USUARIO ADD CONSTRAINT CK_STATUS_USUARIO CHECK ( status_usuario IN ('A', 'I') ) 
GO


ALTER TABLE USUARIO ADD CONSTRAINT CK_EMAIL_VERIFICADO CHECK ( email_verificado IN ('V','N') ) 
GO

ALTER TABLE AKUMADEX 
    ADD CONSTRAINT FK_AKUMADEX_NIVEL FOREIGN KEY 
    ( 
     id_nivel
    ) 
    REFERENCES NIVEL 
    ( 
     id_nivel 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE AKUMADEX 
    ADD CONSTRAINT FK_AKUMADEX_USUARIO FOREIGN KEY 
    ( 
     id_usuario
    ) 
    REFERENCES USUARIO 
    ( 
     id_usuario 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE EVOLUCAO 
    ADD CONSTRAINT FK_EVOLUCAO_NIVEL FOREIGN KEY 
    ( 
     id_nivel
    ) 
    REFERENCES NIVEL 
    ( 
     id_nivel 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FRUTA 
    ADD CONSTRAINT FK_FRUTA_NIVEL FOREIGN KEY 
    ( 
     id_nivel
    ) 
    REFERENCES NIVEL 
    ( 
     id_nivel 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FRUTA_TROCA 
    ADD CONSTRAINT FK_FRUTA_TROCA_FRUTA FOREIGN KEY 
    ( 
     id_fruta
    ) 
    REFERENCES FRUTA 
    ( 
     id_fruta 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FRUTA_TROCA 
    ADD CONSTRAINT FK_FRUTA_TROCA_TROCA FOREIGN KEY 
    ( 
     id_troca
    ) 
    REFERENCES TROCA 
    ( 
     id_troca 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FRUTA 
    ADD CONSTRAINT FK_FRUTA_USUARIO FOREIGN KEY 
    ( 
     id_usuario
    ) 
    REFERENCES USUARIO 
    ( 
     id_usuario 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE MODELO 
    ADD CONSTRAINT FK_MODELO_CATEGORIA FOREIGN KEY 
    ( 
     id_categoria
    ) 
    REFERENCES CATEGORIA 
    ( 
     id_categoria 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE NIVEL 
    ADD CONSTRAINT FK_NIVEL_MODELO FOREIGN KEY 
    ( 
     id_modelo
    ) 
    REFERENCES MODELO 
    ( 
     id_modelo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE PORTADOR 
    ADD CONSTRAINT FK_PORTADOR_MODELO FOREIGN KEY 
    ( 
     id_modelo
    ) 
    REFERENCES MODELO 
    ( 
     id_modelo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             32
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
