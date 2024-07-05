SELECT ct.*
 from rag_tab dt, 
  dbms_vector_chain.utl_to_chunks(dbms_vector_chain.utl_to_text(
    dt.data),   
    JSON('{
           "by" : "words",
           "max" : "100",
           "overlap" : "0",
           "split" : "recursively",
           "language" : "american",
           "normalize" : "all"
          }')) ct;     
