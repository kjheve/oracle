-- ★★★★★★★★★★시퀀스 적용!!!!!!!!!!★★★★★★★★★★
-- ◆◆◆◆◆◆◆◆◆◆인덱스 적용!!!!!!!!!!◆◆◆◆◆◆◆◆◆◆

--문제 1)
--
--기본 요구사항:
--1. Customers, Orders, OrderDetails, Product 네 개의 테이블을 생성합니다.
--2. Customers 테이블에는 CustomerID, CustomerName, Loc 컬럼이 있어야 합니다.
--3. Orders 테이블에는 OrderID, CustomerID, OrderDate, Status 컬럼이 있어야 합니다.
--4. OrderDetails 테이블에는 OrderDetailID, OrderID, ProductID, Quantity, Price 컬럼이 있어야 합니다.
--5. Product 테이블에는 ProductID, ProductName, ,Price 컬럼이 있어야 합니다.
--6. 모든 테이블은 적절한 데이터 타입을 가진 필요한 기본 키(primary key)와 외래 키(foreign key)를 설정해야 합니다.
--7. 각 테이블에 적어도 5개 이상의 행을 삽입하여 테스트 데이터를 준비합니다.
--
--고급 요구사항 (추가 점수 부여):
--1. Orders 테이블의 Status 컬럼은 'Pending', 'Completed', 'Cancelled' 중 하나의 값을 가질 수 있도록 제약 조건을 설정합니다.
--2. Customers 테이블에서 특정 지역에 거주하는 고객의 수를 찾는 쿼리를 작성합니다.
--3. Orders 테이블에서 최근 30일 이내에 생성된 주문을 찾는 쿼리를 작성합니다.
--4. OrderDetails 테이블을 사용하여 특정 주문의 총 금액을 계산하는 쿼리를 작성합니다.
--5. Customers와 Orders를 조인하여, 각 고객별로 주문 횟수를 계산하는 쿼리를 작성합니다.
--6. ~ 8. 문제는 아래에 있음

-- 테이블 삭제
--DROP TABLE CUSTOMERS;
--DROP TABLE ORDERS;
--DROP TABLE ORDERDETAILS;
--DROP TABLE PRODUCT;
-- 참조되고 있는 테이블은 먼저 삭제가 안되므로 삭제 순서를 바꿔야한다 => 참조 무결성
DROP TABLE ORDERDETAILS;
DROP TABLE ORDERS;
DROP TABLE PRODUCT;
DROP TABLE CUSTOMERS;

-- 테이블 생성
CREATE TABLE CUSTOMERS (
  customer_id      NUMBER(3),
  customername     VARCHAR2(10), -- CONSTRAINT NAME_NN NOT NULL,
  loc              VARCHAR2(15),
--  cuser            VARCHAR2(10),      -- 생성자                     -- 테이블에는 공통속성으로 
  cdate            TIMESTAMP,         -- 생성일시                   
--  uuser            VARCHAR2(10),      -- 수정자                     -- 4가지 속성을 넣는다
  udate            TIMESTAMP          -- 수정일시                  
);
  
CREATE TABLE ORDERS(
  order_id         NUMBER(3),
  customer_id      NUMBER(3),
  orderdate        DATE,
  status           VARCHAR2(10)
);

CREATE TABLE ORDERDETAILS(
  orderdetail_id   NUMBER(4),
  order_id         NUMBER(3),
  product_id       NUMBER(4),
  quantity         NUMBER(3),
  price            NUMBER(7)
);

CREATE TABLE PRODUCT(
  product_id       NUMBER(4),
  productname      VARCHAR2(30),
  price            NUMBER(7)
);

-- 기본키(PRIMARY KEY) 제약조건 추가
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건 이름 PRIMARY KEY(컬럼명);
ALTER TABLE CUSTOMERS ADD CONSTRAINT CUSTOMERS_PK PRIMARY KEY(customer_id);
ALTER TABLE ORDERS ADD CONSTRAINT ORDERS_PK PRIMARY KEY(order_id);
ALTER TABLE ORDERDETAILS ADD CONSTRAINT ORDERDETAILS_PK PRIMARY KEY(orderdetail_id);
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_PK PRIMARY KEY(product_id);

