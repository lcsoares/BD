CREATE TABLE jogador(
  jogador_id serial PRIMARY KEY NOT NULL,
    numero INT,
    nome VARCHAR(50) NOT NULL,
    idade INT NOT NULL,
    situação VARCHAR(50) NOT NULL,
    posição VARCHAR(50) NOT NULL
);
CREATE TABLE clube(
  clube_id serial PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NOT NULL,
    escudo VARCHAR(50) NOT NULL
);

CREATE TABLE estadio(
  estadio_id serial PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NOT NULL,
    capacidade INT NOT NULL,
    CEP VARCHAR(50)NOT NULL
);

CREATE TABLE tecnico(
  tecnico_id serial PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NOT NULL,
    idade INT NOT NULL
);

CREATE TABLE equipe(
  equipe_id serial PRIMARY KEY NOT NULL,
    clube_fk integer NOT NULL,
    tecnico_fk integer NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    categotia VARCHAR(50) NOT NULL,
    FOREIGN KEY (clube_fk) REFERENCES "clube"(clube_id),
    FOREIGN KEY (tecnico_fk) REFERENCES "tecnico"(tecnico_id)
);
CREATE TABLE partida(
  partida_id serial PRIMARY KEY NOT NULL,
    estadio_fk integer NOT NULL,
    mandante integer NOT NULL,
    visitante integer NOT NULL,
    PP VARCHAR(50) NOT NULL,
    dataa DATE NOT NULL,
    FOREIGN KEY (estadio_fk) REFERENCES "estadio"(estadio_id),
    FOREIGN KEY (mandante) REFERENCES "equipe"(equipe_id),
    FOREIGN KEY (visitante) REFERENCES "equipe"(equipe_id)
);
CREATE TABLE jogadorPartida(
  jogador_fk INTEGER NOT NULL,
    partida_fk integer NOT NULL,
    gol int NOT NULL,
    cartaoamarelo char(1) NOT NULL,
    cartaovermelho char(1) NOT NULL,
    FOREIGN KEY (jogador_fk) REFERENCES "jogador"(jogador_id),
    FOREIGN KEY (partida_fk) REFERENCES "partida"(partida_id),
    PRIMARY KEY (jogador_fk, partida_fk)
);
CREATE TABLE EquipeJogador(
  jogador_fk INTEGER NOT NULL,
    equipe_fk integer NOT NULL,
    FOREIGN KEY (jogador_fk) REFERENCES "jogador"(jogador_id),
    FOREIGN KEY (equipe_fk) REFERENCES "equipe"(equipe_id),
    PRIMARY KEY (jogador_fk, equipe_fk)
);

CREATE TABLE clubeEstadio(
  clube_fk INTEGER NOT NULL,
    estadio_fk integer NOT NULL,
    FOREIGN KEY (clube_fk) REFERENCES "clube"(clube_id),
    FOREIGN KEY (estadio_fk) REFERENCES "estadio"(estadio_id),
    PRIMARY KEY (clube_fk, estadio_fk)
);


/*Estadios em que o flamnego jogou*/

SELECT "clube".nome 
  FROM "clube" as clube , "equipe" as equipe, "partida" as partida,
  WHERE "clube".clube_id = "equipe".clube_fk
  AND "equipe".clube_fk = "partida".mandante or .visitante
  AND "equipe".mandante or .visitante = "Flamengo" ORDER BY;



/*quantos jogadores tomaram cartao vermelho*/

SELECT  "jogador".nome, count(vermelho) cartoesvermelho
FROM "jogador" as jogador, "JogadorPartida" as jogadorPartida
WHERE "jogador".jogador_id="jogadorpartida".jogador_fk  
GROUP BY "jogador".nome
ORDER BY count(vermelho);

/*quantos jogadores não fizeram gol*/

SELECT  count(distinct "jogador".jogador_id)
FROM Jogador as jogador, "JogadorPartida" as jogadorPartida
WHERE "jogador".jogador_id = "jogadorPartida".jogador_fk  and gols=0



