-- ������(sequence) �����ϱ� :)

-- EMP ���̺� ���� EMP2�� ����
CREATE TABLE EMP2
  AS SELECT * FROM EMP
      WHERE 1 <> 1;
-- EMP2 ���̺� ���� Ȯ��
DESC EMP2;
SELECT * FROM EMP2;

-- ������ ����
create sequence emp2_empno_seq;

-- ������ ��ȣ ����
select emp2_empno_seq.nextval
  from dual;

-- ���� ������ ��ȣ Ȯ��
--(���� ���������� ������ ������ Ȯ���ϱ�)
select emp2_empno_seq.currval
  from dual;
  
  
-- p.327 �����ͻ���
select * from dict;

select *
  from user_tables;
  
select *
  from all_tables;