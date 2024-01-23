-- 1. EMP 테이블과 DEPT 테이블을 등가조인해서 사원 이름과 해당 사원의 부서 이름을 출력하시오.

-- case 1) natural join : 테이블간에 공통된 컬럼명과 자료형이 같은 열을 자동으로 찾아 조인
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
  
-- case 1~3 ) SQL-99표기법 : 모든 관계형 데이터 베이스에 동일한 문법이 적용됨.

-- case 4) where절에 조건식 추가
select t1.ename, t2.dname
  from emp t1, dept t2
  where t1.deptno = t2.deptno;

  
-- 2. EMP 테이블과 DEPT 테이블을 외부조인해서 사원 이름과 해당 사원의 부서 이름을 출력하시오.
-- 부서가 없는 사원도 포함하시오.

-- case 1) SQL-99 표기법
select t1.ename, t2.dname
  from emp t1 left outer join dept t2
  on t1.deptno = t2.deptno;
-- case 2) Oracle만 가능한 표현법
select t1.ename, t2.dname
  from emp t1, dept t2
  where t1.deptno = t2.deptno(+);
  

-- 3. EMP 테이블과 SALGRADE 테이블을 비등가조인해서 사원 이름과 해당 사원의 급여 등급을 출력하시오.

select t1.ename AS 사원이름, t2.grade AS 급여등급
  from emp t1 join salgrade t2
  on t1.sal between losal and hisal
  order by 급여등급;

select t1.ename AS 사원이름, t2.grade AS 급여등급
  from emp t1, salgrade t2
  where t1.sal between losal and hisal;


-- 4. EMP 테이블과 SALGRAD 테이블을 외부조인해서 사원 이름과 해당 사원의 급여 등급을 출력하시오.
-- 급여 등급이 없는 사원도 포함하시오. (급여등급이 없는 사람이 없는데..?)

select t1.ename AS 사원이름, t2.grade AS 급여등급
  from emp t1 left outer join salgrade t2
  on t1.sal between losal and hisal
  order by 급여등급;
  
select t1.ename AS 사원이름, t2.grade AS 급여등급
  from emp t1, salgrade t2
  where t1.sal between losal and hisal(+)
  order by 급여등급 desc;


-- 5. EMP 테이블과 DEPT 테이블을 등가조인해서 전체 사원의 평균 급여를 부서별로 출력하시오.

select t1.deptno AS 부서번호, t2.dname AS 부서명,
round(avg(sal), 2) AS "평균 급여"
  from emp t1 join dept t2
  on t1.deptno = t2.deptno
  group by t1.deptno, t2.dname
  order by 부서명;


-- 6. EMP 테이블과 DEPT 테이블을 외부조인해서 전체 사원의 평균 급여를 부서별로 출력하시오.
-- 부서가 없는 사원도 포함하시오.

select t1.deptno, t2.dname, round(avg(sal), 2)
  from emp t1 left outer join dept t2
  on t1.deptno = t2.deptno
  group by t1.deptno, t2.dname
  order by t1.deptno;
  

-- 7. EMP 테이블과 DEPT 테이블을 등가조인해서 사원 수가 5명 이상인 부서의 부서 이름과 사원 수를 출력하시오.

select t2.dname, COUNT(t2.dname)
  from emp t1 join dept t2
  on t1.deptno = t2.deptno
  group by t2.dname
  having COUNT(t2.dname) >= 5;
  

-- 8. EMP 테이블과 DEPT 테이블을 외부조인해서 사원 수가 5명 이상인 부서의 부서 이름과 사원 수를 출력하시오.
-- 부서가 없는 사원도 포함하시오. (부서가 없는 인원이 5명이 안넘어서 -> 보일려면 having을 주석처리 해야함)

select t2.dname, COUNT(t2.dname)
  from emp t1 left outer join dept t2
  on t1.deptno = t2.deptno
  group by t2.dname;
--  having COUNT(t2.dname) >= 5;


-- 9. emp 테이블과 bonus 테이블을 등가조인해서 사원 이름과 보너스를 출력하시오.

select t1.ename, t2.sal+t2.comm AS "보너스"
  from emp t1 join bonus t2
  on t1.ename = t2.ename;


-- 10. emp 테이블과 bonus 테이블을 외부조인해서 사원 이름과 보너스를 출력하시오.
-- 보너스를 받지 못한 사원도 포함하시오.
-- (보너스 테이블의 데이터가 없다면 맨 밑에 INSERT문을 실행 하시오)

select t1.ename, t2.sal+t2.comm AS "보너스"
  from emp t1 left outer join bonus t2
  on t1.ename = t2.ename;


--11. EMP 테이블을 셀프 조인해서 같은 부서에서 일하는 사원들의 이름을 출력하시오.
 
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


--12. EMP 테이블을 셀프 조인해서 자신보다 더 많은 급여를 받는 사원들의 이름을 출력하시오.

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
--ROLLBACK; --데이터를 잘못 넣었을 경우 롤백