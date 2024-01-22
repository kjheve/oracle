-- P.119 ���տ�����
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
  WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
  WHERE DEPTNO = 20
  order by DEPTNO;
  
--  P.125 ����------------------------------------------------
-- Q1)
select *
  from EMP
  where ENAME like '%S';
  
-- Q2)
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
  WHERE DEPTNO = 30
  AND JOB = 'SALESMAN';
  
-- Q3-1) ���� �����ڸ� ������� ���� ���
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
  WHERE (DEPTNO = 20 OR DEPTNO = 30) -- DEPTNO IN (20, 30)
  AND SAL > 2000;
-- Q3-2) ���� �����ڸ� ����� ��� [������(UNION)]
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
  WHERE DEPTNO = 20 AND SAL > 2000
UNION
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
  WHERE DEPTNO = 30 AND SAL > 2000;
-- Q3-3) ���� �����ڸ� ����� ��� [������(INTERSECT)]
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
  WHERE DEPTNO = 20 OR DEPTNO = 30
INTERSECT
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
  FROM EMP
  WHERE SAL > 2000;
  
-- Q4)
SELECT *
  FROM EMP
  WHERE NOT (SAL >= 2000 AND SAL <= 3000);
-- WHERE SAL < 2000 OR SAL > 3000;

-- Q5)
SELECT ENAME, EMPNO, SAL, DEPTNO
  FROM EMP
  WHERE ENAME LIKE '%E%'
  AND DEPTNO = 30
  AND SAL NOT BETWEEN 1000 AND 2000;
  
-- Q6)
SELECT *
  FROM EMP
  WHERE ENAME NOT LIKE '_L%'
  AND JOB IN ('MANAGER', 'CLERK')
  AND COMM IS NULL
  AND MGR IS NOT NULL;
        
-- p.133
SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�')
  FROM DUAL;
  
-- p.134 �κ� ���ڿ� ���
SELECT SUBSTR('KH���米����', 3) FROM DUAL; -- ���米����
SELECT SUBSTR('KH���米����', 3, 2) FROM DUAL; -- ����
SELECT SUBSTR('ȫ�浿', 1, 1) AS �� FROM DUAL; -- ��
SELECT SUBSTR('ȫ�浿', 2) AS �̸� FROM DUAL; -- �̸�
-- p.136 ������
SELECT SUBSTR('ȫ�浿', -2, 2) AS �̸� FROM DUAL; -- �̸�
SELECT JOB,
       SUBSTR(JOB, -LENGTH(JOB)) AS "-5",
       SUBSTR(JOB, -LENGTH(JOB), 2) AS "-5, 2",
       SUBSTR(JOB, -3) AS "-3"
       FROM EMP;
       
-- p.140 LPAD, RPAD
SELECT 'Oracle',
LPAD('Oracle', 10, '#') AS LAPD_1,
RPAD('Oracle', 10, '*') AS RPAD_1,
LPAD('Oracle', 10) AS LPAD_2,
RPAD('Oracle', 10) AS RPAD_2
  FROM DUAL;
-- p.141
SELECT
RPAD('971225-', 14, '*') AS RPAD_JMNO,
RPAD('010-1234-', 13, '*') AS RPAD_PHONE
  FROM DUAL;
  
-- p.144
SELECT
LTRIM('<_Oracle_>', '<_') FROM DUAL;
SELECT
LTRIM('<_Oracle_>', '_<') FROM DUAL;

-- p.150
SELECT SYSDATE AS NOW,
       SYSDATE-1 AS YESTERDAY,
       SYSDATE+1 AS TOMORROW
  FROM DUAL;
-- p.151 3���� �� ��¥ ���ϱ�
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 3)
  FROM DUAL;
-- 10�ֳ��� �Ǵ� ����� ������ ���ϱ�
SELECT EMPNO, ENAME, HIREDATE,
    ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR
  FROM EMP;
  
-- p.159
SELECT SYSDATE,
      TO_CHAR(SYSDATE, 'YYYY/MON/DD HH24:MI:SS DAY') AS ���糯¥�ð�,
      TO_CHAR(SYSDATE, 'YYYY/MON/DD HH24:MI:SS DAY', 'NLS_DATE_LANGUAGE = ENGLISH') AS ���糯¥�ð�
FROM DUAL;

-- p.164
SELECT TO_DATE('20180714', 'YYYY-MM-DD') AS TODATE FROM DUAL;

-- Q) �Ի����ڰ� 6���� ��� ����
SELECT *
  FROM EMP
  WHERE SUBSTR(TO_CHAR(HIREDATE), 4, 2) = '06';

--  SELECT TO_CHAR(SYSDATE) FROM DUAL;

