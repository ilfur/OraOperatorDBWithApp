col vector_info for a20
col data_type for a20
col attribute_type for a20
col attribute_name for a20
COL model_name for a20
set line 200

SELECT MODEL_NAME, MINING_FUNCTION, ALGORITHM,
ALGORITHM_TYPE, MODEL_SIZE/1024/1024 "SIZE [MB]"
FROM user_mining_models
ORDER BY MODEL_NAME;

SELECT model_name, attribute_name, attribute_type, data_type,vector_info
FROM user_mining_model_attributes
ORDER BY MODEL_NAME;
