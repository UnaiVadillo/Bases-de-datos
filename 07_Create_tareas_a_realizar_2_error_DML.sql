DROP TABLE pedidos CASCADE CONSTRAINTS;
DROP TABLE ventas CASCADE CONSTRAINTS;
DROP TABLE articulos CASCADE CONSTRAINTS;
DROP TABLE tiendas CASCADE CONSTRAINTS;
DROP TABLE fabricantes CASCADE CONSTRAINTS;

--FALTA UNA S EN CONSTRAINT
--CORREGIDO EL ORDEN DE BORRADO

/*
Error que empieza en la línea: 6 del comando :
DROP TABLE tiendas CASCADE CONSTRAINT
Informe de error -
ORA-00942: la tabla o vista no existe
00942. 00000 -  "table or view does not exist"
*Cause:TABLA NO CREADA ANTERIORMENTE    
*Action:CREAR ANTES LA TABLA
*/

CREATE TABLE fabricantes
(
cod_fabricante VARCHAR2(3),
nombre VARCHAR2(15),
pais VARCHAR2(15),
  CONSTRAINT fabr_pk PRIMARY KEY(cod_fabricante),
  CONSTRAINT fabr_nombre_ck CHECK (nombre=UPPER(nombre)),
  CONSTRAINT fabr_pais_ck CHECK (pais=UPPER(pais))
);

INSERT INTO fabricantes
VALUES ('2','FABRICANTE 2','FRANCIA');
INSERT INTO fabricantes
VALUES ('1','FABRICANTE 1','PORTUGAL');

/*Error que empieza en la línea: 28 del comando :
INSERT INTO fabricantes
VALUES ('1','FABRICANTE 1','portugal')
Informe de error -
ORA-02290: restricción de control (DAW11.FABR_PAIS_CK) violada
*Cause:SE VIOLA LA RESTRICCION EN LA QUE NOS INDICA QUE EL PAIS DEBE SER INTRODUCIDO EN MAYUSCULAS  
*Action: portugal ESCRIBIRLO EN MAYUSCULAS
*/

CREATE TABLE articulos
 (
articulo VARCHAR2(20),
cod_fabricante VARCHAR2(3),
peso NUMBER(3),
categoria VARCHAR2(10),
precio_venta NUMBER(4),
precio_costo NUMBER(4),
existencias NUMBER(5),
  CONSTRAINT art_comp_pk PRIMARY KEY(articulo,cod_fabricante,peso,categoria),
  CONSTRAINT art_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
  CONSTRAINT art_precio_venta_ck CHECK(precio_venta>0),
  CONSTRAINT art_precio_costo_ck CHECK(precio_costo>0),
  CONSTRAINT art_peso_ck CHECK(existencias>0),
  CONSTRAINT art_categoria_ck CHECK(categoria IN ('Primera','Segunda','Tercera'))
);

INSERT INTO articulos
VALUES ('ARTICULO1','1',100, 'Primera',222,180,1000);

--INSERT INTO articulos
--VALUES ('ARTICULO2','1',200, 'Primera',522,480,500);
/*
Error que empieza en la línea: 60 del comando :
INSERT INTO articulos
VALUES ('ARTICULO2','1',200, 'PRIMERA',522,480,500)
Informe de error -
ORA-02290: restricción de control (DAW11.ART_CATEGORIA_CK) violada
*Cause:VIOLADA LA RESTRICCION DE LA CATEGORIA DONDE NOS INDICA QUE TIENE SER INTRODUCIDA LA PRIMERA LETRA SOLO CON MAYUSCULA
        MISMO ARTICULO INTRODUCIDO DOS VECES, NO PUEDE TENER LAS MISMAS PRIMARY KEY
*Action: CAMBIAR EL ATRIBUTO PRIMERO POR Primera
        BORRAR LA SENTENCIA
*/
--INSERT INTO articulos
--VALUES ('ARTICULO3','2',100, 'Segunda',322,280,300);

/*Error que empieza en la línea: 63 del comando :
INSERT INTO articulos
VALUES ('ARTICULO3','3',100, 'Segunda',322,280,300)
Informe de error -
ORA-02291: restricción de integridad (DAW11.ART_FAB_FK) violada - clave principal no encontrada
*Cause: EN LA TABLA FABRICANTES NO HAY NINGUNO CON EL COD_FABRICANTE NUMERO 3 POR LO QUE NO PUEDES CREAR UNO CON ESE CODIGO
        MISMO ARTICULO INTRODUCIDO DOS VECES, NO PUEDE TENER LAS MISMAS PRIMARY KEY
*Action: CAMBIAR ESE CODIGO POR OTRO QUE YA ESTE CREADO
        BORRAR LA SENTENCIA
*/
INSERT INTO articulos
VALUES ('ARTICULO2','1',200, 'Primera',522,480,500);

INSERT INTO articulos
VALUES ('ARTICULO3','2',100, 'Segunda',322,280,300);

INSERT INTO articulos
VALUES ('ARTICULO4','2',200, 'Primera',422,380,400);





CREATE TABLE tiendas (
nif VARCHAR2(10),
nombre VARCHAR2(20),
direccion VARCHAR2(20),
poblacion VARCHAR2(20),
provincia VARCHAR2(20),
codpostal VARCHAR2(5),
  CONSTRAINT tien_pk PRIMARY KEY(nif),
  CONSTRAINT tien_provincia_ck CHECK(provincia=UPPER(provincia))
);

