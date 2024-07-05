-- distil_v2.onnx is Hugging Face's embedding model sentence-transformers/distiluse-base-multilingual-cased-v2
EXECUTE DBMS_VECTOR.DROP_ONNX_MODEL( -
  'distil_model', -
  force => true -
)
;

EXECUTE DBMS_VECTOR.LOAD_ONNX_MODEL( -
  'VEC_DUMP', -
  'distil_v2.onnx', -
  'distil_model', -
   JSON('{"function":"embedding","embeddingOutput":"embedding","input":{"input": ["DATA"]}}') -
)
;
