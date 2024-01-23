-- 부서별 급여 총액
select deptno, sum(sal)
  from emp
  group by deptno;

-- HAVING 사용 (10번 부서의 급여 총액)
select deptno, sum(sal)
  from emp
  group by deptno
  having deptno = 10;
  
-- 부서별 직무가 'CLERK'인 직원의 급여 총액
select deptno, sum(sal)  -- 4
  from emp               -- 1
  where job = 'CLERK'    -- 2
  group by deptno;       -- 3

-- 10번 부서에서 직무가 'CLERK'인 직원의 급여 총액
select deptno, sum(sal)  -- 5
  from emp               -- 1
  where job = 'CLERK'    -- 2
  group by deptno        -- 3
  having deptno = 10;    -- 4
  
-- 부서별 직무별 급여총액
select deptno, job, sum(sal)
  from emp
  group by deptno, job
  order by deptno, job;
  
-- 회장을 제외하고 부서별 직무별 급여총액 중 CLERK 직무를 제외하고 급여총액을 내림차순
select deptno, job, sum(sal) as 급여총액
  from emp
  where job != 'PRESIDENT'
  group by deptno, job
  having job != 'CLERK'
  order by 급여총액 desc;

-- group by절 뒤에 나열된 컬럼 또는 그룹함수만 select절에 올 수 있다.
select deptno,   sum(sal) as 급여총액
  from emp
  where job != 'PRESIDENT'
  group by deptno, job
  having job != 'CLERK'
  order by 급여총액 desc;
  
  
-- p.177 ~ p.192 실습 해보기
select sum(SAL)
  from emp;
--select ename, sum(SAL)
--  from emp;
select sum(COMM)
  from emp;
select sum(DISTINCT SAL),
    sum(ALL SAL),
    sum(SAL)
  from emp;
select COUNT(*)
  from emp;
select COUNT(*)
  from emp
  where deptno = 30;
select COUNT(DISTINCT SAL),
      COUNT(ALL SAL),
      COUNT(SAL)
    from emp;
select COUNT(COMM)
  from emp;
select COUNT(COMM)
  FROM emp
  where COMM IS NOT NULL;
  
select max(SAL)
  from emp
  where deptno = 10;
select min(SAL)
  from emp
  where deptno = 10;
select max(HIREDATE)
  from emp
  where deptno = 20;
select min(HIREDATE)
  from emp
  where deptno = 20;  
select AVG(SAL)
  from emp
  where deptno = 30;
select AVG(DISTINCT SAL)
  from emp
  where deptno = 30;
select avg(SAL), '10' AS DEPTNO from emp where deptno = 10
UNION ALL
select avg(SAL), '20' AS DEPTNO from emp where deptno = 20
UNION ALL
select avg(SAL), '30' AS DEPTNO from emp where deptno = 30;
select avg(SAL), deptno
  from emp
  group by deptno;
select deptno, job, avg(SAL)
  from emp
group by deptno, job
order by deptno, job;
--select ename, deptno, avg(SAL)
--  from emp
--  group by deptno;
select deptno, job, avg(SAL)
  from emp
  group by deptno, job
  having avg(SAL) >= 2000
  order by deptno, job;
--select deptno, job, avg(SAL)
--  from emp
--  where avg(SAL) >= 2000
--    group by deptno, job
--    order by deptno, job;
select deptno, job, avg(SAL)
  from emp
    group by deptno, job
      having avg(SAL) >= 2000
    order by deptno, job;
select deptno, job, avg(SAL)
  from emp 
  where SAL <= 3000
  group by deptno, job
      having avg(SAL) >= 2000
  order by deptno, job;
  
--  p. 196
  select deptno, job, count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by deptno, job
  order by deptno, job;
-- rollup(n) : 계층적 그룹화 n+1
  select deptno, job, count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by rollup(deptno, job);
-- cube(n) : 다차원적 그룹화 2^n
  select deptno, job, count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by cube(deptno, job);
--  grouping sets() : 평준화된 그룹화, 집계수 n개
  select deptno, job, count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by grouping sets(deptno, job)
  order by deptno;
  
  
-- GROUPING_ID : 컬럼값이 집계한 결과로 생긴 행인지 판별, 인자는 여러개 올 수 있다.
-- GROUP BY절에 ROLLUP함수를 사용한 경우 n+1개의 상태값을 0부터 순차적으로 가짐
-- GROUP BY절에 CUBE함수를 사용한 경우 2의 n승 개의 상태값을 0부터 순차적으로 가짐
  
-- grouping P.202
  select deptno, job, count(*), max(sal), sum(sal), avg(sal),
  grouping(deptno),
  grouping(job)
    from emp
  group by ROLLUP(deptno, job);
  
  -- grouping P.204 DECODE 사용
  select DECODE(GROUPING(DEPTNO), 1, '부서집계', DEPTNO) AS DEPTNO,
         DECODE(grouping(JOB), 1, '직무집계', JOB) AS JOB,
         count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by ROLLUP(deptno, job);
  
  -- grouping_ID P.205  이진수로 확인 : (10 => 2) / (01 => 1) / (10 => 2) / (11 => 3)
  select deptno, job, count(*), max(sal), sum(sal), avg(sal),
         grouping(deptno),
         grouping(job),
         GROUPING_ID(deptno, job)
    from emp
  group by cube(deptno, job)
  order by deptno, job;
  
-- grouping_ID P.205  
select DECODE(GROUPING_ID(DEPTNO, JOB), 2, '부서집계', 3, '총계', DEPTNO) AS DEPTNO,
       DECODE(GROUPING_ID(DEPTNO, JOB), 1, '직무집계', 3, ' ', JOB) AS JOB,
          count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by cube(deptno, job)
  order by deptno, job;
  
  
-- PIVOT p.208
SELECT *
    FROM ( SELECT DEPTNO, JOB, SAL
          FROM EMP ) t1
  PIVOT(MAX(SAL)
        FOR DEPTNO IN (10, 20, 30)
        )
ORDER BY JOB;