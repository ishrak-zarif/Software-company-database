-- This section is for dropping table
-- Drop table section starts here

DROP TABLE DEVELOPER;
DROP TABLE PROJECTS;
DROP TABLE PROJECT_MANAGER;
DROP TABLE CLIENT;
DROP TABLE MYAUDIT;

-- Drop table section ends here


-- Creating table CLIENT where primary key is CLIENT_ID

CREATE TABLE CLIENT(
	CLIENT_ID NUMBER(10) NOT NULL,
	C_NAME VARCHAR(10),
	EMAIL VARCHAR(20) check (regexp_like(EMAIL, '[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]')),
	PASSWORD VARCHAR(10),
	USER_TYPE VARCHAR(10),
	COUNTRY VARCHAR(10)
);


-- Creating table PROJECT_MANAGER where primary key is MANAGER_ID

CREATE TABLE PROJECT_MANAGER(
	MANAGER_ID NUMBER(10) NOT NULL,
	PM_NAME VARCHAR(10),
	AGE NUMBER(10),
	GENDER VARCHAR(10),
	SALARY NUMBER(10)
);


-- Creating table PROJECTS where primary key is PROJECT_ID
-- and CLIENT_ID, MANAGER_ID are foreign key

CREATE TABLE PROJECTS(
	PROJECT_ID NUMBER(10) NOT NULL,
	CLIENT_ID NUMBER(10),
	MANAGER_ID NUMBER(10),
	P_NAME VARCHAR(50),
	PLATFORM VARCHAR(10),
	PROBLEM_STATEMENT VARCHAR(50),
	DESCRIPTION VARCHAR(50),
	LAST_UPDATE DATE,
	COST NUMBER(10)
);


-- Creating table DEVELOPER where primary key is DEVELOPER_ID
-- and PROJECT_ID is foreign key

CREATE TABLE DEVELOPER(
	DEVELOPER_ID NUMBER(10) NOT NULL,
	PROJECT_ID NUMBER(10),
	D_NAME VARCHAR(10),
	AGE NUMBER(10),
	GENDER VARCHAR(10),
	SALARY NUMBER(10),
	EXPERIENCE_LEVEL VARCHAR(10),
	PLATFORM VARCHAR(50)
);


-- This section creates primary keys
-- primary key section starts here

ALTER TABLE CLIENT add constraint pkcl primary key(CLIENT_ID);
ALTER TABLE PROJECT_MANAGER add constraint pkpm primary key(MANAGER_ID);
ALTER TABLE PROJECTS add constraint pkpr primary key(PROJECT_ID);
ALTER TABLE DEVELOPER add constraint pkdv primary key(DEVELOPER_ID);

-- primary key section ends here


-- This section creates foreign keys
-- foreign key section starts here

ALTER TABLE PROJECTS add constraint fkpr1 foreign key(CLIENT_ID) references CLIENT(CLIENT_ID) on delete cascade;
ALTER TABLE PROJECTS add constraint fkpr2 foreign key(MANAGER_ID) references PROJECT_MANAGER(MANAGER_ID) on delete cascade;
ALTER TABLE DEVELOPER add constraint fkdv foreign key(PROJECT_ID) references PROJECTS(PROJECT_ID) on delete cascade;

--foreign key section ends here


-- This section is for selecting all tables from tab

SELECT * FROM tab;


-- This section is for describing table
-- Describe table section starts here

DESCRIBE CLIENT;
DESCRIBE PROJECT_MANAGER;
DESCRIBE PROJECTS;
DESCRIBE DEVELOPER;

-- Describe table section ends here


-- Some sample value inserted in this section
-- sample value insertion section starts here

-- Sample value inserted into CLIENT table

INSERT INTO CLIENT VALUES(11, 'ABC', 'ABC@gmail.com', 'ABC123', 'PERMANENT', 'BANGLADESH');
INSERT INTO CLIENT VALUES(12, 'DEF', 'DEF@gmail.com', 'DEF123', 'TEMPORARY', 'USA');
INSERT INTO CLIENT VALUES(13, 'GHI', 'GHI@gmail.com', 'GHI123', 'PERMANENT', 'UK');


-- Sample value inserted into PROJECT_MANAGER table

INSERT INTO PROJECT_MANAGER VALUES(21, 'JKL', 29, 'MALE', 50000);
INSERT INTO PROJECT_MANAGER VALUES(22, 'MNO', 34, 'FEMALE', 60000);