-- 외래키(FOREIGN KEY) 제약조건 추가
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건 이름 FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명;
ALTER TABLE ORDERS ADD CONSTRAINT ORDERS_FK FOREIGN KEY(customer_id) REFERENCES CUSTOMERS;
ALTER TABLE ORDERDETAILS ADD CONSTRAINT ORDERDETAILS_FK1 FOREIGN KEY(order_id) REFERENCES ORDERS;
ALTER TABLE ORDERDETAILS ADD CONSTRAINT ORDERDETAILS_FK2 FOREIGN KEY(product_id) REFERENCES PRODUCT;

-- NOT NULL 제약조건
-- NOT NULL : NULL값이 못들어가게 함, 기본키(PK)는 이미 UNIQUE하기 때문에 자동 NOT NULL 적용 되어 있다.
-- ALTER TABLE CUSTOMERS ADD CONSTRAINT NAME_NN NOT NULL(customername); -- 불가능
-- ALTER TABLE CUSTOMERS RENAME CONSTRAINT SYS_번호직접확인 TO NAME_NN;
-- NOT NULL은 제약조건을 추가할 수 없기 때문에 제약조건 이름을 정하려면 테이블 만들 때 선언 하거나 RENAME으로 이름 변경

ALTER TABLE CUSTOMERS MODIFY customername NOT NULL;
ALTER TABLE CUSTOMERS MODIFY loc NOT NULL;

ALTER TABLE ORDERS MODIFY customer_id NOT NULL;
ALTER TABLE ORDERS MODIFY orderdate NOT NULL;
ALTER TABLE ORDERS MODIFY status NOT NULL;

ALTER TABLE ORDERDETAILS MODIFY order_id NOT NULL;
ALTER TABLE ORDERDETAILS MODIFY product_id  NOT NULL;
ALTER TABLE ORDERDETAILS MODIFY quantity NOT NULL;
ALTER TABLE ORDERDETAILS MODIFY price NOT NULL;

ALTER TABLE PRODUCT MODIFY productname NOT NULL;
ALTER TABLE PRODUCT MODIFY price NOT NULL;

-- 체크 제약조건 추가
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건 이름 CHECK 제약조건
ALTER TABLE ORDERS ADD CONSTRAINT ORDERS_CK CHECK (STATUS IN ('PENDING', 'COMPLETED', 'CANCELLED'));

-- UNIQUE 제약조건 추가
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건 이름 UNIQUE(컬럼명)
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_UK UNIQUE(productname);

-- DEFAULT 제약조건
ALTER TABLE CUSTOMERS MODIFY cdate DEFAULT sysdate;
ALTER TABLE CUSTOMERS MODIFY udate DEFAULT sysdate;


-- ★시퀀스 제거
drop sequence CUSTOMERS_customer_id;
drop sequence ORDERS_order_id;
drop sequence ORDERDETAILS_orderdetail_id;
drop sequence PRODUCT_product_id;

-- ★시퀀스 생성
create sequence CUSTOMERS_customer_id;
create sequence ORDERS_order_id;
create sequence ORDERDETAILS_orderdetail_id;
create sequence PRODUCT_product_id;


-- 샘플데이터
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, '홍길동1', '울산1');
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, '홍길동2', '울산1');
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, '홍길동3', '울산2');
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, '홍길동4', '울산2');
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, '홍길동5', '울산2');
-- customer_id에 동일 값을 주면 개체 무결성에 위배됨

select * from customers;
      

INSERT INTO ORDERS (order_id, customer_id, orderdate, status)
      VALUES (ORDERS_order_id.nextval, 1, TO_DATE('2024/1/1', 'YYYY/MM/DD'), 'PENDING');
INSERT INTO ORDERS (order_id, customer_id, orderdate, status)
      VALUES (ORDERS_order_id.nextval, 1, TO_DATE('2024/1/2', 'YYYY/MM/DD'), 'PENDING');
INSERT INTO ORDERS (order_id, customer_id, orderdate, status)
      VALUES (ORDERS_order_id.nextval, 2, TO_DATE('2024/1/1', 'YYYY/MM/DD'), 'COMPLETED');
