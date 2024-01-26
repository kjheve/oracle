--과제: 영화 예약 시스템을 위한 데이터베이스 SQL 쿼리 작성 및 확장
--
--목표:
--SQL을 사용하여 영화 예약 시스템을 위한 데이터베이스의 테이블을 확장하여 설계하고, 데이터를 쿼리하는 연습을 합니다.
--
--기본 요구사항:
--1.고객, 영화, 예약, 극장 네 개의 테이블을 생성합니다.
--2.고객 테이블에는 고객ID, 고객명, 연락처, 이메일, 적립포인트 컬럼이 있어야 합니다.
  -- 적립 포인트는 필수, 기본값 0
--3.영화 테이블에는 영화ID, 제목, 감독, 장르, 상영시간, 개봉일 컬럼이 있어야 합니다.
--4.예약 테이블에는 예약ID, 고객ID, 영화ID, 극장ID, 예약일, 상영시간, 좌석 컬럼이 있어야 합니다.
--5.극장 테이블에는 극장ID, 극장명, 위치, 수용인원 컬럼이 있어야 합니다.
  -- 최대 수용인원은 300명을 초과하지 않는다
--6.모든 테이블은 적절한 데이터 타입을 가진 필요한 기본 키(primary key)와 외래 키(foreign key)를 설정해야 합니다.
--7.각 테이블에 최소 5개 이상의 행을 삽입하여 테스트 데이터를 준비합니다.
--
--고급 요구사항 (추가 점수 부여):
-- -필요하다고 생각되는 시퀀스, 뷰, 인덱스를 생성합니다.
--1.영화 테이블의 개봉일 컬럼을 사용하여 현재 상영 중인 영화를 찾는 쿼리를 작성합니다.
--2.극장 테이블에서 특정 위치에 있는 극장을 찾고, 해당 극장에서 상영하는 영화 목록을 가져오는 쿼리를 작성합니다.
--3.예약 테이블을 사용하여 특정 고객의 예약 내역과 예약한 영화의 정보를 함께 제공하는 쿼리를 작성합니다.
--4.예약과 극장을 조인하여, 각 극장별로 예약된 좌석 수를 계산하는 쿼리를 작성합니다.
--5.가장 인기 있는 영화 장르를 결정하는 쿼리를 작성합니다. (예: 예약 수 기준)
--6.위의 쿼리말고 필요로하는 쿼리문을 3건 작성합니다. (SQL문이 아닌 한글질의문)


-- 테이블 제거
drop table booking;
drop table mcustomers;
drop table movie;
drop table theater;


-- ★★★ 테이블 생성
-- 고객
create table mcustomers(
  customer_id      number(3),
  customername     varchar2(15),
  tel              varchar2(13),
  email            varchar2(60),
  point            number(6)
);

-- 영화
create table movie (
  movie_id    number(3),
  title       varchar2(30),
  director    varchar2(20),
  genre       varchar2(10),
  runningtime number(3),
  releasedate date
);

-- 예약
create table booking(
    booking_id  number(3),
    customer_id number(3),
    movie_id    number(3),
    theater_id  number(3),
    bookingday  date,
    runningtime number(3),
    seat        number(3)
);

-- 극장
create table theater (
  theater_id      number(3),
  nameoftheater   varchar2(30),
  loc             varchar2(10),
  numocc          varchar2(10)
);


-- =:]> 제약조건 <:[=
-- ★★★기본키(primary key) 제약조건
alter table mcustomers add constraint customer_pk primary key(customer_id);
alter table movie add constraint movie_pk primary key(movie_id);
alter table booking add constraint booking_pk primary key(booking_id);
alter table theater add constraint theater_pk primary key(theater_id);
-- ★★★외래키(foreign key) 제약조건
alter table booking add constraint customer_fk foreign key (customer_id) references mcustomers;
alter table booking add constraint movie_fk foreign key (movie_id) references movie;
alter table booking add constraint theater_fk foreign key (theater_id) references theater;


-- ★★★NOT NULL
-- 고객
alter table mcustomers modify customer_id not null;
alter table mcustomers modify customername not null;
alter table mcustomers modify tel not null;

-- 영화
alter table movie modify title not null;
alter table movie modify director not null;
alter table movie modify genre not null;
alter table movie modify runningtime not null;
alter table movie modify releasedate not null;

-- 예약
alter table booking modify bookingday not null;
alter table booking modify runningtime not null;
alter table booking modify seat not null;

-- 극장
alter table theater modify nameoftheater not null;
alter table theater modify loc not null;
alter table theater modify numocc not null;

-- ★★★체크 제약조건 추가
ALTER TABLE movie ADD CONSTRAINT movie_CK CHECK (genre IN ('COMEDY', 'ROMANTIC', 'ACTION', 'HORROR', 'MYSTERY'));

-- ★★★UNIQUE 제약조건 추가
alter table booking add constraint booking_uk unique(seat);

-- ★★★ DEFAULT 제약조건
alter table movie modify runningtime DEFAULT 0;
alter table booking modify runningtime DEFAULT 0;


-- ★★★시퀀스 제거
drop sequence mcustomers_customer_id;
drop sequence movie_movie_id;
drop sequence booking_booking_id;
drop sequence theater_theater_id;

-- ★★★시퀀스 생성
create sequence mcustomers_customer_id;
create sequence movie_movie_id;
create sequence booking_booking_id;
create sequence theater_theater_id;



-- ★★★샘플데이터
-- 고객
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'방탄소년단','010-1234-5678','bangtan@gmail.com',8584);
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'투바투','010-9876-5432','txt@naver.com',5462);
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'아이브','010-1122-3344',null,266);
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'트와이스','010-5566-7788','twice@gmail.com',null);
insert into mcustomers (customer_id,customername,tel,email,point )
             values (mcustomers_customer_id.nextval,'아이유','010-2468-5678','iu133@hatmail.com',15);

