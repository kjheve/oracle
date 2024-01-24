/*  서브 쿼리 p.242 */

-- 비상관 쿼리
-- 전체 사원의 급여 평균보다 큰 사원 정보
SELECT *
  FROM EMP
  WHERE SAL > ( SELECT AVG(SAL)
                FROM EMP);
-- 상관 쿼리
-- 부서급여 평균보다 큰 사원 정보
SELECT *
  FROM EMP T1
  WHERE SAL > (SELECT AVG(T2.SAL)
                  FROM EMP T2
                  WHERE T1.DEPTNO = T2.DEPTNO);


SELECT T1.DEPTNO, AVG(T2.SAL)
     FROM EMP T1, EMP T2
     WHERE T1.DEPTNO = T2.DEPTNO
     GROUP BY T1.DEPTNO;
                  
SELECT ENAME, DEPTNO, SAL, AVG(SAL) OVER (PARTITION BY DEPTNO)
   FROM EMP T1;

-- 이후 문제를 많이 품

-- P.265
-- 테이블 복사(구조+데이터)
create table dept_tmp
  as select * from dept;

-- 테이블 삭제
drop table dept_tmp;

-- 테이블 복사(구조만) P.272의 내용임
create table dept_tmp
  as select * from dept
  where 1=2;
  
select * from DEPT_TMP;

--INSERT INTO DEPT_TMP (DEPTNO, DNAME, LOC)
--          VALUES (50, 'HUMANRESOURCES', 'LA');

INSERT INTO DEPT_TMP (DEPTNO, DNAME, LOC)
          VALUES (60, 'NETWORK', 'ULSAN');
INSERT INTO DEPT_TMP (DEPTNO, DNAME)
          VALUES (70, 'NETWORK2');
--   속성리스트가 생략 가능한 경우는 VALUES절에 모든 속성값을 입력해야 한다.
INSERT INTO DEPT_TMP
          VALUES (80, 'NETWORK3', 'BUSAN');

/*
ROLLBACK; -- 최근 COMMIT 이후의 작업을 취소
COMMIT;   -- 이전 COMMIT 이후의 작업을 DB에 반영
*/

INSERT INTO DEPT_TMP (DEPTNO, DNAME, LOC)
          VALUES (90, 'NETWORK4', '');
INSERT INTO DEPT_TMP (DEPTNO, DNAME, LOC)
          VALUES (91, 'NETWORK5', ' ');
SELECT * FROM DEPT_TMP WHERE LOC IS NULL;
SELECT * FROM DEPT_TMP;




