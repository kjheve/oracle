-- �ڡڡڡڡڡڡڡڡڡڽ����� ����!!!!!!!!!!�ڡڡڡڡڡڡڡڡڡ�
-- �ߡߡߡߡߡߡߡߡߡ��ε��� ����!!!!!!!!!!�ߡߡߡߡߡߡߡߡߡ�

--���� 1)
--
--�⺻ �䱸����:
--1. Customers, Orders, OrderDetails, Product �� ���� ���̺��� �����մϴ�.
--2. Customers ���̺��� CustomerID, CustomerName, Loc �÷��� �־�� �մϴ�.
--3. Orders ���̺��� OrderID, CustomerID, OrderDate, Status �÷��� �־�� �մϴ�.
--4. OrderDetails ���̺��� OrderDetailID, OrderID, ProductID, Quantity, Price �÷��� �־�� �մϴ�.
--5. Product ���̺��� ProductID, ProductName, ,Price �÷��� �־�� �մϴ�.
--6. ��� ���̺��� ������ ������ Ÿ���� ���� �ʿ��� �⺻ Ű(primary key)�� �ܷ� Ű(foreign key)�� �����ؾ� �մϴ�.
--7. �� ���̺� ��� 5�� �̻��� ���� �����Ͽ� �׽�Ʈ �����͸� �غ��մϴ�.
--
--��� �䱸���� (�߰� ���� �ο�):
--1. Orders ���̺��� Status �÷��� 'Pending', 'Completed', 'Cancelled' �� �ϳ��� ���� ���� �� �ֵ��� ���� ������ �����մϴ�.
--2. Customers ���̺��� Ư�� ������ �����ϴ� ���� ���� ã�� ������ �ۼ��մϴ�.
--3. Orders ���̺��� �ֱ� 30�� �̳��� ������ �ֹ��� ã�� ������ �ۼ��մϴ�.
--4. OrderDetails ���̺��� ����Ͽ� Ư�� �ֹ��� �� �ݾ��� ����ϴ� ������ �ۼ��մϴ�.
--5. Customers�� Orders�� �����Ͽ�, �� ������ �ֹ� Ƚ���� ����ϴ� ������ �ۼ��մϴ�.
--6. ~ 8. ������ �Ʒ��� ����

-- ���̺� ����
--DROP TABLE CUSTOMERS;
--DROP TABLE ORDERS;
--DROP TABLE ORDERDETAILS;
--DROP TABLE PRODUCT;
-- �����ǰ� �ִ� ���̺��� ���� ������ �ȵǹǷ� ���� ������ �ٲ���Ѵ� => ���� ���Ἲ
DROP TABLE ORDERDETAILS;
DROP TABLE ORDERS;
DROP TABLE PRODUCT;
DROP TABLE CUSTOMERS;

