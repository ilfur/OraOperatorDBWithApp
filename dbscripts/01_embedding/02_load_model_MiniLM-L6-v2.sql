-- mymodel.onnx is Hugging Face's embedding model all-MiniLM-L6-v2
EXECUTE DBMS_VECTOR.DROP_ONNX_MODEL( -
  'minilml6_model', -
  force => true -
)
;
EXECUTE DBMS_VECTOR.LOAD_ONNX_MODEL( -
  'VEC_DUMP', -
  'minilml6_v2.onnx', -
  'minilml6_model', -
   JSON('{"function":"embedding","embeddingOutput":"embedding","input":{"input": ["DATA"]}}') -
)
;
