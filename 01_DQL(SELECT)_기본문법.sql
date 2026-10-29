/* 여러줄 주석임
 * 
 * 
 * 
 * SQL 학습시작
 * 
		명령어 -> SELECT -> 항상 필요한 컬럼만 조회하기
 * 
 * 키워드는 왼쪽, 컬럼명은 오른쪽으로 작성
 * 
 8[조회할때 사용]
SELECT * FROM PATIENT; -- 실무에 사용불가,
 사용할 땐 조회하고 싶은 컬럼 하나하나 나열
 
 [SELECT 의 산술연산]
 SELECT
 			PATIENT_NAME
 FROM
 			PATIENT;
 
 날짜끼리도 가능, 산술연산 과정중 NULL값이 존재할 경우 결과도 NULL
 
 
 
 
*/



SELECT
			PATIENT_ID
			,PATIENT_NAME
			,DEPT_ID
			,WARD_ID
			,DOCTOR_ID
FROM
			PATIENT;


SELECT
			 DEPT_ID
			,DEPT_NAME
FROM
			DEPT;


SELECT
			WARD_NAME
FROM
			WARD;


SELECT
		 	 DOCTOR_NAME
			,HIRE_DATE
FROM
			DOCTOR;


SELECT
			 PATIENT_NAME
			,GENDER
FROM
			PATIENT;


SELECT
			 BIRTH_DATE
			,PATIENT_NAME
FROM
			PATIENT;
------------------------------ 이상 SELECT *  FROM 임---------------------------
SELECT
			PATIENT_NAME
			,HEIGHT_CM
			,HEIGHT_CM / 100
FROM
			PATIENT;
-----------------------------

SELECT
			PATIENT_NAME
			,WEIGHT_KG
			,WEIGHT_KG / ((HEIGHT_CM / 100) * HEIGHT_CM / 100))
FROM
			PATIENT;
-------------------------------------------- 오늘 입원일 조회


SELECT
			PATIENT_NAME
			,ADMISSION_DATE 
			,SYSDATE - ADMISSION_DATE 
FROM
			PATIENT;

-------------------------------------------------
/*
 *  컬럼명이 복잡할땐 별칭을 부여한다!
 * 
 *  컬럼명 AS "별칭"
 * CM을 붙여서 보고싶을땐 '  ' 
 * 
 * 
 * 
 * 
 * 
 * ResultSet : SELECT문을 통해 조회된 결과물
 */

SELECT
			HEIGHT_CM AS "키(CM)"
			, 'CM'	
FROM
			PATIENT;
--------------------------------------------------- 


---중복된 종류를 추려줌? DISTINCT, 행단위라 1번만 사용가능
SELECT 
			DISTINCT BLOOD_TYPE
FROM 
			PATIENT;

--------------------------------------------------- 
/*
 * WHERE
 * 조건제시 -> 조건 만족시 행 조회
 * 
 * 
 * 비교연산자 는 
 * 동등비교 ->   = , != 
 * 대소비교 ->  <, >, <= ,  >= , <>
 * 
 */

SELECT 
			PATIENT_NAME
			,WEIGHT_KG
FROM 
			PATIENT
WHERE 
			WEIGHT_KG >= 80;


SELECT --1
			PATIENT_NAME
			,GENDER
FROM --2
			PATIENT
WHERE --3
			--GENDER != 'M'; 합리적인 순서
			GENDER <> 'F';
-----------------------------------------

/*
 * 논리 연산자
 * AND  /  OR
 * 
 * W3(중환자실) 이면서 키가 160CM 이상인 환자들 이름, 코드 ,키 조회
 * 
 * 
 */
SELECT
			PATIENT_NAME
			,WARD_ID
			,HEIGHT_CM
FROM
			PATIENT
WHERE 
			WARD_ID = 'W3'
--AND 
OR
			HEIGHT_CM  >= 170;
---------------------------------------


SELECT 
			PATIENT_NAME
			,HEIGHT_CM
FROM 
			PATIENT
WHERE
			HEIGHT_CM >= 160
AND
			HEIGHT_CM <= 170;
-------------------------------------
SELECT 
			PATIENT_NAME
			,HEIGHT_CM
FROM 
			PATIENT
WHERE
		--	HEIGHT_CM BETWEEN 160 AND 170;
-		HEIGHT_CM NOT BETWEEN 160 AND 170; 
-- 위, 아래식 같은 뜻이나 BETWEEN AND 사용을 권장함
---------------------------------------------------

SELECT 
			PATIENT_NAME
			,BIRTH_DATE
FROM 
			PATIENT
WHERE
			BIRTH_DATE 
BETWEEN TO_DATE('1990-01-01', 'YYYY-MM-DD')  -- TO DATE YYYY-MM-DD 로 날짜명시
         AND TO_DATE('1999-12-31', 'YYYY-MM-DD');
----------------------------------------------------------
	
