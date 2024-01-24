-- p.212 7장 연습문제
-- Q1)

select deptno, ROUND(AVG(SAL)) AS AVG_SAL,
              MAX(SAL) AS MAX_SAL,
              MIN(SAL) AS MIN_SAL,
              COUNT(SAL) AS CNT
  from emp
  group by deptno
  order by deptno desc;
  
-- Q2)
select job, count(*)
  from emp
  group by job
  having count(*) >= 3;
  
-- Q3)
select TO_CHAR(hiredate, 'YYYY') AS HIRE_YEAR,
      deptno, count(*) AS CNT
  from emp
  group by TO_CHAR(hiredate, 'YYYY'), deptno
  order by HIRE_YEAR desc;
  
-- Q4)
select * from emp;
select NVL2(COMM, 'O', 'X') AS EXIST_COMM, COUNT(*) AS CNT
  from emp
  group by NVL2(COMM, 'O', 'X')
  order by CNT desc;

-- Q5)
select DECODE(GROUPING(deptno), 1, '합계', nvl(to_char(deptno), '부서대기')) AS DEPTNO,
       DECODE(
       GROUPING(TO_CHAR(hiredate, 'YYYY')), 1, '소계', TO_CHAR(hiredate, 'YYYY')
       ) AS HIRE_YEAR,
       COUNT(*) AS CNT, MAX(SAL) AS MAX_SAL, SUM(SAL) AS SUM_SAL,
       ROUND(AVG(SAL), 2) AS AVG_SAL
    from emp
    group by rollup(deptno, TO_CHAR(hiredate, 'YYYY'))
    order by DEPTNO, HIRE_YEAR;
    
    
-- P.239 8장 연습문제
-- Q1)
select t1.deptno AS DEPTNO,
       t2.dname AS DNAME,
       t1.empno AS EMPNO,
       t1.ename AS ENAME,
       t1.sal AS SAL
  from emp t1, dept t2
  where t1.deptno = t2.deptno
    and SAL > 2000
  order by DEPTNO;
  
select t1.deptno AS DEPTNO,
       t2.dname AS DNAME,
       t1.empno AS EMPNO,
       t1.ename AS ENAME,
       t1.sal AS SAL
  from emp t1 inner join dept t2
    on t1.deptno = t2.deptno
  where SAL > 2000
  order by DEPTNO;
  
-- Q2)
select t1.deptno AS DEPTNO,
       t2.dname AS DNAME,
       ROUND(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
  from emp t1, dept t2
  where t1.deptno = t2.deptno
  group by t1.deptno, t2.dname;
  
select t1.deptno AS DEPTNO,
       t2.dname AS DNAME,
       ROUND(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
  from emp t1 join dept t2
  on t1.deptno = t2.deptno
  group by t1.deptno, t2.dname;
  
-- Q3)
select t1.deptno AS DEPTNO,
       t2.dname AS DNAME,
       t1.empno AS EMPNO,
       t1.ename AS ENAME,
       t1.job AS JOB,
       t1.sal AS SAL
  from emp t1, dept t2
  where t1.deptno(+) = t2.deptno
  order by DEPTNO;
  
select t1.deptno AS DEPTNO,
       t2.dname AS DNAME,
       t1.empno AS EMPNO,
       t1.ename AS ENAME,
       t1.job AS JOB,
       t1.sal AS SAL
  from emp t1 right outer join dept t2
  on t1.deptno = t2.deptno
  order by DEPTNO;
  
-- Q4)
   
-- 밑에 OPERATIONS가 출력이 안됨..
--select t4.deptno, t2.dname, t1.empno, t1.ename, t1.mgr, t1.sal,
--        t4.deptno, t3.losal, t3.hisal, t3.grade,
--        t4.empno AS MGR_EMPNO, t4.ename AS MGR_ENAME
--  from emp t1 right outer join dept t2 on t1.deptno = t2.deptno
--              inner join salgrade t3 on t1.sal between t3.losal and t3.hisal
--              left outer join emp t4 on t1.mgr = t4.empno
--  order by t1.deptno, t1.empno;
  
-- SQL-99 방식
select t4.deptno, t4.dname, t1.empno, t1.ename, t1.mgr, t1.sal,
        t1.deptno, t3.losal, t3.hisal, t3.grade,
        t2.empno AS MGR_EMPNO, t2.ename AS MGR_ENAME
  from emp t1 left outer join emp t2 on t1.mgr = t2.empno
              inner join salgrade t3 on t1.sal between t3.losal and t3.hisal
              right outer join dept t4 on t1.deptno = t4.deptno
  order by t1.deptno, t1.empno;
  
select t4.deptno, t4.dname, t1.empno, t1.ename, t1.mgr, t1.sal,
        t1.deptno, t3.losal, t3.hisal, t3.grade,
        t2.empno AS MGR_EMPNO, t2.ename AS MGR_ENAME
  from emp t1 , emp t2, salgrade t3, dept t4
    where t1.mgr = t2.empno(+) and
    (t1.sal between t3.losal(+) and t3.hisal(+)) and
    t1.deptno(+) = t4.deptno
  order by t1.deptno, t1.empno;

