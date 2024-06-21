/** 
    Postgres initialization script
    1. create keycloak database, user and password
    2. grant all privileges to the user
    3. create avni database, user and password
    4. grant all privileges to the user

*/

-- create keycloak database if not exists
CREATE DATABASE keycloak;

-- create keycloak user if not exists
CREATE USER keycloak WITH PASSWORD 'keycloak';

-- grant all privileges to keycloak user
GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak;

-- select avni database
\c keycloak;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO keycloak;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO keycloak;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO keycloak;


-- create avni database if not exists
CREATE DATABASE openchs;

-- create avni user
CREATE USER openchs WITH PASSWORD 'openchs' createrole;
CREATE USER teachap WITH PASSWORD 'teachap' createrole;


-- grant all privileges to avni user
GRANT ALL PRIVILEGES ON DATABASE openchs TO openchs;

-- select avni database
\c openchs;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO openchs;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO openchs;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO openchs;


CREATE extension "uuid-ossp";
CREATE extension "ltree";
CREATE extension "hstore";

create role teachap with NOINHERIT NOLOGIN;
grant teachap to openchs;


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO teachap;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO teachap;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO teachap;

create role openchs_impl;
grant openchs_impl to openchs;
create role organisation_user createrole admin openchs_impl;


create DATABASE superset
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

-- create superset user
CREATE USER superset WITH PASSWORD '1qazsxdcfvggdfgfgdf';

-- grant all privileges to superset user
GRANT ALL PRIVILEGES ON DATABASE superset TO superset;

-- select superset database
\c superset;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO superset;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO superset;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO superset;
