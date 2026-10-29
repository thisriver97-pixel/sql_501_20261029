/*
함수 ->
단일행 함수             그룹함수
*/
-- 한글 3BYTE         영어,숫자, 특수문자 1BYTE LENGTH 라는 것이 있다
SELECT
			DOCTOR_NAME
			,LENGTH(DOCTOR_NAME)
			,LENGTHB(DOCTOR_NAME)
FROM
			DOCTOR;
-------------------------------------------------
/*
INSTR()
지정한 위치부터 특정 문자를 검색하여 가장 먼저 찾은 위치 반환, 위치값

DUAL - 가짜 테이블 -1 붙이면 역순으로 조회
*/
SELECT INSTR('AAADDFDFDFDFEC', 'D', -1) FROM DUAL;

------------------------------------------------------
/*
 * 
 * SUBSTR(문자열, 시작위치, 추출할 문자개수)
 */


SELECT 
			PATIENT_NAME
			,SUBSTR(PATIENT_NAME, 1, 1) AS "성"
			,SUBSTR(PATIENT_NAME, 2) AS "이름"
FROM 
			PATIENT;
/*
LPAD / RPAD (문자열, 최종길이 ,덧붙일 문자)
-> PAD쓸땐 한글 2BYTE !!!!
마스킹 처리시 사용
*/
SELECT 
			PATIENT_NAME
			,LPAD(PATIENT_NAME, 10, '*')
			,RPAD(PATIENT_NAME, 10, '*')
FROM 
			PATIENT;
------------------------------------------

SELECT 	
			PATIENT_NAME
			,RPAD(SUBSTR(PATIENT_NAME, 1, 1), 4, '*')
			,SUBSTR(PATIENT_NAME, 1, 1) || '*' || SUBSTR(PATIENT_NAME, 3)
FROM 
			PATIENT;

---------------------------------------------------------

/*
TRIM(문자열) : 양쪽 공백제거
LTRIM(문자열, 제거할문자) : 왼쪽에서 제거
RTRIM(문자열, 제거할문자) : 오른쪽에서 제거


*/

SELECT '                                ASFDDSAF                                   '
			,TRIM('                                ASFDDSAF                                   ')
			,LTRIM('aaaa데이터', 'a')
			,RTRIM('데이터bbbb', 'b')
FROM DUAL;
----------------------------------------------------
/*
 * ABS() : 절대값
 * MOD(num1, num2) : 모듈러 연산
 * ROUND() :반올림
 * CEIL() : 올림
 * FLOOR() : 내림
 * TRUNC() : 버림
 *
 * 
 */
SELECT 
			MOD(10, 4)
			,ROUND(1.2356, 2)
			,CEIL(1.2)
			,FLOOR(2.9)
			,TRUNC(3.141592, 3) -- 버림, 절삭
FROM 
			DUAL;

--표준체중과 실제 몸무게의 차이

SELECT 
			PATIENT_NAME
			,HEIGHT_CM - 100 "표준체중"
			,WEIGHT_KG
			,ABS(WEIGHT_KG - (HEIGHT_CM - 100)) "차이"
FROM 	
			PATIENT;

---------------------------- 날짜 SYSDATE

SELECT 
			SYSDATE 
FROM
			DUAL;

---환자 나이조회

SELECT
			PATIENT_NAME
			,FLOOR(FLOOR(SYSDATE - BIRTH_DATE) / 365) || '살'
			,FLOOR(MONTHS_BETWEEN(SYSDATE, BIRTH_DATE)	/ 12)
			,FLOOR(SYSDATE - ADMISSION_DATE) "입원일수"
FROM 
			PATIENT;

-----------------------
-- LAST DAY 해당 월의 말일 표기
SELECT
			PATIENT_NAME
			,ADMISSION_DATE
			,LAST_DAY(ADMISSION_DATE)
FROM 
			PATIENT;


SELECT 
			NEXT_DAY(SYSDATE, '월요일') -- 가장 가까운 요일의 날짜
FROM 	
			DUAL;

SELECT * FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_LANGUAGE';
-------------------------------------------------
/*
 * 형변환 함수
 * 
 * TO_CHAR(날짜|숫자) : 문자타입으로 변환
 * TO_DATD(문자) 		   : 날짜타입으로 변환
 * TO_NUMBER	           : 숫자타입으로 변환
 * 
 * 날짜형식 4자리 , 2자리 YYYY, YY(년) / RR : 1 ~ 49 는 2000년대, 50 ~ 99는 1900년대
 * MM 월 , MON 월 이름
 * HH MI SS DY 시, 분, 초 요일약자(DY)
 */

SELECT 
			PATIENT_NAME
			,ADMISSION_DATE
			,TO_CHAR(ADMISSION_DATE, 'YYYY')
			,TO_CHAR(ADMISSION_DATE, 'MM')
		--	,TO_CHAR(ADMISSION_DATE, 'YYYY') - 2000
			,TO_CHAR(SYSDATE, 'YYYY-MON-DD')
FROM 
			PATIENT;
---TO_DATE
SELECT 
			PATIENT_NAME
			,ADMISSION_DATE
FROM 		
			PATIENT
WHERE
			ADMISSION_DATE >= TO_DATE('2026/10/20', 'YYYY-MM-DD');

-------------------------------------------------------
--숫자 쉼표찍기
SELECT 
			TO_CHAR('15000000', 'L9,999,999,999') AS "진료비"
FROM 
		DUAL;
---------------------※※※※NULL 처리함수※※※※-------------------

SELECT TO_NUMBER('100') + 50 FROM DUAL; 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
			PATIENT_NAME
			,DISCHARGE_DATE
			,NVL(TO_CHAR(DISCHARGE_DATE, 'YYYY-MM-DD'), '입원중')
FROM
		PATIENT;
---------------------------------
SELECT	
			PATIENT_NAME
			,NVL(DOCTOR_ID, '미배정')
			,NVL2(DOCTOR_ID, '배정완료', '미배정')			
FROM 
			PATIENT;
--------------------------------------
/*
 * DECODE(비교대상, 조건1, 결과1, 조건2, 결과2,..............
 * CASE WHEN 조건 THEN 결과 ELSE 기본값 END
 */

SELECT 
			PATIENT_NAME
			,DECODE(GENDER, 'M', '남', 'F', '여')
			,CASE GENDER
			WHEN 'M' THEN '남성'
			WHEN 'F' THEN '여성'
			ELSE '성별선택안함'
			END 성별
FROM 
			PATIENT;
