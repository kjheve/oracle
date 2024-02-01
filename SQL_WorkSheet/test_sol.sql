-- �ܷ�Ű ����
alter table employee drop constraint employee_deptno_fk;
alter table department drop constraint department_manager_fk; 
alter table project drop constraint project_dept_deptno_fk;
alter table works drop constraint works_empno_fk;
alter table works drop constraint works_projno_fk;

-- ���̺� ����
drop table works;
drop table project;
drop table employee;
drop table department;


--�ڹ���1) ���̺� ����
--1) department
create table department(
    deptno      number(2),
    deptname    varchar2(20),
    manager     number(4)
);

--2) employee
create table employee(
    empno       number(4),
    name        varchar2(20),
    phoneno     varchar2(20),
    address     varchar2(20),
    sex         char(3),
    position    varchar2(20),
    salary      number(7),
    deptno      number(2)
);

--3) project
create table project(
    projno      number(3),
    projname    varchar2(20),
    deptno      number(2)
);

--4) works
create table works(
    projno      number(3),
    empno       number(4),
    hoursworked number(3)
);

-- ����������
-- ����2) �⺻Ű
alter table department add constraint department_deptno_pk primary key(deptno);
alter table employee add constraint employee_empno_pk primary key(empno);
alter table project add constraint project_projno_pk primary key(projno);
alter table works add constraint works_projno_empno_pk primary key(projno, empno);

-- ����3) �ܷ�Ű
alter table employee add constraint employee_deptno_fk
                      foreign key (deptno) references department(deptno);

alter table department add constraint department_manager_fk
                      foreign key (manager) references employee(empno); -- �ڡ١��̰� �ȳ���..�ڡ١�

alter table project add constraint project_dept_deptno_fk
                      foreign key (deptno) references department(deptno);

alter table works add constraint works_empno_fk
                      foreign key (empno) references employee(empno);
alter table works add constraint works_projno_fk
                      foreign key (projno) references project(projno);

-- ����4) ������ ��������
-- 1)
alter table employee add constraint employee_sex_ck check (sex in ('��', '��'));
-- 2)
alter table works add constraint works_hoursworked_ck check (hoursworked > 0);
-- 3)
alter table employee modify name not null;
alter table department modify deptname not null;
alter table project modify projname not null;
-- 4)
alter table department add constraint department_deptname_uk unique(deptname);
-- 5)
alter table employee modify salary default 0;

-- �ڹ���5)
drop sequence employee_empno_seq;
create sequence employee_empno_seq start with 1001;


-- �ڹ���6) ���� ������ ����
insert into department (deptno, deptname) values (10, '������');
insert into department (deptno, deptname) values (20, 'ȸ����');
insert into department (deptno, deptname) values (30,'������');
insert into department (deptno, deptname) values (40, '�ѹ���');
insert into department (deptno, deptname) values (50,'�λ���');

insert into project values (101, '�����ͱ���', 10);
insert into project values (102, 'IFRS', 20);
insert into project values (103, '������', 30);

insert into employee values (employee_empno_seq.nextval,'ȫ�浿1','010-111-1001','���1','��','����',7000000,10);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿2','010-111-1002','���2','��','����1',4000000,10);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿3','010-111-1003','���3','��','����2',3000000,10);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿4','010-111-1004','�λ�1','��','����',6000000,20);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿5','010-111-1005','�λ�2','��','����1',3500000,20);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿6','010-111-1006','�λ�3','��','����2',2500000,20);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿7','010-111-1007','����1','��','����',5000000,30);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿8','010-111-1008','����2','��','����1',4000000,30);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿9','010-111-1009','����3','��','����2',3000000,30);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿10',null,'����4','��','����3',2000000,30);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿11','010-111-1011','�뱸1','��','����',5500000,40);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿12','010-111-1012','�뱸2','��','����1',2000000,40);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿13','010-111-1013','����1','��','����',6500000,50);
insert into employee values (employee_empno_seq.nextval,'ȫ�浿14','010-111-1014','����2','��','����1',3500000,50);

insert into works values (101, 1001, 800);
insert into works values (101, 1002, 400);
insert into works values (101, 1003, 300);
insert into works values (102, 1004, 700);
insert into works values (102, 1005, 500);
insert into works values (102, 1006, 200);
insert into works values (103, 1007, 500);
insert into works values (103, 1008, 400);
insert into works values (103, 1009, 300);
insert into works values (103, 1010, 200);

update department set manager = 1001 where deptname = '������';
update department set manager = 1004 where deptname = 'ȸ����';
update department set manager = 1007 where deptname = '������';
update department set manager = 1011 where deptname = '�ѹ���';
update department set manager = 1013 where deptname = '�λ���';