-- Q) ������� �Ի��� ���
SELECT *
  FROM EMP
  WHERE SUBSTR(TO_CHAR(HIREDATE), 4, 2) =
               TO_CHAR(SYSDATE, 'MM');
               
-- Q) �ټӳ�� ���ϱ� O�� O����
-- �� ���� MONTHS_BETWEEN�� 12�� ������ �������� TRUNC�� ������
-- ���� ���� MONTHS_BETWEEN�� 12�� ������ ���������� ���� ��
SELECT ENAME, HIREDATE,
    TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12),'FM999') || '��' ||
    TO_CHAR(MOD(MONTHS_BETWEEN(SYSDATE, HIREDATE), 12),'FM00') || '����' AS �ټӳ��
    , MONTHS_BETWEEN(SYSDATE, HIREDATE) AS "�� �ټ� ����"
    , MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12 AS "�ټ� �� / 12"
    , MOD(MONTHS_BETWEEN(SYSDATE, HIREDATE), 12) "�ټ� ���� % 12"
  FROM EMP;
  
  
-- p.167
SELECT COMM, NVL(COMM, 0), NVL(COMM, 0)+100 from EMP;

SELECT COMM, NVL(COMM, 0), NVL(COMM, 0)+100, NVL2(COMM, 'O', 'X') from EMP;

-- p.170
SELECT EMPNO, ENAME, JOB,
    DECODE(JOB,
          'MANAGER', SAL*1.1,
          'SALESMAN', SAL*1.05,
          'ANALYST', SAL,
          SAL*1.03) AS UP_SAL,
    DECODE(JOB,
          'MANAGER', SAL*1.1,
          'SALESMAN', SAL*1.05,
          'ANALYST', SAL,
          SAL*1.03) - SAL AS �λ��
  FROM EMP;
--  p.172 CASE�� 01
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
          WHEN 'MANAGER' THEN SAL*1.1
          WHEN 'SALESMAN' THEN SAL*1.05
          WHEN 'ANALYST' THEN SAL
          ELSE SAL*1.03
    END AS UP_SAL,
    CASE JOB
          WHEN 'MANAGER' THEN SAL*1.1
          WHEN 'SALESMAN' THEN SAL*1.05
          WHEN 'ANALYST' THEN SAL
          ELSE SAL*1.03
    END - SAL �λ��
  FROM EMP;
  --  p.173 CASE�� 02
  SELECT EMPNO, ENAME, JOB, SAL,
    CASE
          WHEN JOB IN ('MANAGER', 'PRESIDENT') THEN SAL*1.1
          WHEN JOB = 'SALESMAN' THEN SAL*1.05
          WHEN JOB = 'ANALYST' THEN SAL
          ELSE SAL*1.03
    END AS UP_SAL,
    CASE
          WHEN JOB IN ('MANAGER', 'PRESIDENT') THEN SAL*1.1
          WHEN JOB = 'SALESMAN' THEN SAL*1.05
          WHEN JOB = 'ANALYST' THEN SAL
          ELSE SAL*1.03
    END - SAL AS "�λ��"
  FROM EMP;
  
-- p.174 ����------------------------------------------------
-- Q1)
SELECT EMPNO,
    RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS MASKING_EMPNO,
    ENAME,
    RPAD(SUBSTR(ENAME, 1, 1), 5, '*') AS MASKING_ENAME
  FROM EMP
  WHERE LENGTH(ENAME) >= 5 AND LENGTH(ENAME) < 6;
  
-- Q2)
SELECT EMPNO, ENAME, SAL,
    TRUNC(SAL/21.5, 2) AS DAY_PAY,
    ROUND(SAL/21.5/8, 1) AS TIME_PAY
  FROM EMP;

DESC EMP;
-- Q3)
SELECT EMPNO, ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '��'), 'RRRR-MM-DD') AS R_JOB,
    NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;

--SELECT to_char(SYSDATE, 'D') FROM DUAL;

-- Q4)
SELECT EMPNO, ENAME, MGR,
  CASE
    WHEN MGR IS NULL THEN '0000'
    WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
    WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
    WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
    WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
    ELSE TO_CHAR(MGR)
    END AS "CHG_MGR"
  FROM EMP;
  
  
-- p.186 ------------------------------
SELECT DEPTNO, SUM(SAL) "�޿���", ROUND(AVG(SAL), 1) "�޿����",
        MAX(SAL) "�ִ�޿�", MIN(SAL)"�ּұ޿�", COUNT(*) "�ο���"
FROM EMP
GROUP BY DEPTNO
ORDER BY SUM(SAL) DESC;

SELECT SUM(SAL) "�޿���", ROUND(AVG(SAL), 1) "�޿����",
        MAX(SAL) "�ִ�޿�", MIN(SAL)"�ּұ޿�", COUNT(*) "�ο���"
FROM EMP;