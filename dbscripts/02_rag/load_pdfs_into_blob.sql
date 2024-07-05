SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 10000
SET LONG 10000

-- Create a table containing all the pdfs you want to chunk and vectorize
drop table if exists RAG_TAB purge;

create table RAG_TAB (id number, data blob);

insert into RAG_TAB values(1, to_blob(bfilename('VEC_DUMP', 'breast-cancer-facts-and-figures-2019-2020.pdf')));  
insert into RAG_TAB values(2, to_blob(bfilename('VEC_DUMP', 'coronavirus-faq.pdf')));
commit;

select t.id, round(dbms_lob.getlength(t.data)/1024,2) "[kB]" from RAG_TAB t;
