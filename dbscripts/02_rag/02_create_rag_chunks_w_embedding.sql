-- use Vector Utility PL/SQL package DBMS_VECTOR_CHAIN to convert, 
-- chunk, and vectorize your unstructured data in one end-to-end pipeline.

drop table if exists RAG_CHUNKS purge;
set timing on;

CREATE TABLE RAG_CHUNKS
   (
     doc_id          NUMBER,
     chunk_id        NUMBER,
     chunk_data      VARCHAR2(4000),
     chunk_embedding VECTOR
   );

INSERT INTO RAG_CHUNKS
SELECT dt.id                      doc_id,
       et.embed_id                chunk_id,
       et.embed_data              chunk_data,
       to_vector(et.embed_vector) chunk_embedding
FROM RAG_TAB dt,
     dbms_vector_chain.utl_to_embeddings(
         dbms_vector_chain.utl_to_chunks(dbms_vector_chain.utl_to_text(dt.data),json('{
             "by" : "words",
             "max" : "100",
             "overlap" : "0",
             "split" : "recursively",
             "language" : "american",
             "normalize":"all"}')),
         json('{"provider":"database", "model":"minilml6_model"}')) t,
     json_table(t.column_value, '$[*]' COLUMNS (embed_id NUMBER path '$.embed_id', embed_data VARCHAR2(4000) path '$.embed_data',
                embed_vector clob path '$.embed_vector')) et;

commit;