INSERT INTO tiendas
VALUES ('A010038I','TIENDA 1', 'SANTIAGO, 25', 'VITORIA','ALAVA','01003');

INSERT INTO tiendas
VALUES ('A020058I','TIENDA 2', 'DIVINO PASTOR, 15', 'MADRID','MADRID','28004');




CREATE TABLE pedidos (
nif VARCHAR2(10),
articulo VARCHAR2(20),
cod_fabricante VARCHAR2(3),
peso NUMBER(3),
categoria VARCHAR2(10),
fecha_pedido DATE,
unidades_pedidas NUMBER(4),
  CONSTRAINT ped_comp_pk PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
  CONSTRAINT ped_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
  CONSTRAINT ped_tien_fk FOREIGN KEY(nif) REFERENCES tiendas(nif),
  CONSTRAINT ped_art_fk FOREIGN KEY(articulo,cod_fabricante,peso,categoria) 
     REFERENCES articulos(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
  CONSTRAINT ven_unidades_pedidas_ck CHECK(unidades_pedidas>0),
  CONSTRAINT ped_categoria_ck CHECK(categoria IN ('Primera','Segunda','Tercera'))
);  

INSERT INTO pedidos
VALUES ('A010038I', 'ARTICULO4','2',200, 'Primera',SYSDATE,100);

--INSERT INTO pedidos
--VALUES ('A010038I', 'ARTICULO4',2,200, 'Tercera',SYSDATE,100);
/*
Error que empieza en la línea: 139 del comando :
INSERT INTO pedidos
VALUES ('A010038I', 'ARTICULO4',2,200, 'Tercera',SYSDATE,100)
Informe de error -
ORA-02291: restricción de integridad (DAW11.PED_ART_FK) violada - clave principal no encontrada
*Cause: NO ESTA CREADA LA CLAVE CATEGORIA CON ESE ARTICULO EN LA TABLA ARTICULOS
*Action: NO SE PUEDE CREAR SI NO LO CREAS ANTES, CREAR ARTICULO O QUITAR EL PEDIDO
*/

--INSERT INTO pedidos
--VALUES ('A010038I', 'ARTICULO4',2,200, 'Primera',SYSDATE,100);
/*
Error que empieza en la línea: 142 del comando :
INSERT INTO pedidos
VALUES ('A010038I', 'ARTICULO4',2,200, 'PRIMERA',SYSDATE,100)
Informe de error -
ORA-02290: restricción de control (DAW11.PED_CATEGORIA_CK) violada
*Cause:VIOLADA LA RESTRICCION DE LA CATEGORIA DONDE NOS INDICA QUE TIENE SER INTRODUCIDA LA PRIMERA LETRA SOLO CON MAYUSCULA
        MISMO ARTICULO INTRODUCIDO DOS VECES, NO PUEDE TENER LAS MISMAS PRIMARY KEY
*Action: CAMBIAR EL ATRIBUTO PRIMERO POR Primera 
        BORRAR ESTA SENTENCIA
*/

CREATE TABLE ventas (
nif VARCHAR2(10),
articulo VARCHAR2(20),
cod_fabricante VARCHAR2(3),
peso NUMBER(3),
categoria VARCHAR2(10),
fecha_venta DATE,
unidades_vendidas NUMBER(4),
  CONSTRAINT ven_comp_pk PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
  CONSTRAINT ven_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
  CONSTRAINT ven_tien_fk FOREIGN KEY(nif) REFERENCES tiendas(nif),
  CONSTRAINT ven_art_fk FOREIGN KEY(articulo,cod_fabricante,peso,categoria) REFERENCES articulos(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
  CONSTRAINT ven_unidades_vendidas_ck CHECK(unidades_vendidas>0),
  CONSTRAINT ven_categoria_ck CHECK(categoria IN ('Primera','Segunda','Tercera'))
);  

INSERT INTO ventas
VALUES ('A010038I', 'ARTICULO4','2',200, 'Primera',TO_DATE('21-ENE-12','DD-MON-YY'),10);

INSERT INTO ventas
VALUES ('A010038I', 'ARTICULO4','2',200, 'Primera',TO_DATE('15/01/2012','DD/MM/YYYY'),10);

INSERT INTO ventas
VALUES ('A010038I', 'ARTICULO3','2',100, 'Segunda',TO_DATE('15-01-2012','DD-MM-YYYY'),10);
/*
Error que empieza en la línea: 187 del comando -
INSERT INTO ventas
VALUES ('A010038I', ''ARTICULO3','3',100, 'Segunda',TO_DATE('15-01-2012','DD-MM-YYYY'),10);
Error en la línea de comandos : 188 Columna : 23
Informe de error -
Error SQL: ORA-00917: falta la coma
00917. 00000 -  "missing comma"
*Cause:DOS COMILLAS MAL INTRODUCIDAS DELANTE DE ''ARTICULO3'
        EL CODIGO INEXISTENTE EN LA TABLA FABRICANTE
        TO_DATE COMANDO DESCONOCIDO AL TENER YA LA FECHA_VENTA EN FORMATO DATE, TO DATE TRANSFORMA UN STRING EN UNA DATE
        
*Action:ELIMINAR UNA DE LAS COMILLAS DELANTERAS
        CAMBIAR EL 3 POR EL 2
        INTRODUCIR UNICAMENTE LA FECHA
*/  
