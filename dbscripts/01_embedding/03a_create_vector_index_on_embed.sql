-- Vorab:
-- alter system inmemory_size=16G scope=spfile;
-- alter system set vector_memory_size=12G scope=spfile;
-- Jojo
set line 200
set pages 100

drop index if exists IDX_IMMOBILIEN_EMBED;
ALTER SESSION FORCE PARALLEL DDL PARALLEL 4;
set timing on;

create vector index IDX_IMMOBILIEN_EMBED on IMMOBILIEN(embed)
 organization INMEMORY NEIGHBOR GRAPH
 distance COSINE
 with target accuracy 95;

col index_name for a30
col IDX_Params for a40
SELECT INDEX_NAME, INDEX_TYPE, INDEX_SUBTYPE
FROM USER_INDEXES
WHERE INDEX_NAME='IDX_IMMOBILIEN_EMBED';

SELECT JSON_SERIALIZE(IDX_PARAMS returning varchar2 PRETTY) "IDX_Params"
FROM VECSYS.VECTOR$INDEX
where IDX_NAME = 'IDX_IMMOBILIEN_EMBED';
