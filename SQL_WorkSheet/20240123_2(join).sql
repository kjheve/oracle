-- >>>>>>>>>>>>>>>>> JOIN <<<<<<<<<<<<<<<<<<

--1. �����(equal join) : t1 join t2 on ��������
--   ex) ����� �Ҽӵ� �μ���
--2. ������(non-equal join)
--3. ��ü����(self join) : �����ϰ��� �ϴ� �÷��� �ڽ��� ���̺� ���� ��
--   ex) ����� �����ڸ�
--5. �ܺ�����(outer join) :
--  t1 left outer join t2 on ��������
--   ex) ����� �Ҽӵ� �μ���(�μ��� ���� ��� ���̱�)
--
--  t1 right outer join t2 on ��������
--   ex) �μ��� �Ҽӵ� ���(����� ���� �μ��� ���̰�)
--
--  t1 full outer join t2 on ��������
--   ex) ����� �Ҽӵ� �μ���(�μ��� ���� ������̰�, ����� ���� �μ��� ���̰�)


-- FROM���� ���� ���̺� �����ϱ�
SELECT *
  FROM EMP, DEPT;
  
-- �� �̸��� ���ϴ� ���ǽ����� �����ϱ�
-- innder join(��������) : ���� �Ӽ��� �����ϰ� �Ӽ����� ���� �ุ �����ϰ��� �� ��
-- �����(equal join) �ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
SELECT *
  FROM EMP, DEPT
  WHERE EMP.DEPTNO = DEPT.DEPTNO
  ORDER BY EMP.DEPTNO;
  
  SELECT *
  FROM DEPT, EMP
  WHERE DEPT.DEPTNO = EMP.DEPTNO
  ORDER BY DEPT.DEPTNO;
  
-- ���̺� ��Ī�ֱ�
select t1.*, t2.* -- * �ε� ��밡��
  from emp t1, dept t2
  where t1.deptno = t2.deptno
  order by t1.deptno;
  
-- �� ���� p.224 �ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
select *
  from emp t1, salgrade t2
  where t1.sal BETWEEN t2.losal AND t2.hisal;
  
-- ��ü ���� p.227 �ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�
select t1.empno, t1.ename, t1.mgr,
       t2.empno AS MGR_EMPNO, t2.ename AS MGR_ENAME
  from emp t1, emp t2
  where t1.mgr = t2.empno;
  
-- ���� ���� (CONNECT_BY_ROOT)
SELECT LPAD(' ', 4*(LEVEL-1)) || ename ename, empno,
CONNECT_BY_ROOT  empno "Root empno", level
  FROM emp
 START WITH job='PRESIDENT'
CONNECT BY PRIOR empno=mgr;
-- �������� SYS_CONNECT_BY_PATH ����
SELECT LPAD(' ', 4*(LEVEL-1)) || ename ename, empno,
       SYS_CONNECT_BY_PATH(ename, '/') "PATH"
  FROM emp
 START WITH job='PRESIDENT'
CONNECT BY PRIOR empno=mgr;

-- �ܺ� ����(outer join) �ܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡܡ�

--Insert into emp values(8000, 'GILDONG', 'CLERK', null, to_date(sysdate), 4000, null, null);
--commit;
--select * from emp;
--insert into dept values(50, 'HUMANRESOURCES', 'LA');
--select * from dept;

-- ���� �ܺ� ����(Left Outer Join) : ���Ӽ��� �����ִ� ���� ���̺��� ����
-- ������ �ܺ� ����(Left Outer Join) : ���Ӽ��� �����ִ� ���� ���̺��� ������
-- case 1)
select t1.ename, t2.dname
  from emp t1, dept t2
  where t1.deptno = t2.deptno;
  
select t1.ename, t2.dname
  from emp t1, dept t2
  where t1.deptno = t2.deptno(+);
  
select t1.ename, t2.dname
  from emp t1, dept t2
  where t1.deptno(+) = t2.deptno;
  
-- case 2) ------------------- ���� ���� ���� Oracle�� ��� ����
select t1.ename, t2.dname
  from emp t1 inner join dept t2 -- (inner�� ��������)
  on t1.deptno = t2.deptno;
  
select t1.ename, t2.dname
  from emp t1 left outer join dept t2
  on t1.deptno = t2.deptno;
  
select t1.ename, t2.dname
  from emp t1 right outer join dept t2
  on t1.deptno = t2.deptno;
  
-- full outer join
select t1.ename, t2.dname
  from emp t1 full outer join dept t2
  on t1.deptno = t2.deptno
  order by t1.empno;
  
select *
  from emp t1 full outer join dept t2
  on t1.deptno = t2.deptno
  order by t1.empno;
  