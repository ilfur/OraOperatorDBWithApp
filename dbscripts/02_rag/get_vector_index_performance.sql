SET SERVEROUTPUT ON
ACCEPT text_input CHAR PROMPT 'Enter text: '

 VARIABLE text_variable VARCHAR2(1000)
 VARIABLE query_vector VECTOR
 BEGIN
 :text_variable := '&text_input';
 SELECT vector_embedding(DOC_MODEL using :text_variable as data)
 into :query_vector;
 END;
/

declare
report varchar2(128);
begin
  report := dbms_vector.index_accuracy_query( 
  OWNER_NAME => 'VECTOR',
  INDEX_NAME => 'IDX_RAG_CHUNKS_EMBED',
  qv => :query_vector,
  top_K => 10,
  target_accuracy => 80 );
  dbms_output.put_line(report);
end;
/
