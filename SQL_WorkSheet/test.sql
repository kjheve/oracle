-- ���̺� ����
drop table works;
drop table project;
drop table employee;
drop table department;



-- ��1. ���̺� ����
--���
create table employee(
  empno     number(4),
  name      varchar2(12),
  phoneno   varchar2(12),
  address   varchar2(12),
  sex       varchar2(3),
  position  varchar2(9),
  salary    number(8),
  deptno    number(2)
);

--�μ�
create table department(
  deptno    number(2),
  deptname  varchar2(9),
  manager   number(4)
);

-- ������Ʈ
create table project(
  projno    number(3),
  projname  varchar2(20),
  deptno    number(2)
);

-- Works
create table works(
  empno       number(4),
  projno      number(3),
  hoursworked number(4)
);


-- ��2. �⺻Ű �߰�
alter table employee add constraint employee_empno_pk
                      primary key(empno);
alter table department add constraint department_deptno_pk
                      primary key(deptno);
alter table project add constraint project_projno_pk
                      primary key(projno);
alter table works add constraint works_pk
                      primary key(empno, projno);

-- ��3. �ܷ�Ű �߰�
alter table employee add constraint employee_deptno_fk
                      foreign key (deptno) references department;
                                       
alter table project add constraint project_dept_deptno_fk
                      foreign key (deptno) references department;

alter table works add constraint works_empno_fk
                      foreign key (empno) references employee;
alter table works add constraint works_projno_fk
                      foreign key (projno) references project;

-- ��4. ������ �������� �߰�
-- 4.1 
alter table employee add constraint employee_sex_ck check (sex in ('��', '��'));
-- 4.2
alter table works add constraint works_hoursworked_ck check (hoursworked > 0);
-- 4.3
alter table employee modify name not null;
alter table department modify deptname not null;
alter table project modify projname not null;
-- 4.4
alter table department add constraint department_deptname_uk unique(deptname);
-- 4.5
alter table employee modify salary default 0;

-- ��5. �⺻Ű�� �������� ����(�����)
drop sequence empno_seq;
create sequence empno_seq
increment by 1
start with 1001;


-- ��6. �����͸� �����ϴ� insert���� �ۼ��ϰ� ����� ����� ���̽ÿ�
-- department
insert into department values(10, '������', 1001);
insert into department values(20, 'ȸ����', 1004);
insert into department values(30, '������', 1007);
insert into department values(40, '�ѹ���', 1011);
insert into department values(50, '�λ���', 1013);

select * from department;

-- project
insert into project values(101, '�����ͱ���', 10);
insert into project values(102, 'IFRS', 20);
insert into project values(103, '������', 30);

select * from project;

-- employee
insert into employee
  values (empno_seq.nextval, 'ȫ�浿1', '010-111-1001', '���1', '��', '����', 7000000, 10);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿2', '010-111-1002', '���2', '��', '����1', 4000000, 10);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿3', '010-111-1003', '���3', '��', '����2', 3000000, 10);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿4', '010-111-1004', '�λ�1', '��', '����', 6000000, 20);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿5', '010-111-1005', '�λ�2', '��', '����1', 3500000, 20);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿6', '010-111-1006', '�λ�3', '��', '����2', 2500000, 20);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿7', '010-111-1007', '����1', '��', '����', 5000000, 30);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿8', '010-111-1008', '����2', '��', '����1', 4000000, 30);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿9', '010-111-1009', '����3', '��', '����2', 3000000, 30);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿10', null, '����4', '��', '����3', 2000000, 30);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿11', '010-111-1011', '�뱸1', '��', '����', 5500000, 40);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿12', '010-111-1012', '�뱸2', '��', '����1', 2000000, 40);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿13', '010-111-1013', '����1', '��', '����', 6500000, 50);
insert into employee
  values (empno_seq.nextval, 'ȫ�浿14', '010-111-1014', '����2', '��', '����1', 3500000, 50);

select * from employee;

-- works
insert into works (empno, projno, hoursworked) values (1001, 101, 800);
insert into works (empno, projno, hoursworked) values (1002, 101, 400);
insert into works (empno, projno, hoursworked) values (1003, 101, 300);
insert into works (empno, projno, hoursworked) values (1004, 102, 700);
insert into works (empno, projno, hoursworked) values (1005, 102, 500);
insert into works (empno, projno, hoursworked) values (1006, 102, 200);
insert into works (empno, projno, hoursworked) values (1007, 103, 500);
insert into works (empno, projno, hoursworked) values (1008, 103, 400);
insert into works (empno, projno, hoursworked) values (1009, 103, 300);
insert into works (empno, projno, hoursworked) values (1010, 103, 200);

select * from works;