-- ���̺� ����
CREATE TABLE CUSTOMERS (
  customer_id      NUMBER(3),
  customername     VARCHAR2(10), -- CONSTRAINT NAME_NN NOT NULL,
  loc              VARCHAR2(15),
--  cuser            VARCHAR2(10),      -- ������                     -- ���̺��� ����Ӽ����� 
  cdate            TIMESTAMP,         -- �����Ͻ�                   
--  uuser            VARCHAR2(10),      -- ������                     -- 4���� �Ӽ��� �ִ´�
  udate            TIMESTAMP          -- �����Ͻ�                  
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

-- �⺻Ű(PRIMARY KEY) �������� �߰�
-- ALTER TABLE ���̺�� ADD CONSTRAINT �������� �̸� PRIMARY KEY(�÷���);
ALTER TABLE CUSTOMERS ADD CONSTRAINT CUSTOMERS_PK PRIMARY KEY(customer_id);
ALTER TABLE ORDERS ADD CONSTRAINT ORDERS_PK PRIMARY KEY(order_id);
ALTER TABLE ORDERDETAILS ADD CONSTRAINT ORDERDETAILS_PK PRIMARY KEY(orderdetail_id);
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_PK PRIMARY KEY(product_id);

-- �ܷ�Ű(FOREIGN KEY) �������� �߰�
-- ALTER TABLE ���̺�� ADD CONSTRAINT �������� �̸� FOREIGN KEY(�÷���) REFERENCES ������ ���̺��;
ALTER TABLE ORDERS ADD CONSTRAINT ORDERS_FK FOREIGN KEY(customer_id) REFERENCES CUSTOMERS;
ALTER TABLE ORDERDETAILS ADD CONSTRAINT ORDERDETAILS_FK1 FOREIGN KEY(order_id) REFERENCES ORDERS;
ALTER TABLE ORDERDETAILS ADD CONSTRAINT ORDERDETAILS_FK2 FOREIGN KEY(product_id) REFERENCES PRODUCT;

-- NOT NULL ��������
-- NOT NULL : NULL���� ������ ��, �⺻Ű(PK)�� �̹� UNIQUE�ϱ� ������ �ڵ� NOT NULL ���� �Ǿ� �ִ�.
-- ALTER TABLE CUSTOMERS ADD CONSTRAINT NAME_NN NOT NULL(customername); -- �Ұ���
-- ALTER TABLE CUSTOMERS RENAME CONSTRAINT SYS_��ȣ����Ȯ�� TO NAME_NN;
-- NOT NULL�� ���������� �߰��� �� ���� ������ �������� �̸��� ���Ϸ��� ���̺� ���� �� ���� �ϰų� RENAME���� �̸� ����

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

-- üũ �������� �߰�
-- ALTER TABLE ���̺�� ADD CONSTRAINT �������� �̸� CHECK ��������
ALTER TABLE ORDERS ADD CONSTRAINT ORDERS_CK CHECK (STATUS IN ('PENDING', 'COMPLETED', 'CANCELLED'));

-- UNIQUE �������� �߰�
-- ALTER TABLE ���̺�� ADD CONSTRAINT �������� �̸� UNIQUE(�÷���)
ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_UK UNIQUE(productname);

-- DEFAULT ��������
ALTER TABLE CUSTOMERS MODIFY cdate DEFAULT sysdate;
ALTER TABLE CUSTOMERS MODIFY udate DEFAULT sysdate;


-- �ڽ����� ����
drop sequence CUSTOMERS_customer_id;
drop sequence ORDERS_order_id;
drop sequence ORDERDETAILS_orderdetail_id;
drop sequence PRODUCT_product_id;

-- �ڽ����� ����
create sequence CUSTOMERS_customer_id;
create sequence ORDERS_order_id;
create sequence ORDERDETAILS_orderdetail_id;
create sequence PRODUCT_product_id;


-- ���õ�����
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, 'ȫ�浿1', '���1');
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, 'ȫ�浿2', '���1');
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, 'ȫ�浿3', '���2');
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, 'ȫ�浿4', '���2');
INSERT INTO CUSTOMERS (customer_id, customername, loc)
      VALUES (CUSTOMERS_customer_id.nextval, 'ȫ�浿5', '���2');
-- customer_id�� ���� ���� �ָ� ��ü ���Ἲ�� �����

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
      VALUES (PRODUCT_product_id.nextval, '��ǻ��', 1000000);
INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, '����Ʈ', 500000);
INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, '���콺', 30000);
INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, 'Ű����', 100000);
INSERT INTO PRODUCT (product_id, productname, price)
      VALUES (PRODUCT_product_id.nextval, '�����', 400000);

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


-- �ε��� ����
drop index customers_customername_idx;
-- �� �ε��� ����
--create index �ε��� �̸� on ���̺��(�÷���)
create index customers_customername_idx on CUSTOMERS(customername);



-- ���� �ۼ�
-- 2) Customers ���̺��� Ư�� ������ �����ϴ� ���� ���� ã�� ������ �ۼ��մϴ�.
select * from customers;

select loc AS ������, count(loc) AS ����
  from customers
  group by loc
  order by loc;
  
-- 3) Orders ���̺��� �ֱ� 30�� �̳��� ������ �ֹ��� ã�� ������ �ۼ��մϴ�.
select * from orders;  

select sysdate-30 AS "����ð����� 30�� �̳�"
  from dual;

select sysdate - interval '30' day AS "����ð����� 30�� �̳�"
  from dual;

select *
  from orders
  where orderdate >= (to_date(sysdate, 'YYYY/MM/DD') - 30);
  
