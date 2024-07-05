create or replace function rag_function (rag_input IN varchar2) 
RETURN number
IS
    query_vector CLOB;
    text_variable VARCHAR2(1000) := rag_input;
    l_doc_id VARCHAR2(100); 
    cursor c1 is SELECT * 
                    FROM doc_chunks 
                    ORDER BY VECTOR_DISTANCE( EMBED_VECTOR, query_vector, EUCLIDEAN_SQUARED) 
                    FETCH FIRST 1 ROWS ONLY WITH TARGET ACCURACY 90; 
BEGIN 
    -- select vector_embedding into query_vector based on 
    SELECT vector_embedding(minilm6_model using text_variable as data) into query_vector; 
    For row_1 In C1 Loop  
           dbms_output.put_line('ERGEBNIS: '||row_1.embed_data); 
     End Loop; 
return (1); 
END;
/
