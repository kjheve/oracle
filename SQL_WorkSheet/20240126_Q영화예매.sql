--����: ��ȭ ���� �ý����� ���� �����ͺ��̽� SQL ���� �ۼ� �� Ȯ��
--
--��ǥ:
--SQL�� ����Ͽ� ��ȭ ���� �ý����� ���� �����ͺ��̽��� ���̺��� Ȯ���Ͽ� �����ϰ�, �����͸� �����ϴ� ������ �մϴ�.
--
--�⺻ �䱸����:
--1.��, ��ȭ, ����, ���� �� ���� ���̺��� �����մϴ�.
--2.�� ���̺��� ��ID, ����, ����ó, �̸���, ��������Ʈ �÷��� �־�� �մϴ�.
  -- ���� ����Ʈ�� �ʼ�, �⺻�� 0
--3.��ȭ ���̺��� ��ȭID, ����, ����, �帣, �󿵽ð�, ������ �÷��� �־�� �մϴ�.
--4.���� ���̺��� ����ID, ��ID, ��ȭID, ����ID, ������, �󿵽ð�, �¼� �÷��� �־�� �մϴ�.
--5.���� ���̺��� ����ID, �����, ��ġ, �����ο� �÷��� �־�� �մϴ�.
  -- �ִ� �����ο��� 300���� �ʰ����� �ʴ´�
--6.��� ���̺��� ������ ������ Ÿ���� ���� �ʿ��� �⺻ Ű(primary key)�� �ܷ� Ű(foreign key)�� �����ؾ� �մϴ�.
--7.�� ���̺� �ּ� 5�� �̻��� ���� �����Ͽ� �׽�Ʈ �����͸� �غ��մϴ�.
--
--��� �䱸���� (�߰� ���� �ο�):
-- -�ʿ��ϴٰ� �����Ǵ� ������, ��, �ε����� �����մϴ�.
--1.��ȭ ���̺��� ������ �÷��� ����Ͽ� ���� �� ���� ��ȭ�� ã�� ������ �ۼ��մϴ�.
--2.���� ���̺��� Ư�� ��ġ�� �ִ� ������ ã��, �ش� ���忡�� ���ϴ� ��ȭ ����� �������� ������ �ۼ��մϴ�.
--3.���� ���̺��� ����Ͽ� Ư�� ���� ���� ������ ������ ��ȭ�� ������ �Բ� �����ϴ� ������ �ۼ��մϴ�.
--4.����� ������ �����Ͽ�, �� ���庰�� ����� �¼� ���� ����ϴ� ������ �ۼ��մϴ�.
--5.���� �α� �ִ� ��ȭ �帣�� �����ϴ� ������ �ۼ��մϴ�. (��: ���� �� ����)
--6.���� �������� �ʿ���ϴ� �������� 3�� �ۼ��մϴ�. (SQL���� �ƴ� �ѱ����ǹ�)


-- ���̺� ����
drop table booking;
drop table mcustomers;
drop table movie;
drop table theater;


-- �ڡڡ� ���̺� ����
-- ��
create table mcustomers(
  customer_id      number(3),
  customername     varchar2(15),
  tel              varchar2(13),
  email            varchar2(60),
  point            number(6)
);

-- ��ȭ
create table movie (
  movie_id    number(3),
  title       varchar2(30),
  director    varchar2(20),
  genre       varchar2(10),
  runningtime number(3),
  releasedate date
);

-- ����
create table booking(
    booking_id  number(3),
    customer_id number(3),
    movie_id    number(3),
    theater_id  number(3),
    bookingday  date,
    runningtime number(3),
    seat        number(3)
);

-- ����
create table theater (
  theater_id      number(3),
  nameoftheater   varchar2(30),
  loc             varchar2(10),
  numocc          varchar2(10)
);


