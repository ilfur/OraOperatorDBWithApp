COL BESCHREIBUNG FOR A500
COL TYP FOR A15
SET LINE 300
SET PAGESIZE 110

ACCEPT text_input CHAR PROMPT 'Enter text: '

 VARIABLE text_variable VARCHAR2(1000)
 VARIABLE query_vector VECTOR
 BEGIN
   :text_variable := '&text_input';
   SELECT VECTOR_EMBEDDING(distil_model USING :text_variable AS DATA) INTO :query_vector;
 END;
/

SELECT * FROM
(
SELECT pid, typ, beschreibung, VECTOR_DISTANCE(embed, :query_vector, COSINE) AS COSINE_DIST
FROM immobilien
)
WHERE typ='Einfamilienhaus' and COSINE_DIST <= 0.6
order by COSINE_DIST 
FETCH FIRST 5 ROWS ONLY;
