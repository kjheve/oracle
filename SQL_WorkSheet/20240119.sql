-- ���� �ּ�
/* ������ �ּ� */
desc emp;
desc dept;
desc salgrade;

--��ü ��ȸ
select *
    from emp;
    
--�Ϻ� �÷� ��ȸ
select empno, ename
    from emp;
    
-- �÷� ����� ��Ī �ֱ�
select empno as "�����ȣ", ename as "�����" from emp; -- ��Ī�� �ֵ���ǥ�� ���Ѵ�.
select empno "�����ȣ", ename "�����" from emp; -- as�� ���� ����

-- �ߺ����� (default�� all)
select distinct deptno from emp;

-- (����P.84) ���� �����
select ename, sal, sal*12 as "����",
                   sal*12+comm as "����+�߰�����"
    from emp;
    
-- null �Լ��� ����Ͽ� null�̸� 0���� ����
-- nvl(����1, ����2) : ����1�� null�̸� ����2�� ǥ�� �ƴϸ� ����1
select ename as �����,
        sal as ����,
        sal*12 as "����",
        sal*12+nvl(comm, 0) as "����+�߰�����"
    from emp;

-- ���� : asc(�⺻��), desc
select ename as �����,
        sal as ����,
        sal*12 as "����",
        (sal*12)+nvl(comm,0) as "����+�߰�����"
    from emp
order by (sal*12)+nvl(comm,0) desc, ename desc;

-- ���ڵ� ���͸�
select *
    from emp
--    where sal >= 2000 and sal <= 3000;
    where sal between 2000 and 3000; -- ���� �ǹ� �ٸ�ǥ��
--not ������
select *
    from emp
    where not sal = 3000;
--in ������
select *
    from emp
    where sal in(3000, 5000);
    
-- LIKE ������
select *
    from emp
    where ename like 'A%';
select *
    from emp
    where ename like '_L%';
    
--���� ���̺� dual
select 1+1, 3-4, 5*6, 10/2, mod(10, 4) from dual;

--null ��
select *
    from emp
    where comm is null;
    
    
    