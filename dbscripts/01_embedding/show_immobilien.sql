set wrap off
set line 300
col name for a30
col embed for a30
select pid,stadt,typ,embed from immobilien where pid <=10 order by pid; 
