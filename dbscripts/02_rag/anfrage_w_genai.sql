set serveroutput on;
ACCEPT P1_INPUT CHAR PROMPT 'Enter text: '
DECLARE
    v_input varchar2(400) := '&P1_INPUT';
    v_output clob;
BEGIN 
    v_output := rag_with_genai_function (v_input);
    print_clob_to_output(v_output); 
END;
/ 
