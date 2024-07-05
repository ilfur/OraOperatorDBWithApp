col beschreibung for a150
col typ for a15
set line 300
set pagesize 110

UNDEFINE text_input;
SELECT '&&text_input';

VARIABLE text_variable VARCHAR2(1000) 
VARIABLE query_vector CLOB
BEGIN
  :text_variable := '&&text_input';
  SELECT vector_embedding(distil_model using :text_variable as data) INTO :query_vector;
END;
/

SELECT pid, typ, beschreibung, vector_distance(embed, :query_vector, COSINE) cosine_dist
FROM immobilien
WHERE typ='Einfamilienhaus'
ORDER BY cosine_dist
FETCH APPROX FIRST 5 ROWS ONLY WITH TARGET ACCURACY 80;
