--EJERCICIO 1
SELECT APELLIDO AS "EMPLEADO", NVL(TO_CHAR(ID_JEFE), 'NO TIENE JEFE') AS "JEFE"
FROM EMPLE
ORDER BY ID_JEFE DESC;

--EJERCICIO 2
SELECT APELLIDO || ' ' || EMP_NO as "EMPLEADO", SALARIO, ROUND(SALARIO/1000)|| '%' AS "PORCENTAJE DE MOVILIZACION"
FROM EMPLE

--EJERCICIO 3
SELECT APELLIDO, OFICIO, INITCAP(SUBSTR(APELLIDO,0,3)) || LENGTH(APELLIDO) || LOWER(OFICIO) AS "NOMBRE DE USUARIO",
        EXTRACT(MONTH FROM FECHA_ALTA) || SUBSTR(EXTRACT(YEAR FROM FECHA_ALTA),2,2) || REVERSE(SUBSTR(REVERSE(APELLIDO),0,2)) AS "CLAVE"
FROM EMPLE
ORDER BY APELLIDO;

--EJERCICIO 4
SELECT APELLIDO, SALARIO AS "SALARIO ACTUAL", SUBSTR(SALARIO,0,1) || '%' AS "PORCENTAJE DE REAJUSTE"
FROM EMPLE

--EJERCICIO 5
SELECT EMP_NO AS "ID_EMP", SALARIO, NVL(TO_CHAR(COMISION_PCT), 'NO TIENE COMISION') AS "PORCENTAJE COMISION", NVL((COMISION_PCT*SALARIO)/100,0) ||'%' AS "COMISION", NVL(SALARIO+(COMISION_PCT*SALARIO)/100,SALARIO) AS "SALARIO TOTAL CALCULADO"
FROM EMPLE

