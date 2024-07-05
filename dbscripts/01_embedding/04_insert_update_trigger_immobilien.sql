CREATE OR REPLACE TRIGGER immobilien_embed
BEFORE INSERT OR UPDATE ON immobilien
FOR EACH ROW
DECLARE
params clob;
BEGIN
  params := '{"provider":"database","model":"distil_model"}';
  :new.embed := DBMS_VECTOR.UTL_TO_EMBEDDING(:new.beschreibung,json(params));
END;
/
