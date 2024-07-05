SET NUMWIDTH 20
SET LINE 200
COL FORMAT for a20
set verify off
argument 1 prompt "vector_column?: "
define vector_column = '&1';
argument 2 prompt "table_name?: "
define table_name = '&2';

SELECT VECTOR_DIMENSION_COUNT(&VECTOR_COLUMN) "DIMENSION",
VECTOR_DIMENSION_FORMAT(&VECTOR_COLUMN) "FORMAT",
VECTOR_NORM(&VECTOR_COLUMN) "LENGTH" 
FROM &TABLE_NAME WHERE rownum < 11
ORDER BY LENGTH;

SELECT MIN(VECTOR_NORM(&VECTOR_COLUMN)) "Min. length", 
MAX(VECTOR_NORM(&VECTOR_COLUMN)) "Max. length" 
FROM &TABLE_NAME;

