SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 10000
SET LONG 10000

drop table if exists RAG_TAB2 purge;

create table RAG_TAB2 (id number, data blob);

insert into RAG_TAB2 values(1, to_blob(bfilename('VEC_DUMP', 'Demenz-das_wichtigste.pdf')));  
insert into RAG_TAB2 values(2, to_blob(bfilename('VEC_DUMP', 'a-0803-4606.pdf')));
commit;

select dbms_lob.getlength(t.data) from RAG_TAB2 t;
