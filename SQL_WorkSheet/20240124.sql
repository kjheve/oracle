/*  ���� ���� p.242 */

-- ���� ����
-- ��ü ����� �޿� ��պ��� ū ��� ����
SELECT *
  FROM EMP
  WHERE SAL > ( SELECT AVG(SAL)
                FROM EMP);
-- ��� ����
-- �μ��޿� ��պ��� ū ��� ����
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

-- ���� ������ ���� ǰ

-- P.265
-- ���̺� ����(����+������)
create table dept_tmp
  as select * from dept;

-- ���̺� ����
drop table dept_tmp;

-- ���̺� ����(������) P.272�� ������
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
--   �Ӽ�����Ʈ�� ���� ������ ���� VALUES���� ��� �Ӽ����� �Է��ؾ� �Ѵ�.
INSERT INTO DEPT_TMP
          VALUES (80, 'NETWORK3', 'BUSAN');

/*
ROLLBACK; -- �ֱ� COMMIT ������ �۾��� ���
COMMIT;   -- ���� COMMIT ������ �۾��� DB�� �ݿ�
*/

INSERT INTO DEPT_TMP (DEPTNO, DNAME, LOC)
          VALUES (90, 'NETWORK4', '');
INSERT INTO DEPT_TMP (DEPTNO, DNAME, LOC)
          VALUES (91, 'NETWORK5', ' ');
SELECT * FROM DEPT_TMP WHERE LOC IS NULL;
SELECT * FROM DEPT_TMP;




