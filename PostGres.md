## Connect to server
- Connect as root
- connect as postgres
- type "psql"

SELECT pg_size_pretty( pg_database_size('das') ); -> database size
\l -> list of DB

\c das; -> connect to DB

\dt das.* -> list latbles

SELECT pg_size_pretty( pg_total_relation_size('saved_query') ); -> size of table saved_query

## QUERY EXEMPLES
select * from das.query_details order by score desc limit 10;

select * from query_details limit 10;

SELECT id FROM das.query_details limit 10;

SELECT * FROM information_schema.columns WHERE table_schema = 'das' AND table_name   = 'query_details';