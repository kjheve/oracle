-- 한줄 주석
/* 여러줄 주석 */
desc emp;
desc dept;
desc salgrade;

--전체 조회
select *
    from emp;
    
--일부 컬럼 조회
select empno, ename
    from emp;
    
-- 컬럼 헤더에 별칭 주기
select empno as "사원번호", ename as "사원명" from emp; -- 별칭은 쌍따옴표로 감싼다.
select empno "사원번호", ename "사원명" from emp; -- as는 생략 가능

-- 중복제거 (default는 all)
select distinct deptno from emp;

-- (교재P.84) 열과 연산식
select ename, sal, sal*12 as "연봉",
                   sal*12+comm as "연봉+추가수당"
    from emp;
    
-- null 함수를 사용하여 null이면 0값을 넣음
-- nvl(숫자1, 숫자2) : 숫자1이 null이면 숫자2로 표기 아니면 숫자1
select ename as 사원명,
        sal as 월급,
        sal*12 as "연봉",
        sal*12+nvl(comm, 0) as "연봉+추가수당"
    from emp;

-- 정렬 : asc(기본값), desc
select ename as 사원명,
        sal as 월급,
        sal*12 as "연봉",
        (sal*12)+nvl(comm,0) as "연봉+추가수당"
    from emp
order by (sal*12)+nvl(comm,0) desc, ename desc;

-- 레코드 필터링
select *
    from emp
--    where sal >= 2000 and sal <= 3000;
    where sal between 2000 and 3000; -- 같은 의미 다른표현
--not 연산자
select *
    from emp
    where not sal = 3000;
--in 연산자
select *
    from emp
    where sal in(3000, 5000);
    
-- LIKE 연산자
select *
    from emp
    where ename like 'A%';
select *
    from emp
    where ename like '_L%';
    
--더미 테이블 dual
select 1+1, 3-4, 5*6, 10/2, mod(10, 4) from dual;

--null 비교
select *
    from emp
    where comm is null;
    
    
    