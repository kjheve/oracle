
create user c##theater identified by theater1234 default tablespace users temporary tablespace temp profile default;
grant connect, resource, create view to c##theater;
GRANT UNLIMITED TABLESPACE TO c##theater;
alter user c##theater account unlock;