declare
  jo json_object_t;
begin

  -- create an OCI credential
  jo := json_object_t();
  jo.put('user_ocid','ocid1.user.oc1..blublibla');
  jo.put('tenancy_ocid','ocid1.tenancy.oc1..blublibla');
  jo.put('compartment_ocid','ocid1.compartment.oc1..blublibla');
  jo.put('private_key','MIIblubliblalangerbase64text');
  jo.put('fingerprint','18:96:16:1c:a0:1b:a9:86:46:f0:cc:ha:be:d8:f8:00');
  dbms_output.put_line(jo.to_string);
  dbms_vector_chain.create_credential(
    credential_name   => 'OCI_CRED',
    params            => json(jo.to_string));
end;
/
