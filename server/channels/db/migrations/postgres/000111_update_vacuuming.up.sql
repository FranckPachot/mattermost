declare
 version text;
begin
 select version() into version;
 -- YugabyteDB has no vaccuum
 if version !~ '-YB-' then
 execute $DDL$
  alter table posts set (autovacuum_vacuum_scale_factor = 0.1, autovacuum_analyze_scale_factor = 0.05);
  alter table threadmemberships set (autovacuum_vacuum_scale_factor = 0.1, autovacuum_analyze_scale_factor = 0.05);
  alter table fileinfo set (autovacuum_vacuum_scale_factor = 0.1, autovacuum_analyze_scale_factor = 0.05);
  alter table preferences set (autovacuum_vacuum_scale_factor = 0.1, autovacuum_analyze_scale_factor = 0.05);
 $DDL$;
 end if;
end;