INSERT INTO ORDERS (order_id, customer_id, orderdate, status)
      VALUES (ORDERS_order_id.nextval, 2, TO_DATE('2024/1/2', 'YYYY/MM/DD'), 'CANCELLED');
INSERT INTO ORDERS (order_id, customer_id, orderdate, status)
      VALUES (ORDERS_order_id.nextval, 2, TO_DATE('2024/1/3', 'YYYY/MM/DD'), 'PENDING');

select * from orders;

INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, '컴퓨터', 1000000);
INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, '프린트', 500000);
INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, '마우스', 30000);
INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, '키보드', 100000);
INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, '모니터', 400000);

select * from product;


INSERT INTO ORDERDETAILS (orderdetail_id, order_id, product_id, quantity, price)
      VALUES (ORDERDETAILS_orderdetail_id.nextval, 1, 1, 1, 1000000);
INSERT INTO ORDERDETAILS (orderdetail_id, order_id, product_id, quantity, price)
      VALUES (ORDERDETAILS_orderdetail_id.nextval, 2, 1, 1, 1000000);
INSERT INTO ORDERDETAILS (orderdetail_id, order_id, product_id, quantity, price)
      VALUES (ORDERDETAILS_orderdetail_id.nextval, 2, 2, 1, 500000);
INSERT INTO ORDERDETAILS (orderdetail_id, order_id, product_id, quantity, price)
      VALUES (ORDERDETAILS_orderdetail_id.nextval, 3, 3, 1, 30000);
INSERT INTO ORDERDETAILS (orderdetail_id, order_id, product_id, quantity, price)
      VALUES (ORDERDETAILS_orderdetail_id.nextval, 4, 4, 1, 100000);
INSERT INTO ORDERDETAILS (orderdetail_id, order_id, product_id, quantity, price)
      VALUES (ORDERDETAILS_orderdetail_id.nextval, 5, 5, 1, 400000);

select * from orderdetails;


-- 인덱스 제거
drop index customers_customername_idx;
-- ◆ 인덱스 생성
--create index 인덱스 이름 on 테이블명(컬럼명)
create index customers_customername_idx on CUSTOMERS(customername);



-- 질의 작성
-- 2) Customers 테이블에서 특정 지역에 거주하는 고객의 수를 찾는 쿼리를 작성합니다.
select * from customers;

select loc AS 지역명, count(loc) AS 고객수
  from customers
  group by loc
  order by loc;
  
-- 3) Orders 테이블에서 최근 30일 이내에 생성된 주문을 찾는 쿼리를 작성합니다.
select * from orders;  

select sysdate-30 AS "현재시간기준 30일 이내"
  from dual;

select sysdate - interval '30' day AS "현재시간기준 30일 이내"
  from dual;

select *
  from orders
  where orderdate >= (to_date(sysdate, 'YYYY/MM/DD') - 30);
  
select *
  from orders
  where orderdate >= (select sysdate - interval '30' day
                      from dual);



-- 4) OrderDetails 테이블을 사용하여 특정 주문의 총 금액을 계산하는 쿼리를 작성합니다.
select * from orderdetails;
select * from orders;

select order_id, sum(quantity * price) AS 총금액
  from orderdetails
  group by order_id
  order by order_id;

select *
  from orderdetails t1 join orders t2
    on t1.order_id = t2.order_id;

select t2.order_id, sum(t1.quantity * t1.price) AS 총금액
  from orderdetails t1 join orders t2
    on t1.order_id = t2.order_id
  group by t2.order_id
  order by t2.order_id;


-- 5) Customers와 Orders를 조인하여, 각 고객별로 주문 횟수를 계산하는 쿼리를 작성합니다.
select * from customers;
select * from orders;

select *
  from customers t1 left outer join orders t2
    on t1.customer_id = t2.customer_id;

select t1.customer_id, t1.customername, count(t2.order_id)
  from customers t1 left outer join orders t2
    on t1.customer_id = t2.customer_id
    group by t1.customer_id, t1.customername
    order by t1.customername;
    
    
