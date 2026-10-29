SELECT
			COUNT(*) "전체 환자 수"
FROM 
			PATIENT;
-------------------------------------COUNT <-- 제일 많이쓰임 , 행수
SELECT 
			COUNT(DISCHARGE_DATE) "퇴원한 환자의 수"
			,COUNT(DOCTOR_ID) AS "배정된 환자의 수"
			,COUNT(*) - COUNT(DISCHARGE_DATE) "입원중인 환자의 수"
FROM 
			PATIENT;

-----------------------------------------

SELECT 
			MAX(WEIGHT_KG) -- 많은 무게
			,MIN(WEIGHT_KG)  --작은 무게
			,TO_CHAR(MAX(BIRTH_DATE), 'YYYY-MM-DD') -- 어린환자
			,MIN(PATIENT_NAME) --
			,SUM(WEIGHT_KG) -- 컬럼 합계
			,AVG(HEIGHT_CM) -- 컬럼 평균
FROM 
			PATIENT;
-------------------------------------------
SELECT 
			TRIM(WEIGHT_KG)
FROM 
			PATIENT;

------------------------------------------

SELECT * FROM PATIENT;

SELECT 
			COUNT(*)
FROM 
			PATIENT
WHERE 
			DEPT_ID = 'D4';
----------------------------------------

SELECT 
			DEPT_ID
			,COUNT(*)
FROM 
			PATIENT
GROUP BY DEPT_ID
ORDER BY DEPT_ID;

----------------------------------------

SELECT 
			GENDER
			,COUNT(*)
FROM 
			PATIENT
GROUP BY 
				GENDER;

SELECT 
			WARD_ID
			,COUNT(*)
FROM 
			PATIENT
GROUP BY
			WARD_ID;
--------------------------------------------------
SELECT 
			WARD_ID
			,GENDER
			,COUNT(*)
FROM 
			PATIENT 
GROUP BY
			WARD_ID
			,GENDER;
						
SELECT EXTRACT( MONTH FROM SYSDATE) 
			--  EXTRACT(YEAR FROM SYSDATE) 
			 -- EXTRACT(DAY FROM SYSFDATE) 
FROM DUAL;




-------
SELECT
			TO_CHAR(ADMISSION_DATE, 'YYYY-MM') AS 입원월
			,COUNT(*)
FROM 
			PATIENT
WHERE
			EXTRACT(MONTH FROM ADMISSION_DATE) = 8
GROUP BY
			TO_CHAR(ADMISSION_DATE, 'YYYY-MM')
ORDER BY
			COUNT(*);

--------------------------------------------------------------------HAVING

SELECT
			BLOOD_TYPE
			,COUNT(*)
FROM 
			PATIENT
GROUP BY
			BLOOD_TYPE
HAVING 
			COUNT(*) >= 10;  -- 그룹함수에 대한 조건을 사용할때


--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

	------------------------------------
SELECT	
	  		DEPT_ID
	  		,COUNT(*)
FROM
			PATIENT
GROUP BY
ROLLUP(DEPT_ID); -- 마지막 행에 NULL은 전체합계