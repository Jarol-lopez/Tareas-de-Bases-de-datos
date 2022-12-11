SET SERVEROUTPUT ON;

--Bloques Anónimos
/*  a. Construir un bloque anonimo donde se declare un cursor y que imprima el 
nombre y sueldo de los empleados (utilice la tabla employees). Si durante el 
recorrido aparece el nombre Peter Tucker (el jefe) se debe genera un 
RAISE_APPLICATION_ERROR indicando que no se puede ver el sueldo del 
jefe*/

DECLARE
CURSOR G1 IS SELECT * FROM employees;
C1 employees%ROWTYPE;
BEGIN
    OPEN G1;
LOOP
FETCH G1 INTO C1;
IF(C1.FIRST_NAME='Peter' AND C1.LAST_NAME='Tucker')THEN
RAISE_APPLICATION_ERROR(-20010, ' EL SUELDO DEL JEF NO SE PUEDE MOSTRARE');
ELSE
DBMS_OUTPUT.put_line(C1.FIRST_NAME||' '||C1.LAST_NAME||' '||C1.SALARY);
END IF;
EXIT WHEN G1%NOTFOUND;
END LOOP;
CLOSE G1;
END;

/*b. Crear un cursor con parámetros para el parametro id de departamento e 
imprima el numero de empleados de ese departamento (utilice la claúsula 
count).*/

DECLARE
CURSOR G1(DEPARTAMENTO NUMERIC) IS SELECT COUNT(department_id) FROM employees WHERE department_id=DEPARTAMENTO;

BEGIN
FOR i IN G1(100) LOOP
DBMS_OUTPUT.put_line(i.department_id);
END LOOP;
END;

/*c. Crear un bloque que tenga un cursor de la tabla employees.
i. Por cada fila recuperada, si el salario es mayor de 8000 
incrementamos el salario un 
ii. Si es menor de 8000 incrementamos en un */

DECLARE
CURSOR G1 IS SELECT * FROM employees;
C1 employees%ROWTYPE;
salarioNuevo NUMERIC;
BEGIN
OPEN G1;
LOOP
FETCH G1 INTO C1;
IF(C1.SALARY>8000)THEN
salarionuevo:=C1.SALARY + C1.SALARY*(0.02);   
ELSE
salarionuevo:=C1.SALARY + C1.SALARY*(0.03);   
 END IF;
 EXIT WHEN G1%NOTFOUND;
DBMS_OUTPUT.put_line('SALARIO ACTUAL: '||C1.SALARY||'  '||'SALARIO NUEVO: '||salarionuevo);
END LOOP;
  CLOSE G1;
END;




 
--Funciones

CREATE OR REPLACE FUNCTION CREAR_REGION
      (V1 IN VARCHAR2)
RETURN NUMBER
IS
ID_REGI NUMBER:=0;
NUEV_ID NUMBER:=0;
BEGIN
   
SELECT MAX(REGION_ID) INTO ID_REGI FROM regions;
NUEV_ID:=ID_REGI+1;
INSERT INTO regions VALUES(NUEV_ID, V1);
RETURN NUEV_ID;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_line(' NO EXISTE LA REGION');
END;


DECLARE
 regionNueva VARCHAR2(60);
  S NUMBER;
begin
regionNueva:='oceania';
 S:=CREAR_REGION(regionNueva);
DBMS_OUTPUT.PUT_LINE('CODIGO DE REGION ASIGNADO='||S);
end;



--Procedimientos
/*a. Construya un procedimiento almacenado que haga las operaciones de una 
calculadora, por lo que debe recibir tres parametros de entrada, uno que 
contenga la operación a realizar (SUMA, RESTA, MULTIPLICACION, 
DIVISION), num1, num2 y declare un parametro de retorno e imprima el 
resultado de la operación. Maneje posibles excepciones*/

CREATE OR REPLACE PROCEDURE CALCULADORA 
(OPERACION IN VARCHAR2,
NU1 IN NUMBER,
NU2 IN NUMBER,
RE OUT NUMBER)
IS
 SAL NUMBER:=0;
BEGIN
IF OPERACION='SUMA' THEN
RE:=NU1+NU2;
ELSE IF OPERACION='RESTA' THEN
RE:=NU1-NU2;
ELSE IF OPERACION='MULTIPLICACION' THEN
RE:=NU1*NU2;
ELSE IF OPERACION='DIVISION' THEN
IF NU2=0 THEN
RAISE_APPLICATION_ERROR(-20010, 'NO SE PUEDE DIVIDIR ENTRE 0');
ELSE
RE:=NU1/NU2;
END IF;
ELSE
RAISE_APPLICATION_ERROR(-20001, 'OPERACION NO IDENTIFICADA');
END IF;
END IF;
        END IF;
    END IF;
END;

DECLARE
  OPERACION VARCHAR2(60);
  N1 NUMBER;
  N2 NUMBER;
  R NUMBER;
  
begin
  OPERACION:='DIVISION';  
  N1:=120;
  N2:=10;
  R:=0;
 CALCULADORA(OPERACION,N1,N2,R);
 DBMS_OUTPUT.PUT_LINE('EL RESULTADO ES '||R);
end;


/*b. Realice una copia de la tabla employee, utilice el siguiente script... */
CREATE TABLE
EMPLOYEES_COPIA
(EMPLOYEE_ID NUMBER (6,0) PRIMARY KEY,
FIRST_NAME VARCHAR2(20 BYTE),
LAST_NAME VARCHAR2(25 BYTE),
EMAIL VARCHAR2(25 BYTE),
PHONE_NUMBER VARCHAR2(20 BYTE),
HIRE_DATE DATE,
JOB_ID VARCHAR2(10 BYTE),
SALARY NUMBER(8,2),
COMMISSION_PCT NUMBER(2,2),
MANAGER_ID NUMBER(6,0),
DEPARTMENT_ID NUMBER(4,0)
);

CREATE OR REPLACE PROCEDURE RELLENAR_TABLA IS
CURSOR G1 IS SELECT * FROM employees;
C1 employees%ROWTYPE;
BEGIN
OPEN G1;
LOOP
FETCH G1 INTO C1;
IF G1.EMPLOYEE_ID=C1.EMPLOYEE_ID 
THEN
RAISE_APPLICATION_ERROR(-20001, 'CODIGO REPETIDO');
ELSE
INSERT INTO employees_copia VALUES(C1.EMPLOYEE_ID,
C1.FIRST_NAME,
 C1.LAST_NAME,
 C1.EMAIL,
 C1.PHONE_NUMBER,
 C1.HIRE_DATE,
 C1.JOB_ID,
 C1.SALARY,
 C1.COMMISSION_PCT,
 C1.MANAGER_ID,
 C1.DEPARTMENT_ID);                                               
 DBMS_OUTPUT.PUT_LINE('CARGA FINALIZADA');
        END IF;
    END LOOP;
    CLOSE G1;
END;

  
begin
  RELLENAR_TABLA;
end;