-- Sample value inserted into PROJECTS table

INSERT INTO PROJECTS VALUES(31, 11, 21, 'Simple-DATABASE', 'SQL', 'General shop database', 'General super shop database', '19-JUN-2016', 80000);
INSERT INTO PROJECTS VALUES(32, 12, 22, 'Desktop-App', 'JAVA', 'Remainder app', 'Remainder app for desktop', '19-JUN-2016', 90000);
INSERT INTO PROJECTS VALUES(33, 13, 22, 'Windows-OS-app', 'C#', 'Music player', 'Music player for windows pc', '19-JUN-2016', 100000);
INSERT INTO PROJECTS VALUES(34, 11, 21, 'Simple-Website', 'ASP.NET', 'Website for a shop', 'Website for a super shop', '19-JUN-2016', 150000);
INSERT INTO PROJECTS VALUES(35, 12, 21, 'Website', 'PHP', 'Website for a bank', 'A full website for a bank', '19-JUN-2016', 200000);


-- Sample value inserted into DEVELOPER table

INSERT INTO DEVELOPER VALUES(41, 31, 'A', 20, 'MALE', 40000, '1-year', 'JAVA, SQL');
INSERT INTO DEVELOPER VALUES(42, 32, 'B', 28, 'FEMALE', 50000, '2-year', 'C++, JAVA');
INSERT INTO DEVELOPER VALUES(43, 33, 'C', 19, 'MALE', 60000, '3-year', 'C++, JAVA, C#');
INSERT INTO DEVELOPER VALUES(44, 34, 'D', 23, 'MALE', 70000, '4-year', 'C++, Python, JAVA, ASP.NET');
INSERT INTO DEVELOPER VALUES(45, 35, 'E', 30, 'FEMALE', 80000, '5-year', 'C++, Python, C#, PHP, JAVA');

-- sample value insert section ends here


-- This section is for selecting all values from tables
-- Select from table section starts here

SELECT * FROM CLIENT;
SELECT * FROM PROJECT_MANAGER;
SELECT * FROM PROJECTS;
SELECT * FROM DEVELOPER;

-- Select from table section ends here


-- Some general select operation

SELECT DEVELOPER_ID, D_NAME FROM DEVELOPER WHERE SALARY BETWEEN 50000 AND 70000;
SELECT DEVELOPER_ID, D_NAME FROM DEVELOPER WHERE PLATFORM LIKE '%C++%';
SELECT DEVELOPER_ID, D_NAME, EXPERIENCE_LEVEL FROM DEVELOPER ORDER BY SALARY;
SELECT DEVELOPER_ID, D_NAME, EXPERIENCE_LEVEL FROM DEVELOPER ORDER BY SALARY desc;
SELECT CLIENT_ID, C_NAME FROM CLIENT WHERE C_NAME IN ('ABC', 'DEF');
SELECT CLIENT_ID, C_NAME FROM CLIENT WHERE C_NAME IN (SELECT C_NAME FROM CLIENT WHERE USER_TYPE='PERMANENT');


-- Some general select operation with allising
-- Set operation section starts here

SELECT p.PROJECT_ID, p.P_NAME FROM PROJECTS p UNION ALL SELECT c.CLIENT_ID, c.C_NAME FROM CLIENT c WHERE c.CLIENT_ID in (SELECT MANAGER_ID from PROJECT_MANAGER where SALARY>=50000);
SELECT p.PROJECT_ID, p.P_NAME FROM PROJECTS p UNION SELECT c.CLIENT_ID, c.C_NAME FROM CLIENT c WHERE c.CLIENT_ID in (SELECT MANAGER_ID from PROJECT_MANAGER where SALARY>=50000);
SELECT p.PROJECT_ID, p.P_NAME FROM PROJECTS p INTERSECT SELECT c.CLIENT_ID, c.C_NAME FROM CLIENT c WHERE c.CLIENT_ID in (SELECT MANAGER_ID from PROJECT_MANAGER where SALARY>=50000);
SELECT p.PROJECT_ID, p.P_NAME FROM PROJECTS p MINUS SELECT c.CLIENT_ID, c.C_NAME FROM CLIENT c WHERE c.CLIENT_ID in (SELECT MANAGER_ID from PROJECT_MANAGER where SALARY>=50000);

-- Set operation section ends here


-- Example of Join operations applied to the project
-- Join operation section starts here

