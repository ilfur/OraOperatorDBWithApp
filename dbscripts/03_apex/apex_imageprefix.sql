begin
 apex_instance_admin.set_parameter(p_parameter => 'IMAGE_PREFIX',
                                  p_value => 'https://static.oracle.com/cdn/apex/23.4.0/' );
 commit;
end;
/
