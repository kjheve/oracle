-- 외래키 삭제
alter table employee drop constraint employee_deptno_fk;
alter table department drop constraint department_manager_fk; 
alter table project drop constraint project_dept_deptno_fk;
alter table works drop constraint works_empno_fk;
alter table works drop constraint works_projno_fk;

-- 테이블 삭제
drop table works;
drop table project;
drop table employee;
drop table department;


--★문제1) 테이블 생성
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

-- ★제약조건
-- 문제2) 기본키
alter table department add constraint department_deptno_pk primary key(deptno);
alter table employee add constraint employee_empno_pk primary key(empno);
alter table project add constraint project_projno_pk primary key(projno);
alter table works add constraint works_projno_empno_pk primary key(projno, empno);

-- 문제3) 외래키
alter table employee add constraint employee_deptno_fk
                      foreign key (deptno) references department(deptno);

alter table department add constraint department_manager_fk
                      foreign key (manager) references employee(empno); -- ★☆★이거 안넣음..★☆★

alter table project add constraint project_dept_deptno_fk
                      foreign key (deptno) references department(deptno);

alter table works add constraint works_empno_fk
                      foreign key (empno) references employee(empno);
alter table works add constraint works_projno_fk
                      foreign key (projno) references project(projno);

-- 문제4) 도메인 제약조건
-- 1)
alter table employee add constraint employee_sex_ck check (sex in ('남', '여'));
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

-- ★문제5)
drop sequence employee_empno_seq;
create sequence employee_empno_seq start with 1001;


-- ★문제6) 샘플 데이터 생성
insert into department (deptno, deptname) values (10, '전산팀');
insert into department (deptno, deptname) values (20, '회계팀');
insert into department (deptno, deptname) values (30,'영업팀');
insert into department (deptno, deptname) values (40, '총무팀');
insert into department (deptno, deptname) values (50,'인사팀');

insert into project values (101, '빅데이터구축', 10);
insert into project values (102, 'IFRS', 20);
insert into project values (103, '마케팅', 30);

insert into employee values (employee_empno_seq.nextval,'홍길동1','010-111-1001','울산1','남','팀장',7000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동2','010-111-1002','울산2','남','팀원1',4000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동3','010-111-1003','울산3','남','팀원2',3000000,10);
insert into employee values (employee_empno_seq.nextval,'홍길동4','010-111-1004','부산1','여','팀장',6000000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동5','010-111-1005','부산2','남','팀원1',3500000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동6','010-111-1006','부산3','남','팀원2',2500000,20);
insert into employee values (employee_empno_seq.nextval,'홍길동7','010-111-1007','서울1','남','팀장',5000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동8','010-111-1008','서울2','남','팀원1',4000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동9','010-111-1009','서울3','남','팀원2',3000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동10',null,'서울4','남','팀원3',2000000,30);
insert into employee values (employee_empno_seq.nextval,'홍길동11','010-111-1011','대구1','여','팀장',5500000,40);
insert into employee values (employee_empno_seq.nextval,'홍길동12','010-111-1012','대구2','남','팀원1',2000000,40);
insert into employee values (employee_empno_seq.nextval,'홍길동13','010-111-1013','제주1','남','팀장',6500000,50);
insert into employee values (employee_empno_seq.nextval,'홍길동14','010-111-1014','제주2','남','팀원1',3500000,50);

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

update department set manager = 1001 where deptname = '전산팀';
update department set manager = 1004 where deptname = '회계팀';
update department set manager = 1007 where deptname = '영업팀';
update department set manager = 1011 where deptname = '총무팀';
update department set manager = 1013 where deptname = '인사팀';

commit;

select * from employee;
select * from department;
select * from project;
select * from works;


-- ★문제7)
select substr(name, 1, 1) as 성, count(*) as 인원수
  from employee
  group by substr(name, 1, 1);

