/*
 *  SUBQUERY
 * 
 * 환자 평균키보더 더큰 키의 환자이름 조회
 */

SELECT AVG(HEIGHT_CM) FROM PATIENT;

SELECT
			PATIENT_NAME
			,HEIGHT_CM
FROM
			PATIENT
WHERE
			HEIGHT_CM >(SELECT AVG(HEIGHT_CM) FROM PATIENT);

--------------------------------------------------------

SELECT	
			WARD_NAME
FROM 
			WARD
JOIN
		PATIENT USING(WARD_ID)
WHERE PATIENT_NAME = '배준혁';

SELECT
			PATIENT_NAME
			,WARD_NAME
FROM 
			PATIENT
JOIN
		WARD USING(WARD_ID)
WHERE
			WARD_NAME =
(SELECT	
			WARD_NAME
FROM 
			WARD
JOIN
		PATIENT USING(WARD_ID)
WHERE PATIENT_NAME = '배준혁');

-------------------------------------------

SELECT DOCTOR_ID FROM DOCTOR WHERE DOCTOR_NAME = '허준';

SELECT
			PATIENT_NAME
FROM
			PATIENT
WHERE 
			DOCTOR_ID = 
(SELECT
			DOCTOR_ID
FROM
			DOCTOR
WHERE
			DOCTOR_NAME = '허준');
------------------------------------- 아래식이 더 좋다
SELECT PATIENT_NAME
FROM PATIENT
JOIN DOCTOR USING(DOCTOR_ID) WHERE DOCTOR_NAME = '허준';

------------------------ 단일행 서브쿼리------------------------
SELECT 
			PATIENT_NAME
FROM 
			PATIENT
WHERE 
			DEPT_ID = 
(SELECT DEPT_ID
FROM DEPT
WHERE DEPT_TYPE = '외과계'); 

--다중행 서브쿼리

SELECT
			PATIENT_NAME
FROM
			PATIENT
WHERE
			DEPT_ID IN (SELECT DEPT_ID FROM DEPT WHERE DEPT_TYPE = '외과계');

/*
ANY : 서브쿼리 결과 중 하나라도 크면
ALL  : 서브쿼리 결과 중 모두보다 크면 



--다중열 서브쿼리

*/
------------------------------------------------------------
SELECT MAX (HEIGHT_CM) FROM PATIENT GROUP BY DEPT_ID;

SELECT
			PATIENT_NAME, HEIGHT_CM
FROM 
			PATIENT
WHERE 
			(DEPT_ID ,HEIGHT_CM) IN (SELECT DEPT_ID,  MAX(HEIGHT_CM) FROM PATIENT GROUP BY DEPT_ID);
-------------------------------------------------------------

SELECT
			PATIENT_NAME
			,WEIGHT_KG
			,ROWNUM
FROM 
			PATIENT
WHERE
			ROWNUM <= 5
ORDER BY
			WEIGHT_KG DESC;
---인라인뷰

SELECT
			PATIENT_NAME
			,WEIGHT_KG
			,ROWNUM RNUM
FROM 
			(SELECT
							PATIENT_NAME
							,WEIGHT_KG
			 FROM
							PATIENT
			ORDER BY WEIGHT_KG DESC))
---------------------------------------------------
--스칼라 서브쿼리	-> 편의성

SELECT 
			PATIENT_NAME
			,(SELECT DOCTOR_NAME FROM DOCTOR WHERE DOCTOR_ID = p.DOCTOR_ID)
			,(SELECT WARD_NAME FROM WARD WHERE WARD_ID = p.WARD_ID)
			,(SELECT DEPT_NAME FROM WARD WHERE DEPT_ID =p.DEPT_ID )
FROM 
			PATIENT p;
			
			
			
			
