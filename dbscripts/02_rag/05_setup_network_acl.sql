-- Setup Network ACL 

BEGIN
  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host => '*',
    ace => xs$ace_type(privilege_list => xs$name_list('connect'),
                       principal_name => 'vector',
                       principal_type => xs_acl.ptype_db));
END;
/ 
