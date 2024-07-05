col beschreibung for a500
col typ for a15
set line 300
set pagesize 110

ACCEPT text_input CHAR PROMPT 'Enter text: '
VARIABLE text_variable VARCHAR2(1000) 
VARIABLE query_vector VECTOR
BEGIN
  :text_variable := '&text_input';
  SELECT vector_embedding(distil_model using :text_variable as data) into :query_vector;
END;
/

select pid, typ, beschreibung, embed <=> :query_vector as cosine_dist
from immobilien
where typ='Einfamilienhaus'
order by cosine_dist
fetch approx first 5 rows only with target accuracy 80;