-- =:]> �������� <:[=
-- �ڡڡڱ⺻Ű(primary key) ��������
alter table mcustomers add constraint customer_pk primary key(customer_id);
alter table movie add constraint movie_pk primary key(movie_id);
alter table booking add constraint booking_pk primary key(booking_id);
alter table theater add constraint theater_pk primary key(theater_id);
-- �ڡڡڿܷ�Ű(foreign key) ��������
alter table booking add constraint customer_fk foreign key (customer_id) references mcustomers;
alter table booking add constraint movie_fk foreign key (movie_id) references movie;
alter table booking add constraint theater_fk foreign key (theater_id) references theater;


-- �ڡڡ�NOT NULL
-- ��
alter table mcustomers modify customer_id not null;
alter table mcustomers modify customername not null;
alter table mcustomers modify tel not null;

-- ��ȭ
alter table movie modify title not null;
alter table movie modify director not null;
alter table movie modify genre not null;
alter table movie modify runningtime not null;
alter table movie modify releasedate not null;

-- ����
alter table booking modify bookingday not null;
alter table booking modify runningtime not null;
alter table booking modify seat not null;

-- ����
alter table theater modify nameoftheater not null;
alter table theater modify loc not null;
alter table theater modify numocc not null;

-- �ڡڡ�üũ �������� �߰�
ALTER TABLE movie ADD CONSTRAINT movie_CK CHECK (genre IN ('COMEDY', 'ROMANTIC', 'ACTION', 'HORROR', 'MYSTERY'));

-- �ڡڡ�UNIQUE �������� �߰�
alter table booking add constraint booking_uk unique(seat);

-- �ڡڡ� DEFAULT ��������
alter table movie modify runningtime DEFAULT 0;
alter table booking modify runningtime DEFAULT 0;


-- �ڡڡڽ����� ����
drop sequence mcustomers_customer_id;
drop sequence movie_movie_id;
drop sequence booking_booking_id;
drop sequence theater_theater_id;

-- �ڡڡڽ����� ����
create sequence mcustomers_customer_id;
create sequence movie_movie_id;
create sequence booking_booking_id;
create sequence theater_theater_id;



-- �ڡڡڻ��õ�����
-- ��
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'��ź�ҳ��','010-1234-5678','bangtan@gmail.com',8584);
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'������','010-9876-5432','txt@naver.com',5462);
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'���̺�','010-1122-3344',null,266);
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'Ʈ���̽�','010-5566-7788','twice@gmail.com',null);
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'������','010-2468-5678','iu133@hatmail.com',15);

-- ��ȭ
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '�ظ����Ϳ� ȥ�� ����', '���̺� ������', 'HORROR', 153, to_date('2009/07/15', 'YY/MM/DD'));
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '������ ��', '�輺��', 'ACTION', 141, to_date('2023/11/12', 'YY/MM/DD'));
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '����', 'ũ���� ��', 'COMEDY', 95, to_date('2024/01/03', 'YY/MM/DD'));
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '�ܰ�+�� 2��', '�ֵ���', 'ACTION', 122, to_date('2024/01/10', 'YY/MM/DD'));
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '�ùδ���', '�ڿ���', 'MYSTERY', 114, to_date('2024/01/24', 'YY/MM/DD'));

-- ����
insert into booking (booking_id, customer_id, movie_id, theater_id, bookingday, runningtime, seat)
            values (booking_booking_id.nextval, 1, 2, 3, to_date('2015-03-15','yy-mm-dd'), 141, 111);
insert into booking (booking_id, customer_id, movie_id, theater_id, bookingday, runningtime, seat)
            values (booking_booking_id.nextval, 2, 5, 4, to_date('2022-01-30','yy-mm-dd'), 114, 222);
insert into booking (booking_id, customer_id, movie_id, theater_id, bookingday, runningtime, seat)
            values (booking_booking_id.nextval, 3, 4, 2, to_date('1999-10-04','yy-mm-dd'), 122,333);
insert into booking (booking_id, customer_id, movie_id, theater_id, bookingday, runningtime, seat)
            values (booking_booking_id.nextval, 4, 2, 1, to_date('2023-6-13','yy-mm-dd'), 141, 444);
insert into booking (booking_id, customer_id, movie_id, theater_id, bookingday, runningtime, seat)
            values (booking_booking_id.nextval, 2, 4, 5, to_date('2011-04-14','yy-mm-dd'), 122, 555); 
insert into booking (booking_id, customer_id, movie_id, theater_id, bookingday, runningtime, seat)
            values (booking_booking_id.nextval, 2, 3, 5, to_date('2011-04-14','yy-mm-dd'), 122, 666);

-- ����
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, 'CGV', '���', 100);
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, '�ް��ڽ�', '�λ�', 200);
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, '�Ե��ó׸�', '����', 200);
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, 'CGV', '����', 150);
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, '�Ե��ó׸�', '��õ', 180);
            
