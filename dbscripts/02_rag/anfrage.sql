set long 1000;
set longc 80;
set linesize 200;
set serveroutput on;
ACCEPT P1_INPUT CHAR PROMPT 'Enter text: '
DECLARE
    v_input varchar2(400) := '&P1_INPUT';
    v_n number;
BEGIN 
    v_n := rag_function (v_input); 
END;
/ 