select *
  from orders
  where orderdate >= (select sysdate - interval '30' day
                      from dual);



-- 4) OrderDetails ���̺��� ����Ͽ� Ư�� �ֹ��� �� �ݾ��� ����ϴ� ������ �ۼ��մϴ�.
select * from orderdetails;
select * from orders;

select order_id, sum(quantity * price) AS �ѱݾ�
  from orderdetails
  group by order_id
  order by order_id;

select *
  from orderdetails t1 join orders t2
    on t1.order_id = t2.order_id;

select t2.order_id, sum(t1.quantity * t1.price) AS �ѱݾ�
  from orderdetails t1 join orders t2
    on t1.order_id = t2.order_id
  group by t2.order_id
  order by t2.order_id;


-- 5) Customers�� Orders�� �����Ͽ�, �� ������ �ֹ� Ƚ���� ����ϴ� ������ �ۼ��մϴ�.
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
    
    
-- 6) �ֹ� �̷��� ���� ���� �̸��� ���̽ÿ�
-- ��� ��������
select *
  from customers t1
  where not exists (select *
                    from orders t2
                    where t2.customer_id = t1.customer_id);
                    
select * -- t1.customer_id, t1.customername, t1.loc, t1.cdate, t1.udate
  from customers t1 left outer join orders t2
    on t1.customer_id = t2.customer_id
    where order_id is null;



-- 7) ���� �Ǹ��Ѿ� ������������ �ֹ� ������ ���̽ÿ�.(�ֹ���ȣ, ����, �ֹ���, �ֹ���)
select *
  from orders t1, orderdetails t2
  where t1.order_id = t2.order_id;
  
  select t1.order_id, sum(t2.quantity * t2.price)
  from orders t1, orderdetails t2
    where t1.order_id = t2.order_id
  group by t1.order_id;
  
  select t1.order_id AS �ֹ���ȣ, t3.customername AS ����, sum(t2.quantity * t2.price) AS �ֹ���, t1.orderdate AS �ֹ���
  from orders t1, orderdetails t2, customers t3
    where t1.order_id = t2.order_id
      and t1.customer_id = t3.customer_id
  group by t1.order_id, t1.orderdate, t3.customername
  order by t1.orderdate, �ֹ��� desc;
    
  

-- 8) 2���̻� �ֹ��� ���� �̸��� ���̽ÿ�.
select t2.customername, count(*)
  from orders t1, customers t2
  where t1.customer_id = t2.customer_id
  group by t2.customername
  having count(*) >= 2;
  
  
-- 9) 4���� ���̺� �����ϱ� (�� ���� ����)
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
                    
                    
--   ���� ������ �̿��ؼ� ��� ���Ű� �˾ƺ���
-- �� ���ž��� ���������� �� ������ �ѱ��ž��� ���̽ÿ�.

select t5.customername, sum(t5.quantity * t5.salprice) AS �ѱ��ž�
from (select t1.customer_id, t1.customername, t1.loc,
            t2.order_id, t2.orderdate, t2.status,
            t3.orderdetail_id, t3.quantity, t3.price AS salprice,
            t4.product_id, t4.productname, t4.price
      from customers t1 left outer join orders t2 on t1.customer_id = t2.customer_id
                        left outer join orderdetails t3 on t2.order_id = t3.order_id
                        left outer join product t4 on t3.product_id = t4.product_id) t5
group by t5.customername
order by �ѱ��ž� desc NULLS last;
  


-- �� ����
-- create view ���̸� as (��� ���� ���̺� ������)
create view customer_sales_info_vw
as select t1.customer_id, t1.customername, t1.loc,
       t2.order_id, t2.orderdate, t2.status,
       t3.orderdetail_id, t3.quantity, t3.price AS salprice,
       t4.product_id, t4.productname, t4.price
  from customers t1 left outer join orders t2 on t1.customer_id = t2.customer_id
                    left outer join orderdetails t3 on t2.order_id = t3.order_id
                    left outer join product t4 on t3.product_id = t4.product_id;
                    
                    
-- �並 �̿��ؼ� ���� ������ Ȯ��
select customername, sum(quantity * salprice) AS �ѱ��ž�
from customer_sales_info_vw
group by customername
order by �ѱ��ž� desc NULLS last;



