-- use Vector Utility PL/SQL package DBMS_VECTOR_CHAIN to convert, 
-- chunk, and vectorize your unstructured data in one end-to-end pipeline.

drop table if exists doc_chunks purge;
set timing on;
CREATE TABLE doc_chunks as
(select dt.id doc_id, et.embed_id, et.embed_data, to_vector(et.embed_vector) embed_vector
 from
   rag_tab dt,
   dbms_vector_chain.utl_to_embeddings(
       dbms_vector_chain.utl_to_chunks(dbms_vector_chain.utl_to_text(dt.data), json('{
           "by" : "words",
           "max" : "100",
           "overlap" : "0",
           "split" : "recursively",
           "language" : "american",
           "normalize":"all"}')),
       json('{"provider":"database", "model":"minilm6_model"}')) t,
   JSON_TABLE(t.column_value, '$[*]' COLUMNS (embed_id NUMBER PATH '$.embed_id', embed_data VARCHAR2(4000) PATH '$.embed_data', 
              embed_vector CLOB PATH '$.embed_vector')) et
)
;
commit;
        
