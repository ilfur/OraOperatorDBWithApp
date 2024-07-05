create or replace Function rag_with_genai_function ( rag_input IN varchar2 ) 
RETURN varchar2
IS  
    query_vector CLOB;
    text_variable VARCHAR2(1000) := rag_input;
    l_doc_id VARCHAR2(100);  
    input CLOB;
    params CLOB;
    output CLOB;
    long_text VARCHAR2(4000);
    cursor c1 is SELECT * FROM rag_chunks2 ORDER BY VECTOR_DISTANCE(CHUNK_EMBEDDING, query_vector, EUCLIDEAN_SQUARED) 
FETCH FIRST 1 ROWS ONLY WITH TARGET ACCURACY 90;
BEGIN 
    input := text_variable;
    params := '{
        "provider" : "ocigenai",
        "credential_name" : "OCI_CRED", 
        "url" : "https://inference.generativeai.us-chicago-1.oci.oraclecloud.com/20231130/actions/generateText",
        "model" : "cohere.command",
        "inferenceRequest": {
            "maxTokens": 300,
            "temperature": 1
          }
    }';
 
    SELECT vector_embedding(distil_model using text_variable as data) into query_vector; 
    for row_1 in c1 loop   
           long_text := '<hr/> Internal PDF Search: <hr/>'||row_1.chunk_data||' <hr/>';
    end loop;  
    output := DBMS_VECTOR_CHAIN.UTL_TO_GENERATE_TEXT(input, json(params));
      
    long_text := long_text||' Generative AI Response:<hr/> '||output;
     
    return (long_text);
 
END;
/