commit;

select * from employee;
select * from department;
select * from project;
select * from works;


-- �ڹ���7)
select substr(name, 1, 1) as ��, count(*) as �ο���
  from employee
  group by substr(name, 1, 1);

-- �ڹ���8)
-- ���� ������ �� �� ���ڵ� ���� ������ �տ�
select t1.name,
      nvl2(t1.phoneno, -- �����ȣ��
           substr(t1.phoneno, 1, 8) || '**' || substr(t1.phoneno, 11, 2), -- null�� �ƴ� ��
           '����ó ����') as ��ȭ��ȣ, -- null�� ��
      t1.address
  from employee t1 join department t2 on t1.deptno = t2.deptno
  where t2.deptname = '������';

-- �ڹ���9)
select count(*) as ������
  from employee
  where deptno = (select deptno
                    from employee
                    where name = 'ȫ�浿7')
  and name <> 'ȫ�浿7';

select count(*) as ������
  from employee t3
  where deptno = (select t1.deptno
                  from employee t1 join department t2 on t1.empno = t2.manager
                  where t1.name = 'ȫ�浿7')
    and name <> 'ȫ�浿7';

-- �ڹ���10)
-- case1) �ܺ�����
select t1.name
  from employee t1 left outer join works t2 on t1.empno = t2.empno
  where t2. hoursworked is null
  order by t1.name;
  
-- case2) ���տ�����
select name
  from employee
  where empno not in( select distinct empno
                      from works );
                      
-- case3) ������
select name
from employee
where empno in (
      (select empno
        from employee
      minus
      select distinct empno
        from works));

-- case4) ��� ����
select t1.name
  from employee t1
  where not exists ( select *
                    from works
                    where empno = t1.empno );

-- �ڹ���11)
-- case 1)
select t1.*, rank() over(order by salary desc) as ����
  from employee t1
  fetch first 3 rows only;
-- case 2)
select t1.*, rownum as ����
  from ( select *
          from employee
          order by salary desc ) t1
  fetch first 3 rows only;

-- �ڹ���12)
select t3.deptname, t1.name, sum(t2.hoursworked) as ���ѽð�
  from employee t1 join works t2 on t1.empno = t2.empno
                  join department t3 on t1.deptno = t3.deptno
  group by t3.deptname, t1.name
  order by t3.deptname, t1.name;

-- �ڹ���13)
select t3.name, t3.salary
  from employee t3
  where t3.salary > 
              (select avg(t1.salary)
                from employee t1 join department t2 on t1.deptno = t2.deptno
                group by t2.deptno
                having t2.deptno = t3.deptno)
  order by t3.salary desc;

-- �ڹ���14)
select t1.projno, t1.projname, count(*) as "����� ��"
  from project t1 join works t2 on t1.projno = t2.projno
  group by t1.projno, t1.projname
  having count(*) >= 2
  order by t1.projno;

select t3.projno as "������Ʈ ��ȣ", t3.projname as "������Ʈ��", count(*) as "�����"
  from employee t1 join works t2 on t1.empno = t2.empno
                     join project t3 on t2.projno = t3.projno   
  where t3.projno in ( select projno
                          from works 
                          group by projno
                          having count(*) >= 2 )     
  group by  t3.projno, t3.projname;

-- �ڹ���15)
-- case 1) ������
select (select name from employee where empno = t1.empno) as �����, sum(t1.hoursworked) as �ð�
  from works t1
  group by empno
  having sum(hoursworked) = ( select max(sum(hoursworked))
                                from works
                                group by empno )
union
select (select name from employee where empno = t1.empno), sum(t1.hoursworked)
  from works t1
  group by empno
  having sum(hoursworked) = ( select min(sum(hoursworked))
                                from works
                                group by empno );

-- case 2) ���� ������
select (select name from employee where empno = t1.empno) as �����, sum(t1.hoursworked) as �ð�
  from works t1
  group by empno
  having sum(hoursworked) in ( ( select max(sum(hoursworked))
                                from works
                                group by empno ),
                                (select min(sum(hoursworked))
                                from works
                                group by empno));

-- �ڹ���16)
update employee
  set salary = salary * 1.1
  where empno in
    (select manager
      from department);

select * from employee;


-- �ڹ���17)
drop view project_vw;
create view project_vw as
select t1.name, t3.projname, t2.hoursworked
  from employee t1 join works t2 on t1.empno = t2.empno
                   join project t3 on t2.projno = t3.projno;
select * from project_vw;

-- �ڹ���18)
--drop index idx_employee_name;
-- �ε��� ����
create index idx_employee_name on employee(name);