-- ---------------------- 강사님 정답
-- ---------------------- 부서정보가 기준이라 dept로 접근

select t1.deptno, t1.dname, t2.empno, t2.ename, t2.mgr, t2.sal, t2.deptno,
       t3.losal, t3.hisal, t3.grade,
       t4.empno AS MGR_EMPNO, t4.ename AS MGR_ENAME
  from dept t1, emp t2, salgrade t3, emp t4
  where t1.deptno = t2.deptno(+)
    and t2.sal between t3.losal(+) and t3.hisal(+)
    and t2.mgr = t4.empno(+)
  order by t1.deptno, t2.empno;
  
select t1.deptno, t1.dname, t2.empno, t2.ename, t2.mgr, t2.sal, t2.deptno,
       t3.losal, t3.hisal, t3.grade,
       t4.empno AS MGR_EMPNO, t4.ename AS MGR_ENAME
  from dept t1 left outer join emp t2 on t1.deptno = t2.deptno
               full outer join salgrade t3 on t2.sal between t3.losal and t3.hisal
               left outer join emp t4 on t2.mgr = t4.empno
  order by t1.deptno, t2.empno;



--  9장 연습문제 P.262

-- Q1)
SELECT T1.JOB, T1.EMPNO, T1.ENAME, T1.SAL, T2.DEPTNO, T2.DNAME
  FROM EMP T1, DEPT T2
  WHERE T1.DEPTNO = T2.DEPTNO
      AND JOB IN (SELECT JOB
                  FROM EMP
                  WHERE JOB = 'SALESMAN');
  
--  SELECT T1.JOB, T1.EMPNO, T1.ENAME, T1.SAL, T2.DEPTNO, T2.DNAME
--  FROM EMP T1, DEPT T2
--  WHERE JOB IN (SELECT JOB
--                  FROM EMP
--                  WHERE JOB = 'SALESMAN'
--                  AND T1.DEPTNO = T2.DEPTNO);


-- Q2)
SELECT T1.EMPNO, T1.ENAME, T2.DNAME, T1.HIREDATE, T2.LOC, T1.SAL, T3.GRADE
  FROM EMP T1, DEPT T2, SALGRADE T3
  WHERE T1.DEPTNO = T2.DEPTNO              -- T1 T2 조인
  AND T1.SAL BETWEEN T3.LOSAL AND T3.HISAL -- (T1 T2)조인 된거에 T3 조인
  AND T1.SAL > (SELECT AVG(SAL)            -- 서브쿼리 : 전체사원의 평균급여
                  FROM EMP)
  ORDER BY T1.SAL DESC, T1.EMPNO;


-- Q3)
--SELECT T1.EMPNO, T1.ENAME, T1.JOB, T1.DEPTNO, T2.DNAME, T2.LOC
--  FROM EMP T1 JOIN DEPT T2
--  ON T1.DEPTNO = T2.DEPTNO
--  WHERE EXISTS (SELECT *
--                FROM EMP
--                WHERE DEPTNO = 30);
                
SELECT T1.EMPNO, T1.ENAME, T1.JOB, T1.DEPTNO, T2.DNAME, T2.LOC
    FROM EMP T1 JOIN DEPT T2 ON T1.DEPTNO = T2.DEPTNO  -- T1, T2 조인
    WHERE T1.DEPTNO = 10                               -- 10번 부서
    AND NOT T1.JOB IN (SELECT JOB                      -- NOT IN 말고 EXISTS 쓰는 방법을 모르겠음
                        FROM EMP
                        WHERE DEPTNO = 30);
  
-- Q4)

-- 단일행 함수로 받는 방법
SELECT T1.EMPNO, T1.ENAME, T1.SAL, T2.GRADE
  FROM EMP T1 JOIN SALGRADE T2 ON T1.SAL BETWEEN T2.LOSAL AND T2.HISAL
  WHERE T1.SAL > (SELECT MAX(SAL)
                  FROM EMP 
                  WHERE JOB = 'SALESMAN')
  ORDER BY T1.EMPNO;
  

-- 다중행 연산자로 받는 방법
SELECT T1.EMPNO, T1.ENAME, T1.SAL, T2.GRADE
FROM EMP T1 JOIN SALGRADE T2 ON T1.SAL BETWEEN T2.LOSAL AND T2.HISAL
WHERE T1.SAL > ALL (SELECT SAL
                    FROM EMP 
                    WHERE JOB = 'SALESMAN')
ORDER BY T1.EMPNO;


  -- 다중행 연산자
  -- EX. 서브쿼리 결과 10, 20, 30
  
  -- =ANY, =SOME 은 IN과 같은 의미
  -- >ANY, >SOME : 최소값 보다 큰,  > MIN()   EX. 10보다 크면 true
  -- <ANY, <SOME : 최대값 보다 작은, < MAX()  EX. 30보다 작으면 true
  -- >ALL        : 최대값 보다 큰,  > MAX()   EX. 30보다 크면 true
  -- <ALL        : 최소값 보다 작은 < MIN()   EX. 10보다 작으면 true
  
  
  
  
  
  