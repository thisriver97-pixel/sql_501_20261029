/*
SELECT => DATA QUERY LANGUAGE

INSERT, UPDATE, DELETE => DATA MANIPULATION LANGUAGE

<Insert>
새로운 행을 추가하는 구문

Insert into 테이블명 Values(값)
*/
-----INSERT를 써보자

INSERT INTO DEPT VALUES ('D9', '안과', '기타');

SELECT * FROM DEPT;

-----------------------------------
INSERT
INTO 
		WARD 
VALUES ('W6',
				'재활병동',
				'일반', 6);
SELECT * FROM WARD;

--------------------------------
INSERT 
INTO 
		DOCTOR(DOCTOR_ID, DOCTOR_NAME, POSITION_ID, HIRE_DATE)
VALUES ( 'DR13', '홍길동', 'J4', SYSDATE);

SELECT * FROM DOCTOR;

------------------------------
/*
 * 
 *  DELETE FROM 테이블명 WHERE 조건;	
 * 
 *테이블에서 행을 삭제하는 구문, 중복되는 것들 넣지않기
 *
 *TRUNCATE -> DELETE 보다 이론적으로 빠름, 롤백 불가
 */

DELETE FROM DOCTOR WHERE DOCTOR_ID = 'DR13';
SELECT *FROM DOCTOR;
-----------------------------------------------

/*
 * 
 * UPDATE
 * 				테이블명
 * SET
 * 				컬럼명 = 바꿀값
 * WHERE
 * 				조건;
 * 
 * 
 * 
 */

SELECT * FROM DEPT;

UPDATE
			DEPT
SET
			DEPT_TYPE = '안과'
			,DEPT_NAME = 'O안과'
WHERE
			DEPT_ID = 'D9';

