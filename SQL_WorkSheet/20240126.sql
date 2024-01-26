-- 시퀀스(sequence) 연습하기 :)

-- EMP 테이블 구조 EMP2로 복사
CREATE TABLE EMP2
  AS SELECT * FROM EMP
      WHERE 1 <> 1;
-- EMP2 테이블 구조 확인
DESC EMP2;
SELECT * FROM EMP2;

-- 시퀀스 생성
create sequence emp2_empno_seq;

-- 시퀀스 번호 생성
select emp2_empno_seq.nextval
  from dual;

-- 현재 시퀀스 번호 확인
--(가장 마지막으로 생성된 시퀀스 확인하기)
select emp2_empno_seq.currval
  from dual;
  
  
-- p.327 데이터사전
select * from dict;

select *
  from user_tables;
  
select *
  from all_tables;