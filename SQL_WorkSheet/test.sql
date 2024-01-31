-- 테이블 삭제
drop table works;
drop table project;
drop table employee;
drop table department;



-- ★1. 테이블 생성
--사원
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

--부서
create table department(
  deptno    number(2),
  deptname  varchar2(9),
  manager   number(4)
);

-- 프로젝트
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


-- ★2. 기본키 추가
alter table employee add constraint employee_empno_pk
                      primary key(empno);
alter table department add constraint department_deptno_pk
                      primary key(deptno);
alter table project add constraint project_projno_pk
                      primary key(projno);
alter table works add constraint works_pk
                      primary key(empno, projno);

-- ★3. 외래키 추가
alter table employee add constraint employee_deptno_fk
                      foreign key (deptno) references department;
                                       
alter table project add constraint project_dept_deptno_fk
                      foreign key (deptno) references department;

alter table works add constraint works_empno_fk
                      foreign key (empno) references employee;
alter table works add constraint works_projno_fk
                      foreign key (projno) references project;

-- ★4. 도메인 제약조건 추가
-- 4.1 
alter table employee add constraint employee_sex_ck check (sex in ('남', '여'));
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

-- ★5. 기본키에 시퀀스를 적용(사원만)
drop sequence empno_seq;
create sequence empno_seq
increment by 1
start with 1001;


-- ★6. 데이터를 삽입하는 insert문을 작성하고 저장된 결과를 보이시오
-- department
insert into department values(10, '전산팀', 1001);
insert into department values(20, '회계팀', 1004);
insert into department values(30, '영업팀', 1007);
insert into department values(40, '총무팀', 1011);
insert into department values(50, '인사팀', 1013);

select * from department;

-- project
insert into project values(101, '빅데이터구축', 10);
insert into project values(102, 'IFRS', 20);
insert into project values(103, '마케팅', 30);

select * from project;

-- employee
insert into employee
  values (empno_seq.nextval, '홍길동1', '010-111-1001', '울산1', '남', '팀장', 7000000, 10);
insert into employee
  values (empno_seq.nextval, '홍길동2', '010-111-1002', '울산2', '남', '팀원1', 4000000, 10);
insert into employee
  values (empno_seq.nextval, '홍길동3', '010-111-1003', '울산3', '남', '팀원2', 3000000, 10);
insert into employee
  values (empno_seq.nextval, '홍길동4', '010-111-1004', '부산1', '여', '팀장', 6000000, 20);
insert into employee
  values (empno_seq.nextval, '홍길동5', '010-111-1005', '부산2', '남', '팀원1', 3500000, 20);
insert into employee
  values (empno_seq.nextval, '홍길동6', '010-111-1006', '부산3', '남', '팀원2', 2500000, 20);
insert into employee
  values (empno_seq.nextval, '홍길동7', '010-111-1007', '서울1', '남', '팀장', 5000000, 30);
insert into employee
  values (empno_seq.nextval, '홍길동8', '010-111-1008', '서울2', '남', '팀원1', 4000000, 30);
insert into employee
  values (empno_seq.nextval, '홍길동9', '010-111-1009', '서울3', '남', '팀원2', 3000000, 30);
insert into employee
  values (empno_seq.nextval, '홍길동10', null, '서울4', '남', '팀원3', 2000000, 30);
insert into employee
  values (empno_seq.nextval, '홍길동11', '010-111-1011', '대구1', '여', '팀장', 5500000, 40);
insert into employee
  values (empno_seq.nextval, '홍길동12', '010-111-1012', '대구2', '남', '팀원1', 2000000, 40);
insert into employee
  values (empno_seq.nextval, '홍길동13', '010-111-1013', '제주1', '남', '팀장', 6500000, 50);
insert into employee
  values (empno_seq.nextval, '홍길동14', '010-111-1014', '제주2', '남', '팀원1', 3500000, 50);

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



-- ★7. 사원 중 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
select substr(name, 1, 1) as "Family_Name",
       count(*) as "cnt"
  from employee
  group by substr(name, 1, 1);

-- ★8. '영업팀' 부서에서 일하는 사원의 이름, 연락처, 주소를 보이시오.
-- 연락처가 없으면 연락처 없음 표기, 연락처 끝4자리 중 앞2자리는 별표 * 로 표기
select t1.name,
      case
        when t1.phoneno is null then '연락처 없음'
        else concat(rpad(substr(t1.phoneno, 1, 8), 10, '*'), substr(t1.phoneno, 11, 2))
        end as phoneno,
      t1.address
  from employee t1 join department t2 on t1.deptno = t2.deptno
  where t2.deptname = '영업팀';
  
-- ★9. 홍길동7 팀장 부서에서 일하는 팀원의 수를 보이시오.
select count(*) as "팀원의 수"
  from employee
  where deptno = 30;

-- ★10. 프로젝트에 참여하지 않은 사원의 이름을 보이시오.
select t1.name
  from employee t1 left outer join works t2 on t1.empno = t2.empno
  where t2. hoursworked is null
  order by t1.name;

-- ★11. 급여 상위 TOP 3를 순위와 함께 보이시오.
select name, salary, rank() over(order by salary desc) as 순위
  from employee
  fetch first 3 rows only;

-- ★12. 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순으로 보이시오.
select t3.deptname, t1.name, t2.hoursworked
  from employee t1 join works t2 on t1.empno = t2.empno
                  join department t3 on t1.deptno = t3.deptno
  group by t3.deptname, t1.name, t2.hoursworked
  order by t3.deptname, t1.name desc;

-- ★13. 부서별로 급여가 부서평균 급여 보다 높은 사원의 이름과 월급을 보이시오.
select t2.deptname, t1.name , t1.salary
  from employee t1 join department t2 on t1.deptno = t2.deptno
  where t1.salary > (select round(avg(salary), 2)
                      from employee t3
                      where t1.deptno = t3.deptno
                      group by t3.deptno)
  order by t1.salary desc;
  
-- ★14. 2명 이상의 사원이 참여한 프로젝트의 번호, 프로젝트명, 사원의 수를 보이시오.
select t1.projno, t1.projname, count(*) as "사원의 수"
  from project t1 join works t2 on t1.projno = t2.projno
  group by t1.projno, t1.projname
  having count(*) >= 2
  order by t1.projno;

-- ★15. 프로젝트에 참여시간이 가장 많은 사원과 적은 사원의 이름을 보이시오.
select t3.name as "가장 많은 사원", t3.MAX as 많은시간,
       t4.name as "가장 적은 사원", t4.MIN as 적은시간
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
  
-- ★16. 팀장의 급여를 10% 인상하고 인상된 결과를 보이시오 (단, department 테이블을 활용할 것)
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
  
-- ★17. 사원이 참여한 프로젝트에 대해 사원명, 프로젝트명, 참여시간을 보이는 뷰를 작성하시오.
-- 뷰 제거
drop view project_empinfo_vw;
-- 뷰 생성
create view project_empinfo_vw as
select t1.name, t3.projname, t4.hoursworked
  from employee t1 join department t2 on t1.deptno = t2.deptno
                  join project t3 on t1.deptno = t3.deptno
                  join works t4 on t1.empno = t4.empno and t3.projno = t4.projno;
                  
-- ★18. employee 테이블의 name 열을 대상으로 인덱스를 생성하시오.
-- (단, 인덱스명은 idx_employee_name)
-- 인덱스 제거
--drop index idx_employee_name;
-- 인덱스 생성
create index idx_employee_name on employee(name);