/*
 * 
 * [LIKE]
 * '%' , '_'
 * 'ㅁ%',  '%ㅁ'   ㅁ으로 시작 또는 ㅁ으로 끝나는 글자 조회
 * '%ㅁ%'  -> ㅁ이 포함되는 모든글자
 * 
 * '_' -> 1글자
 * LIKE '_' -> 2글자
 */

SELECT
			PATIENT_NAME
			,DIAGNOSIS
FROM 
			PATIENT
WHERE
			DIAGNOSIS LIKE '%골절';
-------------------------------------------------

SELECT 
			PATIENT_NAME
			,DIAGNOSIS 
FROM 
			PATIENT
WHERE 
			DIAGNOSIS LIKE '%급성%';

-------------------------------

SELECT 
			DOCTOR_NAME
FROM 
			DOCTOR
WHERE 
			DOCTOR_NAME LIKE '__';
------------------------------------------------

/*
 *  < IS NULL >
 *  = 연산자로 비교 불가능
 */
SELECT 
			PATIENT_NAME
			,DISCHARGE_DATE
FROM 
			PATIENT
WHERE 
		--	DISCHARGE_DATE IS NULL;
			DISCHARGE_DATE IS NOT NULL;
-----------------------------------------------------
-- 연결연산자 -> || 여러개의 값들을 하나의 컬럼으로 연결
SELECT 
			PATIENT_NAME || '의 담당 코드는 ' || DOCTOR_ID || '입니다'	
FROM 
			PATIENT;
-------------------------------------------

SELECT
			PATIENT_NAME
			,BLOOD_TYPE
FROM 
			PATIENT
WHERE
			BLOOD_TYPE  IN ('A', 'B', 'O');
	/*	OR 
			BLOOD_TYPE = 'B'  OR 대신 위처럼 IN 또는 NOT IN 을 쓰면 편함
		OR 
			BLOOD_TYPE = 'O';
		*/
------------------------------------------


-- ORACLE 사용시 주의사항
SELECT
			PATIENT_NAME
			,WARD_ID
			,GENDER
			,WEIGHT_KG
FROM
			PATIENT
WHERE 
			WARD_ID = 'W3'
AND 
			GENDER = 'M'	 -- W1 이 섞여나왔는데 이유는 연산자 우선순위를 고려하지 않았기 때문 소괄호로 해결한다
OR 
			WEIGHT_KG >= 85;

-- ( ) , 산술연산자 , 연결연산자, 비교연산자 , IS NULL, LIKE, IN, BETWEEN AND(이 넷은 순위같음) , NOT , AND , OR
--순으로 연산이됨


/*
 * 헷갈리면 괄호를 치자, AND가 OR 보다 먼저 묶인다
 * 
 */
------------------------------------------------

SELECT * FROM PATIENT; --정렬이 되지 않은 상태이다
/*
 * 해서 SELECT의  OMEGA
 *  
 * ORDER BY
 * 
 * ORDER BY DESC -> 내림차순
 * 
 */


SELECT
			PATIENT_NAME
			,HEIGHT_CM
FROM 
			PATIENT
ORDER BY 
				HEIGHT_CM DESC;
---------------------------------------------

SELECT 
			PATIENT_NAME
			,ADMISSION_DATE
FROM 
			PATIENT
ORDER BY 
				ADMISSION_DATE DESC;


-----------------------------
SELECT 
			PATIENT_NAME
			,DISCHARGE_DATE
FROM 
			PATIENT
ORDER BY 
				DISCHARGE_DATE DESC; -- NULL 값을  큰값으로 취급 해서 밑으로 내리고 싶다 하면
-------------------------------------- NULLS LAST 또는 NULLS FIRST 를 붙인다
SELECT 
			PATIENT_NAME
			,DISCHARGE_DATE
FROM 
		PATIENT
ORDER BY 
				DISCHARGE_DATE DESC NULLS LAST;
----------------------------------------------------------

SELECT 
			PATIENT_NAME
			,HEIGHT_CM / 100 키
FROM 
			PATIENT
WHERE
			HEIGHT_CM / 100 >= 1.5
ORDER BY
				키 DESC; -- 2 DESC; 로도 사용가능하나 컬럼이 추가될수 있기에 추천가능하지 않음
	--------------------------------------------------------------			
				
-- 환자명, 병동
				/*
				 * 1. git init
2. git status
3. git add . 1
4. git commit -m "init : 저장소 초기화 작업"
5. git commit -m "init : 저장소 초기화"  22
6. git reomte add origin 주소 복붙.git
7. git push origin master 333
순서
				 * 
				 * 
				 * 
				 * 
				 * 
				 * 
				 * 
				 * 
				 */
SELECT 
			PATIENT_NAME
			,WARD_ID
FROM
			PATIENT
ORDER BY
			WARD_ID
			,PATIENT_NAME;

				