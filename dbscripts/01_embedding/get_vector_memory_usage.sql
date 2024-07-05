select CON_ID, POOL, 
round(ALLOC_BYTES/1024/1024,1) as ALLOC_BYTES_MB, 
round(USED_BYTES/1024/1024,1) as USED_BYTES_MB,
populate_status
from V$VECTOR_MEMORY_POOL 
order by 1,2;
