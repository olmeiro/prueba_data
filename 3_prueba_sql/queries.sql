--Punto 1
select nombre, apellido, salario from empleado;

--Punto 2
select nombre, apellido, salario from empleado where salario > 4000000;

--Punto 3
SELECT SEXO, COUNT(*) AS CANTIDAD_EMPLEADOS
FROM EMPLEADO
GROUP BY SEXO;

--Punto 4
SELECT E.ID, E.NOMBRE, E.APELLIDO
FROM EMPLEADO E
LEFT JOIN VACACIONES V ON E.ID = V.ID_EMP
WHERE V.ID IS NULL;

--Punto 5
SELECT E.ID, E.NOMBRE, E.APELLIDO, COUNT(V.ID) AS CANTIDAD_SOLICITUDES
FROM EMPLEADO E
JOIN VACACIONES V ON E.ID = V.ID_EMP
GROUP BY E.ID, E.NOMBRE, E.APELLIDO
HAVING COUNT(V.ID) > 1;

-- Punto 6
SELECT AVG(SALARIO) FROM EMPLEADO;

--Punto 7
SELECT E.ID, E.NOMBRE,
AVG(V.CANTIDAD_DIAS) AS DIAS_PROMEDIO_VACACIONES
FROM EMPLEADO E
JOIN VACACIONES V ON E.ID = V.ID_EMP
GROUP BY E.ID, E.NOMBRE;

--Punto 8
SELECT E.NOMBRE, E.APELLIDO,
SUM(V.CANTIDAD_DIAS) AS TOTAL_DIAS_VACACIONES
FROM EMPLEADO E
JOIN VACACIONES V ON E.ID = V.ID_EMP
GROUP BY E.ID, E.NOMBRE, E.APELLIDO
ORDER BY TOTAL_DIAS_VACACIONES DESC LIMIT 1;

--Punto 9
SELECT
    E.ID,
    E.NOMBRE,
    COALESCE(SUM(CASE WHEN V.ESTADO = 'A' THEN V.CANTIDAD_DIAS ELSE 0 END), 0) AS DIAS_APROBADOS,
    COALESCE(SUM(CASE WHEN V.ESTADO = 'R' THEN V.CANTIDAD_DIAS ELSE 0 END), 0) AS DIAS_RECHAZADOS
FROM
    EMPLEADO E
LEFT JOIN
    VACACIONES V ON E.ID = V.ID_EMP
GROUP BY
    E.ID, E.NOMBRE;
