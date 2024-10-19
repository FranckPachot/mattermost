DO $DO$
declare
 version text;
begin
 select version() into version;
 -- YugabyteDB has no vaccuum (and shows -YB- in the version string)
 if version !~ '-YB-' then
 execute $DDL$
  alter table posts set (autovacuum_vacuum_scale_factor = 0.2, autovacuum_analyze_scale_factor = 0.1);
  alter table threadmemberships set (autovacuum_vacuum_scale_factor = 0.2, autovacuum_analyze_scale_factor = 0.1);
  alter table fileinfo set (autovacuum_vacuum_scale_factor = 0.2, autovacuum_analyze_scale_factor = 0.1);
  alter table preferences set (autovacuum_vacuum_scale_factor = 0.2, autovacuum_analyze_scale_factor = 0.1);  
 $DDL$;
 end if;
end;
$DO$;
