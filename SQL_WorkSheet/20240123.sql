-- �μ��� �޿� �Ѿ�
select deptno, sum(sal)
  from emp
  group by deptno;

-- HAVING ��� (10�� �μ��� �޿� �Ѿ�)
select deptno, sum(sal)
  from emp
  group by deptno
  having deptno = 10;
  
-- �μ��� ������ 'CLERK'�� ������ �޿� �Ѿ�
select deptno, sum(sal)  -- 4
  from emp               -- 1
  where job = 'CLERK'    -- 2
  group by deptno;       -- 3

-- 10�� �μ����� ������ 'CLERK'�� ������ �޿� �Ѿ�
select deptno, sum(sal)  -- 5
  from emp               -- 1
  where job = 'CLERK'    -- 2
  group by deptno        -- 3
  having deptno = 10;    -- 4
  
-- �μ��� ������ �޿��Ѿ�
select deptno, job, sum(sal)
  from emp
  group by deptno, job
  order by deptno, job;
  
-- ȸ���� �����ϰ� �μ��� ������ �޿��Ѿ� �� CLERK ������ �����ϰ� �޿��Ѿ��� ��������
select deptno, job, sum(sal) as �޿��Ѿ�
  from emp
  where job != 'PRESIDENT'
  group by deptno, job
  having job != 'CLERK'
  order by �޿��Ѿ� desc;

-- group by�� �ڿ� ������ �÷� �Ǵ� �׷��Լ��� select���� �� �� �ִ�.
select deptno,   sum(sal) as �޿��Ѿ�
  from emp
  where job != 'PRESIDENT'
  group by deptno, job
  having job != 'CLERK'
  order by �޿��Ѿ� desc;
  
  
-- p.177 ~ p.192 �ǽ� �غ���
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
-- rollup(n) : ������ �׷�ȭ n+1
  select deptno, job, count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by rollup(deptno, job);
-- cube(n) : �������� �׷�ȭ 2^n
  select deptno, job, count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by cube(deptno, job);
--  grouping sets() : ����ȭ�� �׷�ȭ, ����� n��
  select deptno, job, count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by grouping sets(deptno, job)
  order by deptno;
  
  
-- GROUPING_ID : �÷����� ������ ����� ���� ������ �Ǻ�, ���ڴ� ������ �� �� �ִ�.
-- GROUP BY���� ROLLUP�Լ��� ����� ��� n+1���� ���°��� 0���� ���������� ����
-- GROUP BY���� CUBE�Լ��� ����� ��� 2�� n�� ���� ���°��� 0���� ���������� ����
  
-- grouping P.202
  select deptno, job, count(*), max(sal), sum(sal), avg(sal),
  grouping(deptno),
  grouping(job)
    from emp
  group by ROLLUP(deptno, job);
  
  -- grouping P.204 DECODE ���
  select DECODE(GROUPING(DEPTNO), 1, '�μ�����', DEPTNO) AS DEPTNO,
         DECODE(grouping(JOB), 1, '��������', JOB) AS JOB,
         count(*), max(sal), sum(sal), avg(sal)
    from emp
  group by ROLLUP(deptno, job);
  
  -- grouping_ID P.205  �������� Ȯ�� : (10 => 2) / (01 => 1) / (10 => 2) / (11 => 3)
  select deptno, job, count(*), max(sal), sum(sal), avg(sal),
         grouping(deptno),
         grouping(job),
         GROUPING_ID(deptno, job)
    from emp
  group by cube(deptno, job)
  order by deptno, job;
  
-- grouping_ID P.205  
select DECODE(GROUPING_ID(DEPTNO, JOB), 2, '�μ�����', 3, '�Ѱ�', DEPTNO) AS DEPTNO,
       DECODE(GROUPING_ID(DEPTNO, JOB), 1, '��������', 3, ' ', JOB) AS JOB,
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