-- Normal join operation

SELECT p.P_NAME, pm.PM_NAME from PROJECTS p join PROJECT_MANAGER pm on p.MANAGER_ID=pm.MANAGER_ID;


-- Normal join operation with using clause

SELECT p.P_NAME, pm.PM_NAME from PROJECTS p join PROJECT_MANAGER pm using (MANAGER_ID);


-- Natural join operation

SELECT PROJECT_ID, PM_NAME from PROJECTS natural join PROJECT_MANAGER;


-- Cross join operation

SELECT p.P_NAME, d.D_NAME from PROJECTS p cross JOIN DEVELOPER d where p.PROJECT_ID = d.PROJECT_ID;


-- Inner join operation

SELECT p.P_NAME, d.D_NAME from PROJECTS p INNER JOIN DEVELOPER d ON p.PROJECT_ID = d.PROJECT_ID;


-- Left outer join operation

SELECT p.P_NAME, d.D_NAME from PROJECTS p LEFT OUTER JOIN DEVELOPER d ON p.PROJECT_ID = d.PROJECT_ID;


-- Right outer join operation

SELECT p.P_NAME, d.D_NAME from PROJECTS p RIGHT OUTER JOIN DEVELOPER d ON p.PROJECT_ID = d.PROJECT_ID;


-- Full outer join operation

SELECT p.P_NAME, d.D_NAME from PROJECTS p FULL OUTER JOIN DEVELOPER d ON p.PROJECT_ID = d.PROJECT_ID;


-- Join operation section ends here


-- Example of Aggregate functions applied to the project
-- Aggregate functions section starts here

SELECT COUNT(CLIENT_ID) from CLIENT;
SELECT SUM(SALARY) as Developer_Salary from DEVELOPER;
SELECT AVG(SALARY) from PROJECT_MANAGER;
SELECT MAX(AGE) from DEVELOPER;
SELECT MIN(AGE) from DEVELOPER;

-- Aggregate functions section ends here


-- Example of plsql on project
-- One Thing to remeber use proper indentation in plsql else you may see errors
-- The plsql section starts here

-- Example of simple output by using DBMS_OUTPUT

set serveroutput on;
declare   
	client_no CLIENT.CLIENT_ID%type;
begin
	SELECT count(CLIENT_ID) INTO client_no FROM CLIENT;
	DBMS_OUTPUT.PUT_LINE('The number of client is : ' || client_no);
end;
/
show errors;


-- Example of simple loop operation

set serveroutput on
declare
	cursor PROJECTS_cur is select P_NAME, LAST_UPDATE from PROJECTS;
	PROJECTS_record PROJECTS_cur%ROWTYPE;
begin
	OPEN PROJECTS_cur;
	LOOP
		FETCH PROJECTS_cur INTO PROJECTS_record;
		EXIT WHEN PROJECTS_cur%ROWCOUNT > 4;
		DBMS_OUTPUT.PUT_LINE('Project Name : ' || PROJECTS_record.P_NAME || ' & ' || 'Last Update : ' || PROJECTS_record.LAST_UPDATE);
	END LOOP;
	CLOSE PROJECTS_cur;
end;
/	
show errors;


-- Example of Trigger in PL/SQL used in project
-- The reference for trigger: http://www.rebellionrider.com/pl-sql-tutorials/triggers-in-oracle-database/table-auditing-using-dml-triggers-in-oracle-database.htm#.V4iqCrh97IU
-- Table Auditing using DML TRIGGER
-- Creation of audit table

CREATE TABLE MYAUDIT(
	new_name varchar2(30),
	old_name varchar2(30),
	user_name varchar2(30),
	entry_date varchar2(30),
	operation varchar2(30)
);


-- Trigger for CLIENT table

set serveroutput on
CREATE OR REPLACE TRIGGER ClientAudit
BEFORE INSERT OR DELETE OR UPDATE ON CLIENT
FOR EACH ROW  

