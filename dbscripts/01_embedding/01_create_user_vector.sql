-- Create Tablespace
CREATE TABLESPACE tbsvec
-- DATAFILE '/opt/oracle/oradata/FREE/aipdb/tbsvec.dbf' SIZE 5G AUTOEXTEND ON
DATAFILE SIZE 5G AUTOEXTEND ON
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;
-- Create User "vector"
DROP USER vector CASCADE;
CREATE USER vector IDENTIFIED BY vector DEFAULT TABLESPACE tbsvec
QUOTA UNLIMITED ON tbsvec;
GRANT DB_DEVELOPER_ROLE TO vector;
GRANT CREATE MINING MODEL TO vector;
GRANT CREATE ANY CREDENTIAL TO vector;
CREATE OR REPLACE DIRECTORY vec_dump AS '/opt/vecdump';
GRANT READ, WRITE ON DIRECTORY vec_dump TO vector;
declare
      l_dp_handle       number;
    begin
      -- Open a schema import job
      l_dp_handle := dbms_datapump.open(
        operation   => 'IMPORT',
        job_mode    => 'TABLE',
        remote_link => NULL,
        job_name    => 'IMMOBILIEN_IMPORT',
        version     => 'LATEST');

      -- Specify the dump file name and directory object name.
      dbms_datapump.add_file(
        handle    => l_dp_handle,
        filename  => 'immobilien.dmp',
        directory => 'VEC_DUMP',
        filetype => DBMS_DATAPUMP.KU$_FILE_TYPE_DUMP_FILE );

      -- Specify the log file name and directory object name.
      dbms_datapump.add_file(
        handle    => l_dp_handle,
        filename  => 'imp_immobilien.log',
        directory => 'VEC_DUMP',
        filetype  => DBMS_DATAPUMP.KU$_FILE_TYPE_LOG_FILE);
      dbms_datapump.start_job(l_dp_handle);

      dbms_datapump.detach(l_dp_handle);
    end;
    /
