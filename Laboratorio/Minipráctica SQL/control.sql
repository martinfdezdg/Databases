/abolish

CREATE TABLE jugadores (
  nick varchar(20) not null,
  edad int check(edad>0) not null,
  ciudad varchar(20) not null,
  primary key(nick)
);

create table juegos (
  nombre varchar(20) not null,
  tipo varchar(20) check (tipo='puzzle' or tipo='estrategia' or tipo='plataformas') not null,
  niveles int check (niveles>0 and niveles<11) not null,
  primary key (nombre)
);

create table partidas (
  juego varchar(20) not null,
  nick varchar(20) not null,
  nivel int check(nivel>0 and nivel<11) not null,
  superado varchar(1) check(superado='S' or superado='N') not null,
  tiempo int,
  primary key(juego, nick, nivel),
  foreign key (juego) references juegos(nombre),
  foreign key (nick) references jugadores(nick)
);

INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Azan',  20, 'Madrid');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Basra', 18, 'Segovia');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Cruc',  23, 'Madrid');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Eos',   60, 'Sevilla');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Luz',   20, 'Oviedo');
INSERT INTO jugadores(nick, edad, ciudad) VALUES ('Zorai', 10, 'Sevilla');

INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Tetris', 'puzzle', 10);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Bubble', 'puzzle', 8);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Candy Crush', 'puzzle', 10);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Mine', 'puzzle', 7);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('The Room', 'puzzle', 5);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Lyne', 'puzzle', 10);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Anomaly', 'estrategia', 2);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Age', 'estrategia', 10);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Empire', 'estrategia', 6);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('Oscura', 'plataformas', 4);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('BadLand', 'plataformas', 4);
INSERT INTO juegos (nombre, tipo, niveles) VALUES ('RayMan', 'plataformas', 10);

INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Bubble', 'Azan', 1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Bubble', 'Basra', 1, 'S', 10);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Mine', 'Azan', 1, 'S', 15);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Mine', 'Basra', 1, 'S', 25);
INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Lyne', 'Cruc', 1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Lyne', 'Eos', 1, 'S', 50);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('RayMan', 'Zorai', 1, 'S', 30);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('RayMan', 'Eos', 1, 'S', 30);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Eos', 1, 'S', 30);
INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Age', 'Azan', 1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Age', 'Basra', 1, 'S', 20);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Eos', 2, 'S', 40);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Eos', 3, 'S', 50);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Eos', 4, 'S', 60);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Azan', 1, 'S', 140);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Azan', 2, 'S', 140);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Azan', 3, 'S', 150);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('BadLand', 'Azan', 4, 'S', 160);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire', 'Azan', 1, 'S', 60);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire', 'Azan', 2, 'S', 60);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire', 'Azan', 3, 'S', 60);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire', 'Azan', 4, 'S', 60);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire', 'Azan', 5, 'S', 60);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Empire', 'Azan', 6, 'S', 60);
INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Tetris', 'Azan', 1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris', 'Basra', 1, 'S', 10);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris', 'Azan', 2, 'S', 15);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris', 'Basra', 2, 'S', 25);
INSERT INTO partidas(juego, nick, nivel, superado)         VALUES ('Tetris', 'Cruc', 1, 'N');
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris', 'Eos', 1, 'S', 50);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris', 'Zorai', 1, 'S', 30);
INSERT INTO partidas(juego, nick, nivel, superado, tiempo) VALUES ('Tetris', 'Eos', 2, 'S', 30);

create view partSup as
select tipo, tiempo
from partidas, juegos
where superado='S' and nivel=1 and partidas.juego=juegos.nombre;

create view noMax as
select p1.tipo, p1.tiempo
from partSup p1, partSup p2
where p1.tiempo < p2.tiempo and p1.tipo = p2.tipo;

create view vista1 as
select tipo, tiempo from partSup
except
select * from noMax;

select *
from vista1;
