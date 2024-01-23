-- 1. EMP ���̺�� DEPT ���̺��� ������ؼ� ��� �̸��� �ش� ����� �μ� �̸��� ����Ͻÿ�.

-- case 1) natural join : ���̺��� ����� �÷���� �ڷ����� ���� ���� �ڵ����� ã�� ����
select t1.ename, t2.dname
  from emp t1 NATURAL JOIN dept t2;
  
-- case 2) join ~ using
select t1.ename, t2.dname
  from emp t1 JOIN dept t2
  USING (deptno);
  
-- case 3) (inner) join ~ on
select t1.ename, t2.dname
  from emp t1 join dept t2
  on t1.deptno = t2.deptno;
  
-- case 1~3 ) SQL-99ǥ��� : ��� ������ ������ ���̽��� ������ ������ �����.

-- case 4) where���� ���ǽ� �߰�
select t1.ename, t2.dname
  from emp t1, dept t2
  where t1.deptno = t2.deptno;

  
-- 2. EMP ���̺�� DEPT ���̺��� �ܺ������ؼ� ��� �̸��� �ش� ����� �μ� �̸��� ����Ͻÿ�.
-- �μ��� ���� ����� �����Ͻÿ�.

-- case 1) SQL-99 ǥ���
select t1.ename, t2.dname
  from emp t1 left outer join dept t2
  on t1.deptno = t2.deptno;
-- case 2) Oracle�� ������ ǥ����
select t1.ename, t2.dname
  from emp t1, dept t2
  where t1.deptno = t2.deptno(+);
  

-- 3. EMP ���̺�� SALGRADE ���̺��� �������ؼ� ��� �̸��� �ش� ����� �޿� ����� ����Ͻÿ�.

select t1.ename AS ����̸�, t2.grade AS �޿����
  from emp t1 join salgrade t2
  on t1.sal between losal and hisal
  order by �޿����;

select t1.ename AS ����̸�, t2.grade AS �޿����
  from emp t1, salgrade t2
  where t1.sal between losal and hisal;


-- 4. EMP ���̺�� SALGRAD ���̺��� �ܺ������ؼ� ��� �̸��� �ش� ����� �޿� ����� ����Ͻÿ�.
-- �޿� ����� ���� ����� �����Ͻÿ�. (�޿������ ���� ����� ���µ�..?)

select t1.ename AS ����̸�, t2.grade AS �޿����
  from emp t1 left outer join salgrade t2
  on t1.sal between losal and hisal
  order by �޿����;
  
select t1.ename AS ����̸�, t2.grade AS �޿����
  from emp t1, salgrade t2
  where t1.sal between losal and hisal(+)
  order by �޿���� desc;


-- 5. EMP ���̺�� DEPT ���̺��� ������ؼ� ��ü ����� ��� �޿��� �μ����� ����Ͻÿ�.

select t1.deptno AS �μ���ȣ, t2.dname AS �μ���,
round(avg(sal), 2) AS "��� �޿�"
  from emp t1 join dept t2
  on t1.deptno = t2.deptno
  group by t1.deptno, t2.dname
  order by �μ���;


-- 6. EMP ���̺�� DEPT ���̺��� �ܺ������ؼ� ��ü ����� ��� �޿��� �μ����� ����Ͻÿ�.
-- �μ��� ���� ����� �����Ͻÿ�.

select t1.deptno, t2.dname, round(avg(sal), 2)
  from emp t1 left outer join dept t2
  on t1.deptno = t2.deptno
  group by t1.deptno, t2.dname
  order by t1.deptno;
  

-- 7. EMP ���̺�� DEPT ���̺��� ������ؼ� ��� ���� 5�� �̻��� �μ��� �μ� �̸��� ��� ���� ����Ͻÿ�.

select t2.dname, COUNT(t2.dname)
  from emp t1 join dept t2
  on t1.deptno = t2.deptno
  group by t2.dname
  having COUNT(t2.dname) >= 5;
  

-- 8. EMP ���̺�� DEPT ���̺��� �ܺ������ؼ� ��� ���� 5�� �̻��� �μ��� �μ� �̸��� ��� ���� ����Ͻÿ�.
-- �μ��� ���� ����� �����Ͻÿ�. (�μ��� ���� �ο��� 5���� �ȳѾ -> ���Ϸ��� having�� �ּ�ó�� �ؾ���)

select t2.dname, COUNT(t2.dname)
  from emp t1 left outer join dept t2
  on t1.deptno = t2.deptno
  group by t2.dname;
--  having COUNT(t2.dname) >= 5;


-- 9. emp ���̺�� bonus ���̺��� ������ؼ� ��� �̸��� ���ʽ��� ����Ͻÿ�.

select t1.ename, t2.sal+t2.comm AS "���ʽ�"
  from emp t1 join bonus t2
  on t1.ename = t2.ename;


-- 10. emp ���̺�� bonus ���̺��� �ܺ������ؼ� ��� �̸��� ���ʽ��� ����Ͻÿ�.
-- ���ʽ��� ���� ���� ����� �����Ͻÿ�.
-- (���ʽ� ���̺��� �����Ͱ� ���ٸ� �� �ؿ� INSERT���� ���� �Ͻÿ�)

select t1.ename, t2.sal+t2.comm AS "���ʽ�"
  from emp t1 left outer join bonus t2
  on t1.ename = t2.ename;


--11. EMP ���̺��� ���� �����ؼ� ���� �μ����� ���ϴ� ������� �̸��� ����Ͻÿ�.
 
select deptno,
       LISTAGG(ename, ', ')
  from emp
group by deptno;

select t1.deptno,
       LISTAGG(t1.ename, ', ')
  from emp t1, emp t2
  where t1.ename = t2.ename
  group by t1.deptno
  order by t1.deptno;


--12. EMP ���̺��� ���� �����ؼ� �ڽź��� �� ���� �޿��� �޴� ������� �̸��� ����Ͻÿ�.

select * from emp;

select t1.deptno
  from emp t1, emp t2
  where t1.empno = t2.empno;













--INSERT INTO bonus (ename, job, sal, comm) VALUES ('SCOTT', 'ANALYST', 3000, 500);
--INSERT INTO bonus (ename, job, sal, comm) VALUES ('FORD', 'ANALYST', 3000, 500);
--INSERT INTO bonus (ename, job, sal, comm) VALUES ('SMITH', 'CLERK', 800, 200);
--INSERT INTO bonus (ename, job, sal, comm) VALUES ('ADAMS', 'CLERK', 1100, 300);
--INSERT INTO bonus (ename, job, sal, comm) VALUES ('JONES', 'MANAGER', 2975, 800);
--commit;
--select * from bonus;
--ROLLBACK; --�����͸� �߸� �־��� ��� �ѹ