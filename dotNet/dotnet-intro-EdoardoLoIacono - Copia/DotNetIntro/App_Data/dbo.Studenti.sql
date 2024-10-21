CREATE TABLE [dbo].[Studenti] (
    [Id]          INT          NOT NULL IDENTITY,
    [Nome]        VARCHAR (50) NULL,
    [Cognome]     VARCHAR (50) NULL,
    [AnnoNascita] SMALLINT     NULL,
    [Genere]      CHAR (1)     NULL,
    [id_Classe] INT NOT NULL, 
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