update booking t1
    set runningtime  = (select t2.runningtime
                         from movie t2
                         where t1.movie_id = t2.movie_id);


-- �ε��� ����
drop index mcustomer_customername_idx
drop index movie_title_idx
drop index booking_seat_idx
drop index theater_nameoftheater_idx
-- �ڡڡ��ε��� ����
--create index �ε��� �̸� on ���̺��(�÷���)
create index mcustomer_customername_idx on mcustomer(customername);
create index movie_title_idx on movie(title);
create index booking_seat_idx on booking(seat);
create index theater_nameoftheater_idx on theater(nameoftheater);


-- �� ����
drop view mcustomer_booking_info_vw;
-- �ڡڡں� ����
-- ���� ������ ��ȭ�� ���೯¥�� �¼�, �����
create view mcustomer_booking_info_vw as
   select t1.customer_id AS ��ID, t1.customername AS ����, t1.tel AS ������ó,
          t3.title AS ��ȭ����, t3.director AS ��ȭ����, t3.genre AS ��ȭ�帣, t3.runningtime AS �󿵽ð�, t3.releasedate AS ������,
          t2.bookingday AS ������, t2.seat AS �¼���ȣ,
          t4.nameoftheater AS �����, t4.loc AS ��ġ
  from mcustomers t1 left outer join booking t2 on t1.customer_id = t2.customer_id
                    left outer join movie t3 on t2.movie_id = t3.movie_id
                    left outer join theater t4 on t2.theater_id = t4.theater_id;

select * from mcustomer_booking_info_vw;




--2.��ȭ ���̺��� ������ �÷��� ����Ͽ� ���� �� ���� ��ȭ�� ã�� ������ �ۼ��մϴ�.
select *
  from movie
  where releasedate <= sysdate;

--3.���� ���̺��� Ư�� ��ġ�� �ִ� ������ ã��, �ش� ���忡�� ���ϴ� ��ȭ ����� �������� ������ �ۼ��մϴ�.
select t1.loc, t3.title
  from theater t1 left outer join booking t2 on t1.theater_id = t2.theater_id
                  join movie t3 on t2.movie_id = t3.movie_id;
  
--4.���� ���̺��� ����Ͽ� Ư�� ���� ���� ������ ������ ��ȭ�� ������ �Բ� �����ϴ� ������ �ۼ��մϴ�.


--5.����� ������ �����Ͽ�, �� ���庰�� ����� �¼� ���� ����ϴ� ������ �ۼ��մϴ�.
select t2.nameoftheater, count(t2.nameoftheater) "����� �¼� ��"
  from booking t1 join theater t2 on t1.theater_id = t2.theater_id
group by t2.nameoftheater;

--6.���� �α� �ִ� ��ȭ �帣�� �����ϴ� ������ �ۼ��մϴ�. (��: ���� �� ����)
select genre
from mcustomer_booking_info_vw
group by genre
having count(genre) >=all(select count(genre)
                          from mcustomer_booking_info_vw
                          group by genre);
                          
                          
-------------------------------------------------------------------------------
--SELECT genre
--  FROM movie
--  WHERE genre IN (SELECT MAX(t1.genre)
--                  FROM movie t1 JOIN booking t2 ON t1.movie_id = t2.movie_id
--                  GROUP BY t1.genre);
---- --------------------------------
--select ��ȭ�帣, count(��ȭ�帣) AS ���ż�
--from (select t1.customer_id AS ��ID, t1.customername AS ����, t1.tel AS ������ó,
--          t3.title AS ��ȭ����, t3.director AS ��ȭ����, t3.genre AS ��ȭ�帣, t3.runningtime AS �󿵽ð�, t3.releasedate AS ������,
--          t2.bookingday AS ������, t2.seat AS �¼���ȣ,
--          t4.nameoftheater AS �����, t4.loc AS ��ġ
--       from mcustomers t1 join booking t2 on t1.customer_id = t2.customer_id
--                    join movie t3 on t2.movie_id = t3.movie_id
--                    join theater t4 on t2.theater_id = t4.theater_id)
--  group by ��ȭ�帣
--  order by ���ż� desc;
  -- --------------------------------
  

--7.���� �������� �ʿ���ϴ� �������� 3�� �ۼ��մϴ�. (SQL���� �ƴ� �ѱ����ǹ�)