-- ��7. ��� �� ���� ���� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
select substr(name, 1, 1) as "Family_Name",
       count(*) as "cnt"
  from employee
  group by substr(name, 1, 1);

-- ��8. '������' �μ����� ���ϴ� ����� �̸�, ����ó, �ּҸ� ���̽ÿ�.
-- ����ó�� ������ ����ó ���� ǥ��, ����ó ��4�ڸ� �� ��2�ڸ��� ��ǥ * �� ǥ��
select t1.name,
      case
        when t1.phoneno is null then '����ó ����'
        else concat(rpad(substr(t1.phoneno, 1, 8), 10, '*'), substr(t1.phoneno, 11, 2))
        end as phoneno,
      t1.address
  from employee t1 join department t2 on t1.deptno = t2.deptno
  where t2.deptname = '������';
  
-- ��9. ȫ�浿7 ���� �μ����� ���ϴ� ������ ���� ���̽ÿ�.
select count(*) as "������ ��"
  from employee
  where deptno = 30;

-- ��10. ������Ʈ�� �������� ���� ����� �̸��� ���̽ÿ�.
select t1.name
  from employee t1 left outer join works t2 on t1.empno = t2.empno
  where t2. hoursworked is null
  order by t1.name;

-- ��11. �޿� ���� TOP 3�� ������ �Բ� ���̽ÿ�.
select name, salary, rank() over(order by salary desc) as ����
  from employee
  fetch first 3 rows only;

-- ��12. ������� ���� �ð� ���� �μ���, ��� �̸��� ������������ ���̽ÿ�.
select t3.deptname, t1.name, t2.hoursworked
  from employee t1 join works t2 on t1.empno = t2.empno
                  join department t3 on t1.deptno = t3.deptno
  group by t3.deptname, t1.name, t2.hoursworked
  order by t3.deptname, t1.name desc;

-- ��13. �μ����� �޿��� �μ���� �޿� ���� ���� ����� �̸��� ������ ���̽ÿ�.
select t2.deptname, t1.name , t1.salary
  from employee t1 join department t2 on t1.deptno = t2.deptno
  where t1.salary > (select round(avg(salary), 2)
                      from employee t3
                      where t1.deptno = t3.deptno
                      group by t3.deptno)
  order by t1.salary desc;
  
-- ��14. 2�� �̻��� ����� ������ ������Ʈ�� ��ȣ, ������Ʈ��, ����� ���� ���̽ÿ�.
select t1.projno, t1.projname, count(*) as "����� ��"
  from project t1 join works t2 on t1.projno = t2.projno
  group by t1.projno, t1.projname
  having count(*) >= 2
  order by t1.projno;

-- ��15. ������Ʈ�� �����ð��� ���� ���� ����� ���� ����� �̸��� ���̽ÿ�.
select t3.name as "���� ���� ���", t3.MAX as �����ð�,
       t4.name as "���� ���� ���", t4.MIN as �����ð�
  from (select t2.name, max(t1.hoursworked) as MAX
          from works t1, employee t2
          where t1.empno = t2.empno
          group by t2.name
          order by MAX desc) t3,
       (select t2.name, max(t1.hoursworked) as MIN
          from works t1, employee t2
          where t1.empno = t2.empno
          group by t2.name
          order by MIN) t4
    fetch first 1 rows only;
  
-- ��16. ������ �޿��� 10% �λ��ϰ� �λ�� ����� ���̽ÿ� (��, department ���̺��� Ȱ���� ��)
-- case 1)
select t1.empno, t1.name, t1.phoneno, t1.address, t1.sex,
       t1.position, t1.salary*1.1 as salary, t2.deptname
  from employee t1 join department t2 on t1.empno = t2.manager;
  
-- case 2)
select t1.empno, t1.name, t1.phoneno, t1.address, t1.sex, t1.position,
       case 
          when t2.manager in (select manager from department) then salary*1.1
          when t2.manager > 0 then salary
       end as salary,
       t2.deptname
  from employee t1 join department t2 on t1.deptno = t2.deptno;
  
-- ��17. ����� ������ ������Ʈ�� ���� �����, ������Ʈ��, �����ð��� ���̴� �並 �ۼ��Ͻÿ�.
-- �� ����
drop view project_empinfo_vw;
-- �� ����
create view project_empinfo_vw as
select t1.name, t3.projname, t4.hoursworked
  from employee t1 join department t2 on t1.deptno = t2.deptno
                  join project t3 on t1.deptno = t3.deptno
                  join works t4 on t1.empno = t4.empno and t3.projno = t4.projno;
                  
-- ��18. employee ���̺��� name ���� ������� �ε����� �����Ͻÿ�.
-- (��, �ε������� idx_employee_name)
-- �ε��� ����
--drop index idx_employee_name;
-- �ε��� ����
create index idx_employee_name on employee(name);