-- 영화
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '해리포터와 혼혈 왕자', '데이빗 예이츠', 'HORROR', 153, to_date('2009/07/15', 'YY/MM/DD'));
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '서울의 봄', '김성수', 'ACTION', 141, to_date('2023/11/12', 'YY/MM/DD'));
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '위시', '크리스 벅', 'COMEDY', 95, to_date('2024/01/03', 'YY/MM/DD'));
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '외계+인 2부', '최동훈', 'ACTION', 122, to_date('2024/01/10', 'YY/MM/DD'));
insert into movie (movie_id, title, director, genre, runningtime, releasedate)
             values(movie_movie_id.nextval, '시민덕희', '박영주', 'MYSTERY', 114, to_date('2024/01/24', 'YY/MM/DD'));

-- 예약
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

-- 극장
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, 'CGV', '울산', 100);
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, '메가박스', '부산', 200);
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, '롯데시네마', '서울', 200);
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, 'CGV', '대전', 150);
insert into theater (theater_id, nameoftheater,loc,numocc)
            values (theater_theater_id.nextval, '롯데시네마', '인천', 180);
            
update booking t1
    set runningtime  = (select t2.runningtime
                         from movie t2
                         where t1.movie_id = t2.movie_id);


-- 인덱스 제거
drop index mcustomer_customername_idx
drop index movie_title_idx
drop index booking_seat_idx
drop index theater_nameoftheater_idx
-- ★★★인덱스 생성
--create index 인덱스 이름 on 테이블명(컬럼명)
create index mcustomer_customername_idx on mcustomer(customername);
create index movie_title_idx on movie(title);
create index booking_seat_idx on booking(seat);
create index theater_nameoftheater_idx on theater(nameoftheater);


-- 뷰 제거
drop view mcustomer_booking_info_vw;
-- ★★★뷰 생성
-- 고객이 예약한 영화와 예약날짜와 좌석, 극장명
create view mcustomer_booking_info_vw as
   select t1.customer_id AS 고객ID, t1.customername AS 고객명, t1.tel AS 고객연락처,
          t3.title AS 영화제목, t3.director AS 영화감독, t3.genre AS 영화장르, t3.runningtime AS 상영시간, t3.releasedate AS 개봉일,
          t2.bookingday AS 예약일, t2.seat AS 좌석번호,
          t4.nameoftheater AS 극장명, t4.loc AS 위치
  from mcustomers t1 left outer join booking t2 on t1.customer_id = t2.customer_id
                    left outer join movie t3 on t2.movie_id = t3.movie_id
                    left outer join theater t4 on t2.theater_id = t4.theater_id;

select * from mcustomer_booking_info_vw;




--2.영화 테이블의 개봉일 컬럼을 사용하여 현재 상영 중인 영화를 찾는 쿼리를 작성합니다.
select *
  from movie
  where releasedate <= sysdate;

--3.극장 테이블에서 특정 위치에 있는 극장을 찾고, 해당 극장에서 상영하는 영화 목록을 가져오는 쿼리를 작성합니다.
select t1.loc, t3.title
  from theater t1 left outer join booking t2 on t1.theater_id = t2.theater_id
                  join movie t3 on t2.movie_id = t3.movie_id;
  
--4.예약 테이블을 사용하여 특정 고객의 예약 내역과 예약한 영화의 정보를 함께 제공하는 쿼리를 작성합니다.


--5.예약과 극장을 조인하여, 각 극장별로 예약된 좌석 수를 계산하는 쿼리를 작성합니다.
select t2.nameoftheater, count(t2.nameoftheater) "예약된 좌석 수"
  from booking t1 join theater t2 on t1.theater_id = t2.theater_id
group by t2.nameoftheater;

--6.가장 인기 있는 영화 장르를 결정하는 쿼리를 작성합니다. (예: 예약 수 기준)
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
--select 영화장르, count(영화장르) AS 예매수
--from (select t1.customer_id AS 고객ID, t1.customername AS 고객명, t1.tel AS 고객연락처,
--          t3.title AS 영화제목, t3.director AS 영화감독, t3.genre AS 영화장르, t3.runningtime AS 상영시간, t3.releasedate AS 개봉일,
--          t2.bookingday AS 예약일, t2.seat AS 좌석번호,
--          t4.nameoftheater AS 극장명, t4.loc AS 위치
--       from mcustomers t1 join booking t2 on t1.customer_id = t2.customer_id
--                    join movie t3 on t2.movie_id = t3.movie_id
--                    join theater t4 on t2.theater_id = t4.theater_id)
--  group by 영화장르
--  order by 예매수 desc;
  -- --------------------------------
  

--7.위의 쿼리말고 필요로하는 쿼리문을 3건 작성합니다. (SQL문이 아닌 한글질의문)