-- 6) 주문 이력이 없는 고객의 이름을 보이시오
-- 상관 서브쿼리
select *
  from customers t1
  where not exists (select *
                    from orders t2
                    where t2.customer_id = t1.customer_id);
                    
select * -- t1.customer_id, t1.customername, t1.loc, t1.cdate, t1.udate
  from customers t1 left outer join orders t2
    on t1.customer_id = t2.customer_id
    where order_id is null;



-- 7) 일일 판매총액 내림차순으로 주문 정보를 보이시오.(주문번호, 고객명, 주문액, 주문일)
select *
  from orders t1, orderdetails t2
  where t1.order_id = t2.order_id;
  
  select t1.order_id, sum(t2.quantity * t2.price)
  from orders t1, orderdetails t2
    where t1.order_id = t2.order_id
  group by t1.order_id;
  
  select t1.order_id AS 주문번호, t3.customername AS 고객명, sum(t2.quantity * t2.price) AS 주문액, t1.orderdate AS 주문일
  from orders t1, orderdetails t2, customers t3
    where t1.order_id = t2.order_id
      and t1.customer_id = t3.customer_id
  group by t1.order_id, t1.orderdate, t3.customername
  order by t1.orderdate, 주문액 desc;
    
  

-- 8) 2번이상 주문한 고객의 이름을 보이시오.
select t2.customername, count(*)
  from orders t1, customers t2
  where t1.customer_id = t2.customer_id
  group by t2.customername
  having count(*) >= 2;
  
  
-- 9) 4개의 테이블 조인하기 (고객 구매 정보)
select t1.customer_id, t1.customername, t1.loc,
       t2.order_id, t2.orderdate, t2.status,
       t3.orderdetail_id, t3.quantity, t3.price AS salprice,
       t4.product_id, t4.productname, t4.price
  from customers t1, orders t2, orderdetails t3, product t4
  where t1.customer_id = t2.customer_id (+)
    and t2.order_id = t3.order_id (+)
    and t3.product_id = t4.product_id (+);
  
select t1.customer_id, t1.customername, t1.loc,
       t2.order_id, t2.orderdate, t2.status,
       t3.orderdetail_id, t3.quantity, t3.price AS salprice,
       t4.product_id, t4.productname, t4.price
  from customers t1 left outer join orders t2 on t1.customer_id = t2.customer_id
                    left outer join orderdetails t3 on t2.order_id = t3.order_id
                    left outer join product t4 on t3.product_id = t4.product_id
                    ;
                    
                    
--   서브 쿼리를 이용해서 우수 구매고객 알아보기
-- 총 구매액이 높은순으로 고객 정보와 총구매액을 보이시오.

select t5.customername, sum(t5.quantity * t5.salprice) AS 총구매액
from (select t1.customer_id, t1.customername, t1.loc,
            t2.order_id, t2.orderdate, t2.status,
            t3.orderdetail_id, t3.quantity, t3.price AS salprice,
            t4.product_id, t4.productname, t4.price
      from customers t1 left outer join orders t2 on t1.customer_id = t2.customer_id
                        left outer join orderdetails t3 on t2.order_id = t3.order_id
                        left outer join product t4 on t3.product_id = t4.product_id) t5
group by t5.customername
order by 총구매액 desc NULLS last;
  


-- 뷰 생성
-- create view 뷰이름 as (뷰로 만들 테이블 쿼리문)
create view customer_sales_info_vw
as select t1.customer_id, t1.customername, t1.loc,
       t2.order_id, t2.orderdate, t2.status,
       t3.orderdetail_id, t3.quantity, t3.price AS salprice,
       t4.product_id, t4.productname, t4.price
  from customers t1 left outer join orders t2 on t1.customer_id = t2.customer_id
                    left outer join orderdetails t3 on t2.order_id = t3.order_id
                    left outer join product t4 on t3.product_id = t4.product_id;
                    
                    
-- 뷰를 이용해서 위에 쿼리를 확인
select customername, sum(quantity * salprice) AS 총구매액
from customer_sales_info_vw
group by customername
order by 총구매액 desc NULLS last;