-- ★문제8)
-- 보통 조인을 걸 때 레코드 수가 많은게 앞에
select t1.name,
      nvl2(t1.phoneno, -- 사워번호가
           substr(t1.phoneno, 1, 8) || '**' || substr(t1.phoneno, 11, 2), -- null이 아닐 때
           '연락처 없음') as 전화번호, -- null일 때
      t1.address
  from employee t1 join department t2 on t1.deptno = t2.deptno
  where t2.deptname = '영업팀';

-- ★문제9)
select count(*) as 팀원수
  from employee
  where deptno = (select deptno
                    from employee
                    where name = '홍길동7')
  and name <> '홍길동7';

select count(*) as 팀원수
  from employee t3
  where deptno = (select t1.deptno
                  from employee t1 join department t2 on t1.empno = t2.manager
                  where t1.name = '홍길동7')
    and name <> '홍길동7';

-- ★문제10)
-- case1) 외부조인
select t1.name
  from employee t1 left outer join works t2 on t1.empno = t2.empno
  where t2. hoursworked is null
  order by t1.name;
  
-- case2) 집합연산자
select name
  from employee
  where empno not in( select distinct empno
                      from works );
                      
-- case3) 차집합
select name
from employee
where empno in (
      (select empno
        from employee
      minus
      select distinct empno
        from works));

-- case4) 상관 쿼리
select t1.name
  from employee t1
  where not exists ( select *
                    from works
                    where empno = t1.empno );

-- ★문제11)
-- case 1)
select t1.*, rank() over(order by salary desc) as 순위
  from employee t1
  fetch first 3 rows only;
-- case 2)
select t1.*, rownum as 순위
  from ( select *
          from employee
          order by salary desc ) t1
  fetch first 3 rows only;

-- ★문제12)
select t3.deptname, t1.name, sum(t2.hoursworked) as 일한시간
  from employee t1 join works t2 on t1.empno = t2.empno
                  join department t3 on t1.deptno = t3.deptno
  group by t3.deptname, t1.name
  order by t3.deptname, t1.name;

-- ★문제13)
select t3.name, t3.salary
  from employee t3
  where t3.salary > 
              (select avg(t1.salary)
                from employee t1 join department t2 on t1.deptno = t2.deptno
                group by t2.deptno
                having t2.deptno = t3.deptno)
  order by t3.salary desc;

-- ★문제14)
select t1.projno, t1.projname, count(*) as "사원의 수"
  from project t1 join works t2 on t1.projno = t2.projno
  group by t1.projno, t1.projname
  having count(*) >= 2
  order by t1.projno;

select t3.projno as "프로젝트 번호", t3.projname as "프로젝트명", count(*) as "사원수"
  from employee t1 join works t2 on t1.empno = t2.empno
                     join project t3 on t2.projno = t3.projno   
  where t3.projno in ( select projno
                          from works 
                          group by projno
                          having count(*) >= 2 )     
  group by  t3.projno, t3.projname;

-- ★문제15)
-- case 1) 합집합
select (select name from employee where empno = t1.empno) as 사원명, sum(t1.hoursworked) as 시간
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

-- case 2) 집합 연산자
select (select name from employee where empno = t1.empno) as 사원명, sum(t1.hoursworked) as 시간
  from works t1
  group by empno
  having sum(hoursworked) in ( ( select max(sum(hoursworked))
                                from works
                                group by empno ),
                                (select min(sum(hoursworked))
                                from works
                                group by empno));

-- ★문제16)
update employee
  set salary = salary * 1.1
  where empno in
    (select manager
      from department);

select * from employee;


-- ★문제17)
drop view project_vw;
create view project_vw as
select t1.name, t3.projname, t2.hoursworked
  from employee t1 join works t2 on t1.empno = t2.empno
                   join project t3 on t2.projno = t3.projno;
select * from project_vw;

-- ★문제18)
--drop index idx_employee_name;
-- 인덱스 생성
create index idx_employee_name on employee(name);


