--DROP USER c##scott CASCADE;

create user c##prj1 identified by prj1234 default tablespace users temporary tablespace temp profile default;
grant connect, resource, create view to c##prj1;
GRANT UNLIMITED TABLESPACE TO c##prj1;
alter user c##prj1 account unlock;

