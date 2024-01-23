-- >>>>>>>>>>>>>>>>> JOIN <<<<<<<<<<<<<<<<<<

--1. 등가조인(equal join) : t1 join t2 on 조인조건
--   ex) 사원이 소속된 부서명
--2. 비등가조인(non-equal join)
--3. 자체조인(self join) : 참조하고자 하는 컬럼이 자신의 테이블에 있을 때
--   ex) 사원의 관리자명
--5. 외부조인(outer join) :
--  t1 left outer join t2 on 조인조건
--   ex) 사원이 소속된 부서명(부서가 없는 사원 보이기)
--
--  t1 right outer join t2 on 조인조건
--   ex) 부서에 소속된 사원(사원이 없는 부서도 보이게)
--
--  t1 full outer join t2 on 조인조건
--   ex) 사원이 소속된 부서명(부서가 없는 사원보이게, 사원이 없는 부서도 보이게)


-- FROM절에 여러 테이블 선언하기
SELECT *
  FROM EMP, DEPT;
  
-- 열 이름을 비교하는 조건식으로 조인하기
-- innder join(내부조인) : 같은 속성이 존재하고 속성값이 같은 행만 추출하고자 할 때
-- 등가조인(equal join) ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
SELECT *
  FROM EMP, DEPT
  WHERE EMP.DEPTNO = DEPT.DEPTNO
  ORDER BY EMP.DEPTNO;
  
  SELECT *
  FROM DEPT, EMP
  WHERE DEPT.DEPTNO = EMP.DEPTNO
  ORDER BY DEPT.DEPTNO;
  
-- 테이블 별칭주기
select t1.*, t2.* -- * 로도 사용가능
  from emp t1, dept t2
  where t1.deptno = t2.deptno
  order by t1.deptno;
  
-- 비등가 조인 p.224 ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
select *
  from emp t1, salgrade t2
  where t1.sal BETWEEN t2.losal AND t2.hisal;
  
-- 자체 조인 p.227 ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
select t1.empno, t1.ename, t1.mgr,
       t2.empno AS MGR_EMPNO, t2.ename AS MGR_ENAME
  from emp t1, emp t2
  where t1.mgr = t2.empno;
  
-- 계층 쿼리 (CONNECT_BY_ROOT)
SELECT LPAD(' ', 4*(LEVEL-1)) || ename ename, empno,
CONNECT_BY_ROOT  empno "Root empno", level
  FROM emp
 START WITH job='PRESIDENT'
CONNECT BY PRIOR empno=mgr;
-- 계층쿼리 SYS_CONNECT_BY_PATH 예제
SELECT LPAD(' ', 4*(LEVEL-1)) || ename ename, empno,
       SYS_CONNECT_BY_PATH(ename, '/') "PATH"
  FROM emp
 START WITH job='PRESIDENT'
CONNECT BY PRIOR empno=mgr;

-- 외부 조인(outer join) ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

--Insert into emp values(8000, 'GILDONG', 'CLERK', null, to_date(sysdate), 4000, null, null);
--commit;
--select * from emp;
--insert into dept values(50, 'HUMANRESOURCES', 'LA');
--select * from dept;

-- 왼쪽 외부 조인(Left Outer Join) : 모든속성을 보여주는 기준 테이블이 왼쪽
-- 오른쪽 외부 조인(Left Outer Join) : 모든속성을 보여주는 기준 테이블이 오른쪽
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
  
-- case 2) ------------------- 위에 같은 경우는 Oracle만 사용 가능
select t1.ename, t2.dname
  from emp t1 inner join dept t2 -- (inner는 생략가능)
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
  