set pages 200
set line 300
col embed_data for a80

ACCEPT text_input CHAR PROMPT 'Enter text: '

 VARIABLE text_variable VARCHAR2(1000)
 VARIABLE query_vector VECTOR
 BEGIN
 :text_variable := '&text_input';
 SELECT vector_embedding(DOC_MODEL using :text_variable as data) 
 into :query_vector;
 END;
/

SELECT doc_id, embed_id, embed_data
 FROM DOC_CHUNKS
 ORDER BY vector_distance(embed_vector , :query_vector, COSINE) 
 FETCH APPROX FIRST 2 ROWS ONLY
 WITH TARGET ACCURACY 80;