BEGIN

  IF INSERTING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(:NEW.C_NAME, Null, 'user', TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Insert');
  ELSIF DELETING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(NULL, :OLD.C_NAME, 'user', TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Delete');
  ELSIF UPDATING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(:NEW.C_NAME, :OLD.C_NAME, 'user', TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Update');
  END IF;
END;
/


-- Trigger for PROJECT_MANAGER table

set serveroutput on
CREATE OR REPLACE TRIGGER ProjectManagerAudit
BEFORE INSERT OR DELETE OR UPDATE ON PROJECT_MANAGER
FOR EACH ROW  

BEGIN 
  IF INSERTING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(:NEW.PM_NAME, Null, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Insert');
  ELSIF DELETING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(NULL, :OLD.PM_NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') , 'Delete');
  ELSIF UPDATING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(:NEW.PM_NAME, :OLD.PM_NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'),'Update');
  END IF;
END;
/


-- Trigger for PROJECTS table

set serveroutput on
CREATE OR REPLACE TRIGGER ProjectsAudit
BEFORE INSERT OR DELETE OR UPDATE ON PROJECTS
FOR EACH ROW  

BEGIN 
  IF INSERTING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(:NEW.P_NAME, Null ,user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Insert');
  ELSIF DELETING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(NULL, :OLD.P_NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') , 'Delete');
  ELSIF UPDATING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(:NEW.P_NAME, :OLD.P_NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'),'Update');
  END IF;
END;
/


-- Trigger for DEVELOPER table

set serveroutput on
CREATE OR REPLACE TRIGGER DeveloperAudit
BEFORE INSERT OR DELETE OR UPDATE ON DEVELOPER
FOR EACH ROW  

BEGIN 
  IF INSERTING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(:NEW.D_NAME, Null ,user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'), 'Insert');
  ELSIF DELETING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(NULL, :OLD.D_NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') , 'Delete');
  ELSIF UPDATING THEN
  INSERT INTO MYAUDIT (new_name, old_name, user_name, entry_date, operation) VALUES(:NEW.D_NAME, :OLD.D_NAME, user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS'),'Update');
  END IF;
END;
/


-- Example for MYAUDIT table starts


select * from MYAUDIT;

INSERT INTO CLIENT VALUES(14, 'JKL', 'JKL@gmail.com', 'JKL123', 'TEMPORARY', 'AUSTRALIA');

SELECT * FROM CLIENT;
select * from MYAUDIT;

UPDATE CLIENT SET C_NAME='MNO' WHERE CLIENT_ID=14;

SELECT * FROM CLIENT;
select * from MYAUDIT;

DELETE FROM CLIENT WHERE CLIENT_ID=14;

SELECT * FROM CLIENT;
select * from MYAUDIT;

-- Example for MYAUDIT table ends


-- Example of PL/SQL PROCEDURES

set serveroutput on
CREATE OR REPLACE PROCEDURE ClientInfo IS

cl_name CLIENT.C_NAME%TYPE;
cl_id CLIENT.CLIENT_ID%TYPE;

begin
	cl_id := 11;
	select C_NAME into cl_name from CLIENT where CLIENT_ID = cl_id;

	DBMS_OUTPUT.PUT_LINE('The client name is ' || cl_name );
end;
/
show errors;

BEGIN
	ClientInfo;
END;
/


-- Example of PL/SQL PROCEDURES with parameter

set serveroutput on
CREATE OR REPLACE PROCEDURE add_client (
  cid CLIENT.CLIENT_ID%TYPE,
  cname CLIENT.C_NAME%TYPE,
  cemail CLIENT.EMAIL%TYPE,
  cpass CLIENT.PASSWORD%TYPE,
  ctype CLIENT.USER_TYPE%TYPE,
  ccountry CLIENT.COUNTRY%TYPE ) IS
BEGIN
  INSERT INTO CLIENT(CLIENT_ID, C_NAME, EMAIL, PASSWORD, USER_TYPE, COUNTRY) VALUES(cid, cname, cemail, cpass, ctype, ccountry);
  COMMIT;
END add_client;
/
SHOW ERRORS

BEGIN
   add_client(15, 'OPQ', 'OPQ@gmail.com', 'OPQ123', 'PERMANENT', 'AUSTRALIA');
END;
/

SELECT * FROM CLIENT;
select * from MYAUDIT;


-- Example of PL/SQL FUNCTION

CREATE OR REPLACE FUNCTION max_salary RETURN NUMBER IS
   max_sal DEVELOPER.SALARY%TYPE;
BEGIN
  SELECT MAX(SALARY) INTO max_sal FROM DEVELOPER;
  RETURN max_sal;
END;
/

SET SERVEROUTPUT ON
BEGIN
dbms_output.put_line('DEVELOPERS Max Salary: ' || max_salary);
END;
/


-- The plsql section ends here