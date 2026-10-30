SELECT 
			PATIENT_NAME
			,DEPT_ID
			,WARD_ID
			,DOCTOR_ID
FROM 
			PATIENT;
---- JOIN 을 사용하여 2개 이상의 테이블 합체 .으로 JOIN, 오라클 전용 구문이다
SELECT
			PATIENT_NAME
			,DEPT_NAME
FROM 
			PATIENT
			,DEPT
WHERE 
			PATIENT.DEPT_ID = DEPT.DEPT_ID;

-------------ANSI 구문 

SELECT 
			PATIENT_NAME
			,DEPT_NAME
FROM 
			PATIENT
JOIN
			DEPT ON (PATIENT.DEPT_ID = DEPT.DEPT_ID);

--------------------------------------ANSI 간략히
SELECT 
			PATIENT_NAME
			,DEPT_NAME
FROM 
			PATIENT
JOIN
			DEPT USING(DEPT_ID);
-----------------------------------------
--같은 칼럼의 이름을 찾아 알아서 조인
SELECT
			PATIENT_NAME
			,DEPT_NAME
FROM 
			PATIENT
NATURAL JOIN DEPT;

-----------------------------------------------------

SELECT
			PATIENT_NAME
			,WARD_NAME		
FROM 
			PATIENT p
JOIN
			WARD W ON( p.WARD_ID = W.WARD_ID);

SELECT 
			PATIENT_NAME
			,DEPT_NAME
			,WARD_NAME
FROM 
			PATIENT p
JOIN
		DEPT d USING (DEPT_ID)
JOIN 
		WARD w USING (WARD_ID);
----------------------------------------------

SELECT
			PATIENT_NAME
			,DOCTOR_NAME
FROM
			PATIENT p
			,DOCTOR d
WHERE 
			p.DOCTOR_ID = D.DOCTOR_ID;

-------

SELECT
			PATIENT_NAME
			,DEPT_NAME
FROM 
			PATIENT p
			,DEPT d
WHERE
			p.DEPT_ID = d.DEPT_ID
AND
			DEPT_TYPE = '외과계';
-----내부조인(INNER JOIN), 동등조인(EQUAL JOIN)
--외부조인(OUTER JOIN)
--------------------------------------

/*LEFT OUTER JOIN
 * RIGHT OUTER JOIN
 * FULL OUTER JOIN
 * 
 */
	-- 환자와 담당의 이름을 출력		

SELECT
			PATIENT_NAME
			,DOCTOR_NAME
FROM
			PATIENT
LEFT
JOIN
		DOCTOR USING(DOCTOR_ID);

SELECT 
			PATIENT_NAME
			,DOCTOR_NAME
FROM		
		    PATIENT RIGHT JOIN	DOCTOR USING(DOCTOR_ID)
ORDER BY 
			DOCTOR_ID;


SELECT 
			NVL(PATIENT_NAME, '환자 미배정') AS "환자명"
			,NVL(DOCTOR_NAME, '담당의 미배정') AS "담당의"
FROM 
			PATIENT
FULL  JOIN DOCTOR USING(DOCTOR_ID)
ORDER BY
				PATIENT_NAME ASC; 
-------------------------------------------------

SELECT
			DOCTOR_NAME
			,DEPT_NAME
FROM 
			DOCTOR
LEFT
JOIN
			DEPT USING(DEPT_ID);

SELECT 
			DEPT_ID
			,DEPT_NAME
			,COUNT(*)
FROM 
			PATIENT
JOIN
		DEPT USING(DEPT_ID)
GROUP BY 
					DEPT_NAME;
--------------------------------
SELECT 
			DOCTOR_NAME
FROM 
			DOCTOR
JOIN
		POSITION USING(POSITION_ID)
WHERE
		POSITION_NAME = '과장';
---------------------------------------
SELECT COUNT(*)
FROM PATIENT
CROSS
JOIN DEPT;