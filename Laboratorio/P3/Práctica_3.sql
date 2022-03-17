/abolish
/multiline on
/duplicates off

create table programadores(dni string primary key, nombre string, direcci�n string, tel�fono string);
insert into programadores values('1','Jacinto','Jazm�n 4','91-8888888');
insert into programadores values('2','Herminia','Rosa 4','91-7777777');
insert into programadores values('3','Calixto','Clavel 3','91-1231231');
insert into programadores values('4','Teodora','Petunia 3','91-6666666');

create table analistas(dni string primary key, nombre string, direcci�n string, tel�fono string);
insert into analistas values('4','Teodora','Petunia 3','91-6666666');
insert into analistas values('5','Evaristo','Luna 1','91-1111111');
insert into analistas values('6','Luciana','J�piter 2','91-8888888');
insert into analistas values('7','Nicodemo','Plut�n 3',NULL);

create table distribuci�n(c�digoPr string, dniEmp string, horas int, primary key (c�digoPr, dniEmp));
insert into distribuci�n values('P1','1',10);
insert into distribuci�n values('P1','2',40);
insert into distribuci�n values('P1','4',5);
insert into distribuci�n values('P2','4',10);
insert into distribuci�n values('P3','1',10);
insert into distribuci�n values('P3','3',40);
insert into distribuci�n values('P3','4',5);
insert into distribuci�n values('P3','5',30);
insert into distribuci�n values('P4','4',20);
insert into distribuci�n values('P4','5',10);

create table proyectos(c�digo string primary key, descripci�n string, dniDir string);
insert into proyectos values('P1','N�mina','4');
insert into proyectos values('P2','Contabilidad','4');
insert into proyectos values('P3','Producci�n','5');
insert into proyectos values('P4','Clientes','5');
insert into proyectos values('P5','Ventas','6');

/*VISTA1*/
create view vista1 as
select dni from programadores
union
select dni from analistas;

/*VISTA2*/
create view vista2 as
select dni from programadores
intersect
select dni from analistas;

/*VISTA3*/
create view vista3 as
select * from vista1
except
(select dniEmp from distribuci�n
union
select dniDir from proyectos);

/*VISTA4*/
create view vista4 as
(select c�digo
from proyectos)
except
(select c�digoPr
from distribuci�n, analistas
where distribuci�n.dniEmp = analistas.dni);

/*VISTA5*/
create view vista5 as
(select dni from analistas
intersect
select dniDir from proyectos)
except
select dni from programadores;

/*VISTA6*/
create view vista6 as
select descripci�n, nombre, horas
from proyectos, distribuci�n, programadores
where proyectos.c�digo = distribuci�n.c�digoPr and programadores.dni = distribuci�n.dniEmp;

/*VISTA7*/
create view empleados as
select * from programadores
union
select * from analistas;

create view vista7 as
select emp1.tel�fono
from empleados emp1, empleados emp2
where emp1.tel�fono = emp2.tel�fono and emp1.dni != emp2.dni;

/*VISTA8*/
create view vista8 as
select dni
from programadores natural join analistas using (dni);

/*VISTA9*/
create view vista9 as
select dniEmp, sum(horas) as horas
from distribuci�n
group by dniEmp;

/*VISTA10*/
create view vista10(dni,nombre,proyecto) as
select dni, nombre, c�digoPr
from empleados full outer join distribuci�n on dni=dniEmp;

/*VISTA11*/
create view vista11 as
select dni, nombre
from empleados
where tel�fono is null;

/*VISTA12*/
create view emp as
select dniEmp, sum(horas) / count(c�digoPr) as prop1
from distribuci�n
group by dniEmp;

create view proy as
select c�digoPr, sum(horas) / count(dniEmp) as prop2
from distribuci�n
group by c�digoPr;

create view vista12(dni) as
select dniEmp
from emp
where prop1 < (select avg(prop2) from proy);

/*VISTA13*/
create view proyEv as
select c�digoPr
from distribuci�n, empleados 
where nombre='Evaristo' and dni=dniEmp;

create view vista13(dni) as
select dniEmp
from (select c�digoPr, dniEmp from distribuci�n) division proyEv;

/*VISTA14*/
create view empNo as
select proyEv.c�digoPr,dniEmp
from proyEv, distribuci�n
except
select c�digoPr,dniEmp
from distribuci�n;

create view vista14(dni) as
select dniEmp
from distribuci�n
except
select dniEmp 
from empNo;

/*VISTA15*/
create view empSinEv as
select dniEmp
from distribuci�n
except
select dniEmp
from distribuci�n, proyEv
where distribuci�n.c�digoPr = proyEv.c�digoPr;

create view vista15(c�digoPr,dni,horas) as
select c�digoPr, distribuci�n.dniEmp, horas*1.2
from distribuci�n, empSinEv
where distribuci�n.dniEmp = empSinEv.dniEmp;

/*VISTA16*/
create view jefeDir(dir,emp) as
select dniDir, dniEmp
from proyectos,distribuci�n
where c�digo=c�digoPr;

create view vista16(nombre) as

with jefe(dir,emp) as
(
  select * from jefeDir
  union
  select jefeDir.dir,jefe.emp
  from jefeDir,jefe 
  where jefeDir.emp=jefe.dir
)

select nombre
from jefe,empleados 
where emp=dni and nombre<>'Evaristo';

select * from vista1;
select * from vista2;
select * from vista3;
select * from vista4;
select * from vista5;
select * from vista6;
select * from vista7;
select * from vista8;
select * from vista9;
select * from vista10;
select * from vista11;
select * from vista12;
select * from vista13;
select * from vista14;
select * from vista15;
select * from vista16;
