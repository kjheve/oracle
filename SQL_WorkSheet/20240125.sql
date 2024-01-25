-- 트랜잭션실습
-- 세션1
-- 세션2는 Cmder에서

select * from emp;

select * from emp where empno = '8000';

update emp
set sal = 6000
where empno = 8000;

commit;