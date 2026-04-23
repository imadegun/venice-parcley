--
-- PostgreSQL database dump
--

\restrict ApXGyaBjhmWI3aqZKlZxDwwUBTBEyhJrLshHSOCL0GfxXH95I5keOdF5VezS9Vn

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: database-schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "database-schema";


ALTER SCHEMA "database-schema" OWNER TO postgres;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: booking_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.booking_status AS ENUM (
    'confirmed',
    'cancelled',
    'completed'
);


ALTER TYPE public.booking_status OWNER TO postgres;

--
-- Name: loyalty_point_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.loyalty_point_type AS ENUM (
    'earned',
    'redeemed'
);


ALTER TYPE public.loyalty_point_type OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'guest',
    'member',
    'admin'
);


ALTER TYPE public.user_role OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: award_loyalty_points(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.award_loyalty_points() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Only award points for new confirmed bookings
  IF NEW.status = 'confirmed' AND OLD.status != 'confirmed' THEN
    INSERT INTO loyalty_points (user_id, points, type, booking_id, description)
    VALUES (
      NEW.guest_id,
      FLOOR(NEW.total_cents / 100), -- 1 point per dollar spent
      'earned',
      NEW.id,
      'Points earned from booking: ' || NEW.id
    );
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.award_loyalty_points() OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name)
  VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'full_name');
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL AND ppt.tablename NOT LIKE '% %'),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  -- Count raw slot entries before apply_rls/subscription filter
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  -- Apply RLS and filter as before
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  -- Real rows with slot count attached
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  -- Sentinel row: always returned when no real rows exist so Elixir can
  -- always read slot_changes_count. Identified by wal IS NULL.
  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: apartments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apartments (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    slug text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    short_description text,
    max_guests integer NOT NULL,
    bedrooms integer NOT NULL,
    base_price_cents integer NOT NULL,
    image_url text,
    gallery_images text[] DEFAULT '{}'::text[],
    artistic_features text[] DEFAULT '{}'::text[],
    amenities text[] DEFAULT '{}'::text[],
    location_details jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT apartments_base_price_cents_check CHECK ((base_price_cents >= 0)),
    CONSTRAINT apartments_bedrooms_check CHECK ((bedrooms >= 0)),
    CONSTRAINT apartments_max_guests_check CHECK ((max_guests > 0))
);


ALTER TABLE public.apartments OWNER TO postgres;

--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    apartment_id uuid NOT NULL,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    total_guests integer DEFAULT 1 NOT NULL,
    total_cents integer NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    special_requests text,
    contact_info jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: content_revisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_revisions (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    section_id uuid NOT NULL,
    key text NOT NULL,
    payload jsonb NOT NULL,
    version integer NOT NULL,
    published_by uuid,
    published_at timestamp with time zone DEFAULT now(),
    CONSTRAINT content_revisions_key_check CHECK ((key = ANY (ARRAY['homepage'::text, 'about'::text, 'contact'::text]))),
    CONSTRAINT content_revisions_version_check CHECK ((version > 0))
);


ALTER TABLE public.content_revisions OWNER TO postgres;

--
-- Name: content_sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_sections (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    key text NOT NULL,
    payload jsonb NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    created_by uuid,
    updated_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT content_sections_key_check CHECK ((key = ANY (ARRAY['homepage'::text, 'about'::text, 'contact'::text]))),
    CONSTRAINT content_sections_status_check CHECK ((status = ANY (ARRAY['draft'::text, 'published'::text]))),
    CONSTRAINT content_sections_version_check CHECK ((version > 0))
);


ALTER TABLE public.content_sections OWNER TO postgres;

--
-- Name: database-schema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."database-schema" (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."database-schema" OWNER TO postgres;

--
-- Name: TABLE "database-schema"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."database-schema" IS 'schema database for venice parcley';


--
-- Name: database-schema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."database-schema" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."database-schema_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: loyalty_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loyalty_points (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    points integer NOT NULL,
    type text NOT NULL,
    booking_id uuid,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.loyalty_points OWNER TO postgres;

--
-- Name: menu_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_items (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    label text NOT NULL,
    href text NOT NULL,
    is_active boolean DEFAULT true,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    content text,
    map_embed text
);


ALTER TABLE public.menu_items OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text NOT NULL,
    full_name text,
    phone text,
    role public.user_role DEFAULT 'guest'::public.user_role,
    preferred_driver_id uuid,
    notification_preferences jsonb DEFAULT '{"sms": false, "email": true}'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    key text NOT NULL,
    value jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
0c6106a1-e594-45bc-8d80-26161d612a63	0c6106a1-e594-45bc-8d80-26161d612a63	{"sub": "0c6106a1-e594-45bc-8d80-26161d612a63", "email": "admin@admin.com", "full_name": "madegun", "email_verified": false, "phone_verified": false}	email	2026-04-10 14:34:48.443177+00	2026-04-10 14:34:48.443232+00	2026-04-10 14:34:48.443232+00	3edbb33c-d9d2-4238-b81c-6af61e3e3ebb
c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	{"sub": "c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7", "email": "degun@admin.com", "full_name": "madegun", "email_verified": false, "phone_verified": false}	email	2026-04-12 06:54:38.58177+00	2026-04-12 06:54:38.581823+00	2026-04-12 06:54:38.581823+00	23c4d411-d5a9-45c0-a9a5-6f99ac97cd51
9ed09247-a87c-4024-9376-3e3ca428cabb	9ed09247-a87c-4024-9376-3e3ca428cabb	{"sub": "9ed09247-a87c-4024-9376-3e3ca428cabb", "email": "tes@admin.com", "full_name": "tess", "email_verified": false, "phone_verified": false}	email	2026-04-12 07:14:52.817978+00	2026-04-12 07:14:52.818046+00	2026-04-12 07:14:52.818046+00	eeb8761f-1fa2-4aef-bf2d-57fcaa91c04e
691769f3-9978-472b-9fb5-62c15543d7d9	691769f3-9978-472b-9fb5-62c15543d7d9	{"sub": "691769f3-9978-472b-9fb5-62c15543d7d9", "email": "made@made.com", "full_name": "made", "email_verified": false, "phone_verified": false}	email	2026-04-12 07:44:08.472731+00	2026-04-12 07:44:08.472789+00	2026-04-12 07:44:08.472789+00	78d02d31-5f31-4dd3-9930-5e6828568f1b
590ccd8f-fc79-40f8-9083-f382ba41c5a0	590ccd8f-fc79-40f8-9083-f382ba41c5a0	{"sub": "590ccd8f-fc79-40f8-9083-f382ba41c5a0", "email": "wayan@wayan.com", "full_name": "wayan", "email_verified": false, "phone_verified": false}	email	2026-04-12 08:23:45.018665+00	2026-04-12 08:23:45.018724+00	2026-04-12 08:23:45.018724+00	b3f752f3-054c-43d1-9511-54359def8dd7
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
70e28599-c044-4820-9caa-dc3359e2d30c	2026-04-12 06:54:38.60987+00	2026-04-12 06:54:38.60987+00	password	464db23b-faf7-49a1-be86-dd880b0593a9
44ec12c8-3a92-4390-88c3-bff0d0d75518	2026-04-12 06:56:11.762966+00	2026-04-12 06:56:11.762966+00	password	4962788b-dd1d-4db8-9879-0bab74ffe4d3
eb52b761-9400-4c4e-b3e6-6f767dc173f7	2026-04-12 06:57:07.41479+00	2026-04-12 06:57:07.41479+00	password	eb89c3af-c5d4-439f-ab1a-80e9ebadc6c7
b0024629-c99e-443e-ad94-16e30795c577	2026-04-12 07:14:07.226515+00	2026-04-12 07:14:07.226515+00	password	013f63bb-737c-4499-874b-f57f9cc9fdfc
62c21852-926d-4ab3-be87-48b8ce942519	2026-04-12 07:14:52.829298+00	2026-04-12 07:14:52.829298+00	password	9ccc59da-fc0f-40a5-9b61-7d7d7d852747
9a9aaf50-0619-4728-880c-40f9f29461f4	2026-04-12 07:16:19.902635+00	2026-04-12 07:16:19.902635+00	password	18ff94a5-2f0a-42c2-8e7e-b4c555915add
4b3a7f55-05b7-4d93-b771-f5990199f60b	2026-04-12 07:25:51.724617+00	2026-04-12 07:25:51.724617+00	password	be038029-55b1-4aaa-ac8a-262c6fbc0f08
f5714753-4777-47fc-b863-91ec0acbc0e7	2026-04-12 07:27:36.135446+00	2026-04-12 07:27:36.135446+00	password	2e11b2bf-3f61-42cc-961a-b20cc07b4482
8913692c-0417-4694-8f67-bd2080d0c772	2026-04-12 07:28:15.932674+00	2026-04-12 07:28:15.932674+00	password	4f7c6de5-7cb2-43a6-b090-4c4bd006a1e5
317e516c-72e7-4073-807a-0f589a746627	2026-04-12 07:33:19.417486+00	2026-04-12 07:33:19.417486+00	password	2ab3315f-93fa-4dcc-b12f-40bc1d6751ba
1d11e31f-60f3-454f-b60e-a5ffaa108345	2026-04-12 07:38:38.578416+00	2026-04-12 07:38:38.578416+00	password	44adae1b-4bab-49b8-86df-96d14457ce55
33ea2b77-6989-49b5-84e8-5eecb8e53ca3	2026-04-12 07:39:36.566551+00	2026-04-12 07:39:36.566551+00	password	cedec03a-5c18-413e-8901-4be81db9ad2f
1730986d-8121-4daa-8bd6-58dfa4bbaa88	2026-04-12 07:43:22.723056+00	2026-04-12 07:43:22.723056+00	password	a7e624b1-2f02-4179-8ea2-15d94bd3b647
eb7e7090-f461-42d7-92e9-3114b64af1a0	2026-04-12 07:44:08.486885+00	2026-04-12 07:44:08.486885+00	password	1bae8472-5fa3-4d10-90ae-9baa72713f7d
5a657a1b-b2b5-4cec-af11-28447c4e5af5	2026-04-12 07:44:36.771506+00	2026-04-12 07:44:36.771506+00	password	dacecc38-de98-4a8e-84a7-7d5c64e7e24c
57b00840-105e-4a3a-9e72-926ec288da59	2026-04-12 08:00:19.493236+00	2026-04-12 08:00:19.493236+00	password	a432694e-579e-45ff-833e-f42be6581d08
17e5f75f-5777-463b-84b6-0a22ed27089a	2026-04-12 08:01:13.34349+00	2026-04-12 08:01:13.34349+00	password	4b3c7c6c-f655-4942-b88f-d996db251e53
198173c1-2d02-4fab-8d37-bb09e231e747	2026-04-12 08:02:08.824135+00	2026-04-12 08:02:08.824135+00	password	82306f9a-0e0c-4f07-88d3-9dbc9711da69
988aba8d-7389-41ee-8b62-c9e8f9979c19	2026-04-12 08:12:53.331923+00	2026-04-12 08:12:53.331923+00	password	8589e2ea-7182-41ec-aba8-3172bdcc06cc
998c17e2-a2db-495e-b81f-b2ae06c6800c	2026-04-12 08:13:11.21071+00	2026-04-12 08:13:11.21071+00	password	c359230d-92c2-48aa-bfd2-5b4062ef5ad1
8b7bbb46-ade2-4424-bfa0-97d2c224dd7d	2026-04-12 08:14:43.663036+00	2026-04-12 08:14:43.663036+00	password	2e83686c-78de-4a06-84ee-0c8859861d03
4ac2d29e-c274-45dd-8131-2e6b3f7cee21	2026-04-12 08:22:40.636849+00	2026-04-12 08:22:40.636849+00	password	e440bb9e-9d6f-4f13-9865-16fbdfec5036
5f488689-f5a5-41a5-8f50-66b73d5ebef6	2026-04-12 08:22:59.001499+00	2026-04-12 08:22:59.001499+00	password	9157d479-8916-4dbb-99c2-97008555d0e4
47c0259f-c7f3-4ec7-8512-141d7af43c25	2026-04-12 08:23:45.033352+00	2026-04-12 08:23:45.033352+00	password	a7708869-9acd-4ab9-adba-4d0d82d12c49
0374fef6-e638-4589-903a-9040e1cf9be5	2026-04-12 08:25:28.829724+00	2026-04-12 08:25:28.829724+00	password	f61565c2-17e3-4751-aa80-eb9d08520586
d2466f38-6910-49b0-9865-161d8051312a	2026-04-12 08:26:47.404086+00	2026-04-12 08:26:47.404086+00	password	fbe2d3d1-8693-401a-825f-95b5824f943b
ff9ea1cd-bde2-486b-8041-d648b4d97e56	2026-04-12 08:29:12.947752+00	2026-04-12 08:29:12.947752+00	password	949ef94b-cba6-43da-a4ab-4fbb32135c43
83570ac7-df27-46c6-a7bf-123925ebe3a7	2026-04-12 08:35:06.030762+00	2026-04-12 08:35:06.030762+00	password	b5f77993-a53e-4e7e-a342-53136ef0eb23
1d250f4a-1867-4e12-a3ec-62d43c10fedd	2026-04-12 08:37:38.450087+00	2026-04-12 08:37:38.450087+00	password	ade1d61a-b2fa-4479-8f99-cf1d6157f846
40ee7ab7-f3c3-482a-86e8-ee5df35fc1f6	2026-04-12 08:41:25.452184+00	2026-04-12 08:41:25.452184+00	password	97282442-9a9f-4cc8-aa06-26b05cb5b798
4531c6cb-5263-4cbd-9333-00aab4491e73	2026-04-12 08:42:09.413806+00	2026-04-12 08:42:09.413806+00	password	be85e975-5090-41d3-8398-4aa131579742
1a1ec76b-9f17-4970-9c26-b645197ee467	2026-04-12 08:43:56.034031+00	2026-04-12 08:43:56.034031+00	password	d2acfa26-2948-4ea0-9b53-cebb44315e38
a3451bb1-2ad8-4d6f-aae1-7eae0dfbea37	2026-04-12 08:52:43.052358+00	2026-04-12 08:52:43.052358+00	password	190c954a-7210-417e-8914-7505db6b62d0
93e090f3-3490-43b2-bdb4-4cf4d5c94ad7	2026-04-12 08:53:45.764126+00	2026-04-12 08:53:45.764126+00	password	db685596-d2ec-4faa-8c19-cded474d384f
0394355c-b37f-4601-8175-a61bcde4f669	2026-04-12 08:54:08.516769+00	2026-04-12 08:54:08.516769+00	password	c6fcbd74-1d7b-48e5-afb1-e51aef216632
a9a478d8-a587-467f-94f9-3a22d75ae01c	2026-04-12 08:59:19.148954+00	2026-04-12 08:59:19.148954+00	password	744b6788-b1ae-4051-b46a-57dded062fee
eabc6258-8702-4fc3-bfaf-cb596726f911	2026-04-12 09:10:08.239127+00	2026-04-12 09:10:08.239127+00	password	fa64a909-6732-4811-8080-f81331b038bf
a2f52e62-d0ea-473e-9eab-d4c70ac9c55b	2026-04-12 09:18:04.208816+00	2026-04-12 09:18:04.208816+00	password	fe402e7f-89fc-4565-b8ba-838010b6c39a
acb27357-58fc-4ed2-abb7-36ffcaa36a8d	2026-04-12 10:02:56.178825+00	2026-04-12 10:02:56.178825+00	password	bb5bf8c0-4d8b-44ae-909f-08d4a6b4a009
d5ff706f-d656-4ace-ae57-217cc33bb0b7	2026-04-12 10:09:04.868791+00	2026-04-12 10:09:04.868791+00	password	8cc0a2e0-3653-4759-8d1c-a80caca8e924
cb36f83c-fd15-4016-af45-efc40da11cb9	2026-04-12 12:11:01.060946+00	2026-04-12 12:11:01.060946+00	password	b773fcdb-a3b3-4f3e-a558-9970721bd221
82497aef-7996-4a60-b664-c1038f8578b2	2026-04-12 12:11:20.255655+00	2026-04-12 12:11:20.255655+00	password	eb053681-328d-4dad-a2c6-d023ad1482d4
af0232f5-3467-48b9-87da-f072e07cc054	2026-04-12 12:11:32.156016+00	2026-04-12 12:11:32.156016+00	password	21a16880-8a0c-46a8-82b8-6ca7b93648b8
8177222e-b190-490e-b09c-7fb2e1500014	2026-04-12 13:28:56.765233+00	2026-04-12 13:28:56.765233+00	password	65ff2df8-1d3b-4eb9-aee7-116b8ab37ec4
fceccb5e-7d18-4979-a937-447443e93afb	2026-04-12 13:29:04.467517+00	2026-04-12 13:29:04.467517+00	password	6e3900fd-ae32-4afd-babf-d3e900fa5673
224f3ec1-596c-4e02-a193-1dc9634cb673	2026-04-13 06:44:43.425698+00	2026-04-13 06:44:43.425698+00	password	03f17321-4d7e-4c3f-9533-0a1d34e3486b
a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7	2026-04-13 06:49:02.314042+00	2026-04-13 06:49:02.314042+00	password	34d6a861-fbb9-416b-a032-f7c5738fdd9b
88c27403-ae9a-4188-8322-771a6aa4b253	2026-04-14 00:53:56.426226+00	2026-04-14 00:53:56.426226+00	password	da7e105f-a84a-4b94-b508-8282d71717e1
47d9e75f-7c12-4a54-bb85-5670690a5920	2026-04-14 00:53:57.50359+00	2026-04-14 00:53:57.50359+00	password	029046f2-d601-4e8d-8c8b-eed40d3a711d
1b9a93df-fe78-4a97-9759-93221841dbb4	2026-04-14 12:39:40.003552+00	2026-04-14 12:39:40.003552+00	password	560e7d87-b52a-4697-8648-22b404163609
9549d368-5056-405f-a422-c92faaf13179	2026-04-14 14:25:15.565768+00	2026-04-14 14:25:15.565768+00	password	2402c6eb-092a-49f0-a7a7-6c963174ea05
747874ff-6458-417b-adc6-dd91adb64e75	2026-04-19 21:26:45.717934+00	2026-04-19 21:26:45.717934+00	password	3f370228-30b0-486a-8d9b-3f09f481380f
53502677-c2d9-44b8-9d6e-e8bb2dcb22bb	2026-04-19 21:26:51.420507+00	2026-04-19 21:26:51.420507+00	password	e0ca8c2e-59ce-4f00-9d51-d0c04f36dcbb
d423eabb-c997-465c-b7f2-b46786e6ef70	2026-04-20 02:04:57.102108+00	2026-04-20 02:04:57.102108+00	password	8e9e428d-c7cd-4565-90aa-a16144c90fa5
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
71ad2a37-8b01-4d66-a675-20e16244c237	0c6106a1-e594-45bc-8d80-26161d612a63	confirmation_token	3be0c3c614aa4302492a0ed496d39e398898ddfecf18f84598bdc4e7	admin@admin.com	2026-04-10 14:34:50.030871	2026-04-10 14:34:50.030871
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	76lakdyczwss	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 06:54:38.601726+00	2026-04-12 06:54:38.601726+00	\N	70e28599-c044-4820-9caa-dc3359e2d30c
00000000-0000-0000-0000-000000000000	2	qadug6jyhpws	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 06:56:11.760637+00	2026-04-12 06:56:11.760637+00	\N	44ec12c8-3a92-4390-88c3-bff0d0d75518
00000000-0000-0000-0000-000000000000	3	k2fpobni74yd	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 06:57:07.413442+00	2026-04-12 06:57:07.413442+00	\N	eb52b761-9400-4c4e-b3e6-6f767dc173f7
00000000-0000-0000-0000-000000000000	4	hj4vllricvh6	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 07:14:07.209726+00	2026-04-12 07:14:07.209726+00	\N	b0024629-c99e-443e-ad94-16e30795c577
00000000-0000-0000-0000-000000000000	5	ut32mos2q5oi	9ed09247-a87c-4024-9376-3e3ca428cabb	f	2026-04-12 07:14:52.827792+00	2026-04-12 07:14:52.827792+00	\N	62c21852-926d-4ab3-be87-48b8ce942519
00000000-0000-0000-0000-000000000000	6	j5xyvmbg5quk	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 07:16:19.900214+00	2026-04-12 07:16:19.900214+00	\N	9a9aaf50-0619-4728-880c-40f9f29461f4
00000000-0000-0000-0000-000000000000	7	xljef7t2ifs7	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 07:25:51.721728+00	2026-04-12 07:25:51.721728+00	\N	4b3a7f55-05b7-4d93-b771-f5990199f60b
00000000-0000-0000-0000-000000000000	8	qamiyg7n3vbu	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 07:27:36.133026+00	2026-04-12 07:27:36.133026+00	\N	f5714753-4777-47fc-b863-91ec0acbc0e7
00000000-0000-0000-0000-000000000000	9	v3qcisgz5nnr	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 07:28:15.931309+00	2026-04-12 07:28:15.931309+00	\N	8913692c-0417-4694-8f67-bd2080d0c772
00000000-0000-0000-0000-000000000000	10	7seaq3xk2hz2	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 07:33:19.41369+00	2026-04-12 07:33:19.41369+00	\N	317e516c-72e7-4073-807a-0f589a746627
00000000-0000-0000-0000-000000000000	11	ubl6gzigp4rc	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 07:38:38.576023+00	2026-04-12 07:38:38.576023+00	\N	1d11e31f-60f3-454f-b60e-a5ffaa108345
00000000-0000-0000-0000-000000000000	12	pd636kgfhy3v	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	f	2026-04-12 07:39:36.564478+00	2026-04-12 07:39:36.564478+00	\N	33ea2b77-6989-49b5-84e8-5eecb8e53ca3
00000000-0000-0000-0000-000000000000	13	ko6sqczr47om	9ed09247-a87c-4024-9376-3e3ca428cabb	f	2026-04-12 07:43:22.71465+00	2026-04-12 07:43:22.71465+00	\N	1730986d-8121-4daa-8bd6-58dfa4bbaa88
00000000-0000-0000-0000-000000000000	14	2nu6lmg5xsj7	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 07:44:08.485136+00	2026-04-12 07:44:08.485136+00	\N	eb7e7090-f461-42d7-92e9-3114b64af1a0
00000000-0000-0000-0000-000000000000	15	wuxyaugqz7jz	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 07:44:36.769943+00	2026-04-12 07:44:36.769943+00	\N	5a657a1b-b2b5-4cec-af11-28447c4e5af5
00000000-0000-0000-0000-000000000000	16	epq3o2qe3ao6	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:00:19.489868+00	2026-04-12 08:00:19.489868+00	\N	57b00840-105e-4a3a-9e72-926ec288da59
00000000-0000-0000-0000-000000000000	17	nwvyocg53nba	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:01:13.340878+00	2026-04-12 08:01:13.340878+00	\N	17e5f75f-5777-463b-84b6-0a22ed27089a
00000000-0000-0000-0000-000000000000	18	g3xgrcl37coy	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:02:08.82285+00	2026-04-12 08:02:08.82285+00	\N	198173c1-2d02-4fab-8d37-bb09e231e747
00000000-0000-0000-0000-000000000000	19	7fg3ol3wpx7h	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:12:53.328623+00	2026-04-12 08:12:53.328623+00	\N	988aba8d-7389-41ee-8b62-c9e8f9979c19
00000000-0000-0000-0000-000000000000	20	bt44sy3ufov5	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:13:11.20938+00	2026-04-12 08:13:11.20938+00	\N	998c17e2-a2db-495e-b81f-b2ae06c6800c
00000000-0000-0000-0000-000000000000	21	awk3q54nwedc	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:14:43.659929+00	2026-04-12 08:14:43.659929+00	\N	8b7bbb46-ade2-4424-bfa0-97d2c224dd7d
00000000-0000-0000-0000-000000000000	22	xfn5mivvffpb	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:22:40.633934+00	2026-04-12 08:22:40.633934+00	\N	4ac2d29e-c274-45dd-8131-2e6b3f7cee21
00000000-0000-0000-0000-000000000000	23	hw2vbcejari5	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:22:59.000041+00	2026-04-12 08:22:59.000041+00	\N	5f488689-f5a5-41a5-8f50-66b73d5ebef6
00000000-0000-0000-0000-000000000000	24	2mxeh2v3jzpz	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:23:45.028762+00	2026-04-12 08:23:45.028762+00	\N	47c0259f-c7f3-4ec7-8512-141d7af43c25
00000000-0000-0000-0000-000000000000	25	vj3pvfqkv74h	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:25:28.826857+00	2026-04-12 08:25:28.826857+00	\N	0374fef6-e638-4589-903a-9040e1cf9be5
00000000-0000-0000-0000-000000000000	26	gtkrs2nni4gc	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:26:47.401714+00	2026-04-12 08:26:47.401714+00	\N	d2466f38-6910-49b0-9865-161d8051312a
00000000-0000-0000-0000-000000000000	27	2tcjg3dsvvdi	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:29:12.94565+00	2026-04-12 08:29:12.94565+00	\N	ff9ea1cd-bde2-486b-8041-d648b4d97e56
00000000-0000-0000-0000-000000000000	28	k2v2lx7saj6l	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:35:06.026041+00	2026-04-12 08:35:06.026041+00	\N	83570ac7-df27-46c6-a7bf-123925ebe3a7
00000000-0000-0000-0000-000000000000	29	q4esxdtao6qh	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:37:38.445069+00	2026-04-12 08:37:38.445069+00	\N	1d250f4a-1867-4e12-a3ec-62d43c10fedd
00000000-0000-0000-0000-000000000000	30	o6cygnzopbuv	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:41:25.448812+00	2026-04-12 08:41:25.448812+00	\N	40ee7ab7-f3c3-482a-86e8-ee5df35fc1f6
00000000-0000-0000-0000-000000000000	31	3gosfh45jc3j	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:42:09.412211+00	2026-04-12 08:42:09.412211+00	\N	4531c6cb-5263-4cbd-9333-00aab4491e73
00000000-0000-0000-0000-000000000000	32	v3hg5cnbplh6	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:43:56.031637+00	2026-04-12 08:43:56.031637+00	\N	1a1ec76b-9f17-4970-9c26-b645197ee467
00000000-0000-0000-0000-000000000000	33	zipst5qfkmuy	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:52:43.048185+00	2026-04-12 08:52:43.048185+00	\N	a3451bb1-2ad8-4d6f-aae1-7eae0dfbea37
00000000-0000-0000-0000-000000000000	34	mnk4gycns23h	590ccd8f-fc79-40f8-9083-f382ba41c5a0	f	2026-04-12 08:53:45.758299+00	2026-04-12 08:53:45.758299+00	\N	93e090f3-3490-43b2-bdb4-4cf4d5c94ad7
00000000-0000-0000-0000-000000000000	35	abyagmilk55c	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:54:08.515054+00	2026-04-12 08:54:08.515054+00	\N	0394355c-b37f-4601-8175-a61bcde4f669
00000000-0000-0000-0000-000000000000	36	7lae7jyexlmg	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 08:59:19.141316+00	2026-04-12 08:59:19.141316+00	\N	a9a478d8-a587-467f-94f9-3a22d75ae01c
00000000-0000-0000-0000-000000000000	37	wzgebulxlztw	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 09:10:08.236368+00	2026-04-12 09:10:08.236368+00	\N	eabc6258-8702-4fc3-bfaf-cb596726f911
00000000-0000-0000-0000-000000000000	38	cqdarlrq6dm3	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 09:18:04.205622+00	2026-04-12 09:18:04.205622+00	\N	a2f52e62-d0ea-473e-9eab-d4c70ac9c55b
00000000-0000-0000-0000-000000000000	39	zulstqgunqhm	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 10:02:56.172968+00	2026-04-12 10:02:56.172968+00	\N	acb27357-58fc-4ed2-abb7-36ffcaa36a8d
00000000-0000-0000-0000-000000000000	40	5bkw43uj4hnv	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-12 10:09:04.863797+00	2026-04-12 11:11:54.955958+00	\N	d5ff706f-d656-4ace-ae57-217cc33bb0b7
00000000-0000-0000-0000-000000000000	41	gfvittdfytw3	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 11:11:54.97043+00	2026-04-12 11:11:54.97043+00	5bkw43uj4hnv	d5ff706f-d656-4ace-ae57-217cc33bb0b7
00000000-0000-0000-0000-000000000000	42	hrpjelttukld	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 12:11:01.042725+00	2026-04-12 12:11:01.042725+00	\N	cb36f83c-fd15-4016-af45-efc40da11cb9
00000000-0000-0000-0000-000000000000	43	ccdadnviiqu6	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 12:11:20.250334+00	2026-04-12 12:11:20.250334+00	\N	82497aef-7996-4a60-b664-c1038f8578b2
00000000-0000-0000-0000-000000000000	44	ebgwdew3n7bq	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-12 12:11:32.154593+00	2026-04-12 13:17:46.310537+00	\N	af0232f5-3467-48b9-87da-f072e07cc054
00000000-0000-0000-0000-000000000000	45	xn3o2ijx6jsq	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 13:17:46.32322+00	2026-04-12 13:17:46.32322+00	ebgwdew3n7bq	af0232f5-3467-48b9-87da-f072e07cc054
00000000-0000-0000-0000-000000000000	46	vjig45mizeae	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-12 13:28:56.755676+00	2026-04-12 13:28:56.755676+00	\N	8177222e-b190-490e-b09c-7fb2e1500014
00000000-0000-0000-0000-000000000000	47	brjw3p3a2pud	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-12 13:29:04.464627+00	2026-04-13 13:29:11.228811+00	\N	fceccb5e-7d18-4979-a937-447443e93afb
00000000-0000-0000-0000-000000000000	51	e5hxqbmcifks	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-14 00:53:56.391744+00	2026-04-14 00:53:56.391744+00	\N	88c27403-ae9a-4188-8322-771a6aa4b253
00000000-0000-0000-0000-000000000000	52	g6ksicvdnjdo	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-14 00:53:57.501164+00	2026-04-14 03:02:59.029307+00	\N	47d9e75f-7c12-4a54-bb85-5670690a5920
00000000-0000-0000-0000-000000000000	50	zpnx2mi32l5s	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-13 13:29:11.242088+00	2026-04-14 11:11:45.017748+00	brjw3p3a2pud	fceccb5e-7d18-4979-a937-447443e93afb
00000000-0000-0000-0000-000000000000	49	antxmvbcpbp5	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-13 06:49:02.308964+00	2026-04-20 02:10:12.560366+00	\N	a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7
00000000-0000-0000-0000-000000000000	53	ysisd3r45dvp	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-14 03:02:59.047017+00	2026-04-20 03:27:23.059551+00	g6ksicvdnjdo	47d9e75f-7c12-4a54-bb85-5670690a5920
00000000-0000-0000-0000-000000000000	48	pvvvwo3kq54q	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-13 06:44:43.395318+00	2026-04-21 01:46:35.187023+00	\N	224f3ec1-596c-4e02-a193-1dc9634cb673
00000000-0000-0000-0000-000000000000	54	fmhavoadvvmw	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-14 11:11:45.037287+00	2026-04-14 11:11:45.037287+00	zpnx2mi32l5s	fceccb5e-7d18-4979-a937-447443e93afb
00000000-0000-0000-0000-000000000000	55	t5xy7xr45ovt	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-14 12:39:39.986024+00	2026-04-14 13:42:35.567934+00	\N	1b9a93df-fe78-4a97-9759-93221841dbb4
00000000-0000-0000-0000-000000000000	56	hk4qhs7jbjd2	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-14 13:42:35.577086+00	2026-04-14 13:42:35.577086+00	t5xy7xr45ovt	1b9a93df-fe78-4a97-9759-93221841dbb4
00000000-0000-0000-0000-000000000000	57	hurtp6w3t4u2	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-14 14:25:15.553425+00	2026-04-15 12:54:04.935526+00	\N	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	58	5sewnvecdiiu	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-15 12:54:04.956646+00	2026-04-15 14:23:55.043226+00	hurtp6w3t4u2	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	59	dzuwebj3wluf	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-15 14:23:55.047927+00	2026-04-16 12:08:28.833318+00	5sewnvecdiiu	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	60	v6mmaninys32	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-16 12:08:28.852966+00	2026-04-19 07:38:09.572513+00	dzuwebj3wluf	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	61	so4b6uyia5pc	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 07:38:09.588499+00	2026-04-19 08:39:59.984061+00	v6mmaninys32	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	62	xbxga576lmnc	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 08:39:59.991934+00	2026-04-19 09:38:34.891324+00	so4b6uyia5pc	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	63	ygl7exknyqvh	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 09:38:34.89825+00	2026-04-19 10:51:21.465066+00	xbxga576lmnc	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	64	q4y4sfyubxto	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 10:51:21.471045+00	2026-04-19 12:02:21.721111+00	ygl7exknyqvh	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	65	nxmxaggdvoya	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 12:02:21.732209+00	2026-04-19 13:48:28.628256+00	q4y4sfyubxto	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	66	7fal5sndfos2	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 13:48:28.635435+00	2026-04-19 14:52:31.465579+00	nxmxaggdvoya	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	67	3csx65qhg77s	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 14:52:31.471299+00	2026-04-19 21:26:45.645047+00	7fal5sndfos2	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	68	ank3efrqt3n6	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-19 21:26:45.657365+00	2026-04-19 21:26:45.657365+00	3csx65qhg77s	9549d368-5056-405f-a422-c92faaf13179
00000000-0000-0000-0000-000000000000	69	hkyvqh5oqovk	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-19 21:26:45.706756+00	2026-04-19 21:26:45.706756+00	\N	747874ff-6458-417b-adc6-dd91adb64e75
00000000-0000-0000-0000-000000000000	70	xfrws6zwptdx	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 21:26:51.418846+00	2026-04-19 22:33:22.059794+00	\N	53502677-c2d9-44b8-9d6e-e8bb2dcb22bb
00000000-0000-0000-0000-000000000000	72	5zj4csn3o53c	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-20 02:04:57.084163+00	2026-04-20 03:05:50.345962+00	\N	d423eabb-c997-465c-b7f2-b46786e6ef70
00000000-0000-0000-0000-000000000000	74	opcu3ei37odd	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-20 03:05:50.35238+00	2026-04-20 03:05:50.35238+00	5zj4csn3o53c	d423eabb-c997-465c-b7f2-b46786e6ef70
00000000-0000-0000-0000-000000000000	73	gy7xkgkj4vnt	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-20 02:10:12.566319+00	2026-04-20 03:27:24.9304+00	antxmvbcpbp5	a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7
00000000-0000-0000-0000-000000000000	75	5my5ay62oxem	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-20 03:27:23.068334+00	2026-04-20 04:59:15.501892+00	ysisd3r45dvp	47d9e75f-7c12-4a54-bb85-5670690a5920
00000000-0000-0000-0000-000000000000	76	sgi3zlobtm3d	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-20 03:27:24.931322+00	2026-04-20 06:29:39.190658+00	gy7xkgkj4vnt	a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7
00000000-0000-0000-0000-000000000000	77	u4kvogsi54fz	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-20 04:59:15.514953+00	2026-04-20 06:52:13.647281+00	5my5ay62oxem	47d9e75f-7c12-4a54-bb85-5670690a5920
00000000-0000-0000-0000-000000000000	78	jsvhbouaankm	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-20 06:29:39.197713+00	2026-04-20 07:49:47.450056+00	sgi3zlobtm3d	a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7
00000000-0000-0000-0000-000000000000	79	uvig3ubrzwfm	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-20 06:52:13.661579+00	2026-04-20 08:56:42.705518+00	u4kvogsi54fz	47d9e75f-7c12-4a54-bb85-5670690a5920
00000000-0000-0000-0000-000000000000	81	xvuc2cfrgklu	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-20 08:56:42.715531+00	2026-04-20 08:56:42.715531+00	uvig3ubrzwfm	47d9e75f-7c12-4a54-bb85-5670690a5920
00000000-0000-0000-0000-000000000000	71	xgquf6l3ulcm	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-19 22:33:22.070339+00	2026-04-20 13:35:16.709397+00	xfrws6zwptdx	53502677-c2d9-44b8-9d6e-e8bb2dcb22bb
00000000-0000-0000-0000-000000000000	82	je6qw65qosa6	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-20 13:35:16.721953+00	2026-04-20 13:35:16.721953+00	xgquf6l3ulcm	53502677-c2d9-44b8-9d6e-e8bb2dcb22bb
00000000-0000-0000-0000-000000000000	80	25cezqerxdxx	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-20 07:49:47.455856+00	2026-04-21 01:36:40.71068+00	jsvhbouaankm	a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7
00000000-0000-0000-0000-000000000000	84	dq5frkosp4z4	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-21 01:46:35.194459+00	2026-04-21 01:46:35.194459+00	pvvvwo3kq54q	224f3ec1-596c-4e02-a193-1dc9634cb673
00000000-0000-0000-0000-000000000000	83	onyzb2r6b5st	691769f3-9978-472b-9fb5-62c15543d7d9	t	2026-04-21 01:36:40.728964+00	2026-04-21 02:41:09.501957+00	25cezqerxdxx	a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7
00000000-0000-0000-0000-000000000000	85	6n34lnpyarac	691769f3-9978-472b-9fb5-62c15543d7d9	f	2026-04-21 02:41:09.514587+00	2026-04-21 02:41:09.514587+00	onyzb2r6b5st	a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
70e28599-c044-4820-9caa-dc3359e2d30c	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 06:54:38.595098+00	2026-04-12 06:54:38.595098+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
44ec12c8-3a92-4390-88c3-bff0d0d75518	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 06:56:11.756147+00	2026-04-12 06:56:11.756147+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
eb52b761-9400-4c4e-b3e6-6f767dc173f7	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 06:57:07.409736+00	2026-04-12 06:57:07.409736+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
b0024629-c99e-443e-ad94-16e30795c577	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 07:14:07.197684+00	2026-04-12 07:14:07.197684+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
62c21852-926d-4ab3-be87-48b8ce942519	9ed09247-a87c-4024-9376-3e3ca428cabb	2026-04-12 07:14:52.826825+00	2026-04-12 07:14:52.826825+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
9a9aaf50-0619-4728-880c-40f9f29461f4	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 07:16:19.897624+00	2026-04-12 07:16:19.897624+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
4b3a7f55-05b7-4d93-b771-f5990199f60b	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 07:25:51.716033+00	2026-04-12 07:25:51.716033+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
f5714753-4777-47fc-b863-91ec0acbc0e7	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 07:27:36.124902+00	2026-04-12 07:27:36.124902+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
8913692c-0417-4694-8f67-bd2080d0c772	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 07:28:15.930132+00	2026-04-12 07:28:15.930132+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
317e516c-72e7-4073-807a-0f589a746627	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 07:33:19.407356+00	2026-04-12 07:33:19.407356+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
1d11e31f-60f3-454f-b60e-a5ffaa108345	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 07:38:38.572262+00	2026-04-12 07:38:38.572262+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
33ea2b77-6989-49b5-84e8-5eecb8e53ca3	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	2026-04-12 07:39:36.562559+00	2026-04-12 07:39:36.562559+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
1730986d-8121-4daa-8bd6-58dfa4bbaa88	9ed09247-a87c-4024-9376-3e3ca428cabb	2026-04-12 07:43:22.706308+00	2026-04-12 07:43:22.706308+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
eb7e7090-f461-42d7-92e9-3114b64af1a0	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 07:44:08.483975+00	2026-04-12 07:44:08.483975+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
5a657a1b-b2b5-4cec-af11-28447c4e5af5	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 07:44:36.768499+00	2026-04-12 07:44:36.768499+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
57b00840-105e-4a3a-9e72-926ec288da59	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:00:19.483159+00	2026-04-12 08:00:19.483159+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
17e5f75f-5777-463b-84b6-0a22ed27089a	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:01:13.334547+00	2026-04-12 08:01:13.334547+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
198173c1-2d02-4fab-8d37-bb09e231e747	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:02:08.821573+00	2026-04-12 08:02:08.821573+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
988aba8d-7389-41ee-8b62-c9e8f9979c19	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:12:53.324302+00	2026-04-12 08:12:53.324302+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
998c17e2-a2db-495e-b81f-b2ae06c6800c	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:13:11.20751+00	2026-04-12 08:13:11.20751+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
8b7bbb46-ade2-4424-bfa0-97d2c224dd7d	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:14:43.657905+00	2026-04-12 08:14:43.657905+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
4ac2d29e-c274-45dd-8131-2e6b3f7cee21	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:22:40.625739+00	2026-04-12 08:22:40.625739+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
5f488689-f5a5-41a5-8f50-66b73d5ebef6	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:22:58.997493+00	2026-04-12 08:22:58.997493+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
47c0259f-c7f3-4ec7-8512-141d7af43c25	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:23:45.026937+00	2026-04-12 08:23:45.026937+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
0374fef6-e638-4589-903a-9040e1cf9be5	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:25:28.821574+00	2026-04-12 08:25:28.821574+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
d2466f38-6910-49b0-9865-161d8051312a	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:26:47.399893+00	2026-04-12 08:26:47.399893+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
ff9ea1cd-bde2-486b-8041-d648b4d97e56	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:29:12.943848+00	2026-04-12 08:29:12.943848+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
83570ac7-df27-46c6-a7bf-123925ebe3a7	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:35:06.02035+00	2026-04-12 08:35:06.02035+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
1d250f4a-1867-4e12-a3ec-62d43c10fedd	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:37:38.439875+00	2026-04-12 08:37:38.439875+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
40ee7ab7-f3c3-482a-86e8-ee5df35fc1f6	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:41:25.443698+00	2026-04-12 08:41:25.443698+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
4531c6cb-5263-4cbd-9333-00aab4491e73	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:42:09.410879+00	2026-04-12 08:42:09.410879+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
1a1ec76b-9f17-4970-9c26-b645197ee467	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:43:56.029898+00	2026-04-12 08:43:56.029898+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	182.253.51.254	\N	\N	\N	\N	\N
a3451bb1-2ad8-4d6f-aae1-7eae0dfbea37	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:52:43.030981+00	2026-04-12 08:52:43.030981+00	\N	aal1	\N	\N	node	182.253.51.254	\N	\N	\N	\N	\N
93e090f3-3490-43b2-bdb4-4cf4d5c94ad7	590ccd8f-fc79-40f8-9083-f382ba41c5a0	2026-04-12 08:53:45.730154+00	2026-04-12 08:53:45.730154+00	\N	aal1	\N	\N	node	182.253.51.254	\N	\N	\N	\N	\N
0394355c-b37f-4601-8175-a61bcde4f669	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:54:08.513842+00	2026-04-12 08:54:08.513842+00	\N	aal1	\N	\N	node	182.253.51.254	\N	\N	\N	\N	\N
a9a478d8-a587-467f-94f9-3a22d75ae01c	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 08:59:19.120305+00	2026-04-12 08:59:19.120305+00	\N	aal1	\N	\N	node	182.253.51.254	\N	\N	\N	\N	\N
eabc6258-8702-4fc3-bfaf-cb596726f911	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 09:10:08.226464+00	2026-04-12 09:10:08.226464+00	\N	aal1	\N	\N	node	182.253.51.254	\N	\N	\N	\N	\N
a2f52e62-d0ea-473e-9eab-d4c70ac9c55b	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 09:18:04.200487+00	2026-04-12 09:18:04.200487+00	\N	aal1	\N	\N	node	182.253.51.254	\N	\N	\N	\N	\N
acb27357-58fc-4ed2-abb7-36ffcaa36a8d	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 10:02:56.165415+00	2026-04-12 10:02:56.165415+00	\N	aal1	\N	\N	node	182.253.51.254	\N	\N	\N	\N	\N
d5ff706f-d656-4ace-ae57-217cc33bb0b7	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 10:09:04.846837+00	2026-04-12 12:11:00.95646+00	\N	aal1	\N	2026-04-12 12:11:00.956362	node	182.253.51.136	\N	\N	\N	\N	\N
82497aef-7996-4a60-b664-c1038f8578b2	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 12:11:20.234825+00	2026-04-12 12:11:20.234825+00	\N	aal1	\N	\N	node	182.253.51.136	\N	\N	\N	\N	\N
cb36f83c-fd15-4016-af45-efc40da11cb9	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 12:11:01.030971+00	2026-04-12 12:11:01.030971+00	\N	aal1	\N	\N	node	182.253.51.136	\N	\N	\N	\N	\N
af0232f5-3467-48b9-87da-f072e07cc054	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 12:11:32.153232+00	2026-04-12 13:28:56.619418+00	\N	aal1	\N	2026-04-12 13:28:56.619315	node	182.253.51.136	\N	\N	\N	\N	\N
88c27403-ae9a-4188-8322-771a6aa4b253	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-14 00:53:56.357564+00	2026-04-14 00:53:56.357564+00	\N	aal1	\N	\N	node	180.249.184.1	\N	\N	\N	\N	\N
8177222e-b190-490e-b09c-7fb2e1500014	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 13:28:56.743919+00	2026-04-12 13:28:56.743919+00	\N	aal1	\N	\N	node	182.253.51.136	\N	\N	\N	\N	\N
47d9e75f-7c12-4a54-bb85-5670690a5920	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-14 00:53:57.49367+00	2026-04-20 08:56:42.768243+00	\N	aal1	\N	2026-04-20 08:56:42.768087	node	182.253.52.181	\N	\N	\N	\N	\N
53502677-c2d9-44b8-9d6e-e8bb2dcb22bb	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 21:26:51.417792+00	2026-04-20 14:04:12.062976+00	\N	aal1	\N	2026-04-20 14:04:12.062885	node	182.253.51.245	\N	\N	\N	\N	\N
9549d368-5056-405f-a422-c92faaf13179	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-14 14:25:15.540715+00	2026-04-19 21:26:45.679586+00	\N	aal1	\N	2026-04-19 21:26:45.679481	node	182.253.51.245	\N	\N	\N	\N	\N
747874ff-6458-417b-adc6-dd91adb64e75	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 21:26:45.69722+00	2026-04-19 21:26:45.69722+00	\N	aal1	\N	\N	node	182.253.51.245	\N	\N	\N	\N	\N
224f3ec1-596c-4e02-a193-1dc9634cb673	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-13 06:44:43.362716+00	2026-04-21 01:51:24.802959+00	\N	aal1	\N	2026-04-21 01:51:24.802866	node	182.253.52.181	\N	\N	\N	\N	\N
d423eabb-c997-465c-b7f2-b46786e6ef70	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-20 02:04:57.067086+00	2026-04-20 03:05:50.396705+00	\N	aal1	\N	2026-04-20 03:05:50.396609	node	182.253.52.181	\N	\N	\N	\N	\N
a0ab29d6-1ff9-4d69-8a82-9ea4771a52d7	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-13 06:49:02.299056+00	2026-04-21 06:42:18.755509+00	\N	aal1	\N	2026-04-21 06:42:18.75531	node	182.253.52.181	\N	\N	\N	\N	\N
fceccb5e-7d18-4979-a937-447443e93afb	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-12 13:29:04.463374+00	2026-04-14 12:39:39.973583+00	\N	aal1	\N	2026-04-14 12:39:39.973435	node	182.253.51.136	\N	\N	\N	\N	\N
1b9a93df-fe78-4a97-9759-93221841dbb4	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-14 12:39:39.973844+00	2026-04-14 13:58:52.738709+00	\N	aal1	\N	2026-04-14 13:58:52.738615	node	182.253.51.136	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	0c6106a1-e594-45bc-8d80-26161d612a63	authenticated	authenticated	admin@admin.com	$2a$10$e2u1HufWvYL/RX0QvBvW8uOR2tNILnyJ6M5D2eK6H27iGt1gqizoy	\N	\N	3be0c3c614aa4302492a0ed496d39e398898ddfecf18f84598bdc4e7	2026-04-10 14:34:48.453854+00		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"sub": "0c6106a1-e594-45bc-8d80-26161d612a63", "email": "admin@admin.com", "full_name": "madegun", "email_verified": false, "phone_verified": false}	\N	2026-04-10 14:34:48.396707+00	2026-04-10 14:34:50.017216+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	691769f3-9978-472b-9fb5-62c15543d7d9	authenticated	authenticated	made@made.com	$2a$10$wfq36soJlt9vCkpnswfDyeT1uOBlW2oTQFEGw5eUnD/S19Aj3htwW	2026-04-12 07:44:08.476579+00	\N		\N		\N			\N	2026-04-20 02:04:57.066978+00	{"provider": "email", "providers": ["email"]}	{"sub": "691769f3-9978-472b-9fb5-62c15543d7d9", "email": "made@made.com", "full_name": "made", "email_verified": true, "phone_verified": false}	\N	2026-04-12 07:44:08.455393+00	2026-04-21 02:41:09.520973+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7	authenticated	authenticated	degun@admin.com	$2a$10$1sSOrIBRH4jnViX220ixsOk4qYWg/0k6VHhdtthXHRvIQ/WMTXnNe	2026-04-12 06:54:38.585515+00	\N		\N		\N			\N	2026-04-12 07:39:36.56245+00	{"provider": "email", "providers": ["email"]}	{"sub": "c4fa2bcd-f8f0-4d9a-97ce-24fa117fd5f7", "email": "degun@admin.com", "full_name": "madegun", "email_verified": true, "phone_verified": false}	\N	2026-04-12 06:54:38.557202+00	2026-04-12 07:39:36.566101+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	9ed09247-a87c-4024-9376-3e3ca428cabb	authenticated	authenticated	tes@admin.com	$2a$10$nzsA.1ZGtFm85pl3DbxfpezwZsa2G9Lk01YWECfJixyO7huv0IDBu	2026-04-12 07:14:52.821765+00	\N		\N		\N			\N	2026-04-12 07:43:22.706211+00	{"provider": "email", "providers": ["email"]}	{"sub": "9ed09247-a87c-4024-9376-3e3ca428cabb", "email": "tes@admin.com", "full_name": "tess", "email_verified": true, "phone_verified": false}	\N	2026-04-12 07:14:52.806692+00	2026-04-12 07:43:22.716572+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	590ccd8f-fc79-40f8-9083-f382ba41c5a0	authenticated	authenticated	wayan@wayan.com	$2a$10$pntTTUFuF3ucyhyI/5HIDO0CDgZv3Jfr1IBuwtXP950QYyPaUVh9u	2026-04-12 08:23:45.021717+00	\N		\N		\N			\N	2026-04-12 08:53:45.727219+00	{"provider": "email", "providers": ["email"]}	{"sub": "590ccd8f-fc79-40f8-9083-f382ba41c5a0", "email": "wayan@wayan.com", "full_name": "wayan", "email_verified": true, "phone_verified": false}	\N	2026-04-12 08:23:44.990948+00	2026-04-12 08:53:45.761321+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: apartments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apartments (id, slug, name, description, short_description, max_guests, bedrooms, base_price_cents, image_url, gallery_images, artistic_features, amenities, location_details, is_active, created_at, updated_at) FROM stdin;
739ebdf8-5ad7-46fb-aa3f-bae49305ec0d	ca-asia-app-1	Ca' Asia - App. 1	A luxury residence (110 mt2) with refined design, crafted by a renowned architect and enriched with touches inspired by the elegance of Venice and the aesthetics of Asia. \n\nLocated in the vibrant heart of Venice, it is just steps away from the city’s most iconic landmarks: Rialto Bridge (7 minutes), St. Mark’s Square (15 minutes), and the Basilica of Saints John and Paul (3 minutes). An exclusive location to explore the entire city.\n\nThe apartment is on the second floor (approximately 30 steps) of a private *calle* overlooking the northern lagoon. Thanks to this location, the environment is exceptionally peaceful and reserved, with only a few residents passing through. The absence of shops or restaurants nearby ensures a serene and restful stay.\n\nThe Interiors:\nThe apartment boasts unique, elegant, and comfortable spaces, fully equipped with modern amenities:\nA modern and fully equipped kitchen, perfect for preparing both local dishes and your preferred cuisine.\nThree tastefully decorated bedrooms, each designed with attention to detail. Two of the bedrooms feature en-suite bathrooms, ensuring an exclusive and private experience.\nThree bathrooms in total, all modern, functional, and finished with high-quality materials.\nAir conditioning throughout the apartment, ensuring maximum comfort in every season.\nA spacious, cozy living room with refined décor that creates a warm, relaxing atmosphere.\nMagnificent high ceilings adorned with intricate wooden beams add a sense of grandeur and highlight the architectural charm of the space.\n\nSmart TV  and a fast and reliable Wi-Fi\nA baby cot is available upon request, at no additional cost.\n\nThe Altana:\nThe highlight of the apartment is its splendid *altana*, a traditional Venetian rooftop terrace. This unique space offers breathtaking views of the northern lagoon and the city’s rooftops. It is perfect for enjoying an aperitif at sunset, dining al fresco, or starting your day with an unforgettable breakfast.\n\nThe Location:\nJust a 4-minute walk from the Fondamenta Nove vaporetto stop, connecting the apartment to all Venetian destinations and the water shuttle to/from the airport. - Surrounded by excellent restaurants and bars, with a pharmacy and a laundromat just 3 minutes away on foot. A one-of-a-kind retreat that combines exclusive design, modern comfort, and the charm of a traditional Venetian terrace for an unforgettable stay in the heart of Venice!\n\nSMOKING, PETS, AND PARTIES ARE NOT ALLOWED	A spacious 3 bedrooms apartment with designer interiors, Asian decorations and wonderful art pieces in the authentic heart of Venice	6	3	65000	https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/1ff4d004-db29-4c59-b68f-a72d8b02897a-1776667040420.jpg	{https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/1ff4d004-db29-4c59-b68f-a72d8b02897a-1776667040420.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/7e0e83e6-c038-41be-8b7c-dd0e01573b16-1776667065278.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/1191b4a7-b843-47b6-96a2-31524fafcbae-1776667074147.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/f6b0eef2-6dbf-463b-9f88-0aaf835f08f7-1776667077908.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/eaf22f7d-857a-45c9-ad13-18d9b2336af5-1776667084183.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/d61b7e00-acba-464d-8dce-183bd3f5e90e-1776667091276.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/fc4089e9-bbf1-4c5f-a12e-abaeb2c4f20d-1776667094843.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/6f00b76e-8235-4d24-8cec-e63cb035373d-1776667101074.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/5becf661-7abc-4307-ad83-71ab1ed0b625-1776667107367.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-asia-app-1/ce5becb5-b412-42ce-8266-e2ab29b8cb74-1776667138283.jpg}	{"High industrial ceilings","Concrete walls","Modern art installations","Dedicated art studio","Urban design elements"}	{Towels,"Bed Sheets","Bathroom Amenities","Hair dryer",AC,"Fully equipped Kitchen",Dishwasher,Wi-Fi,"Smart TV",Safe,Terrace,"Baby cot and high chair (on request)"}	{"address": "Industrial Arts District", "coordinates": {"lat": 1.2789, "lng": 103.8412}}	t	2026-04-12 07:12:39.148792+00	2026-04-21 02:27:55.731814+00
3f667c8f-1e9a-4385-9ed8-2b0cf44446d4	ca-biri-apt-2	Ca' Biri - Apt. 2	A charming and contemporary apartment set in the authentic heart of Venice, just a short walk from Rialto (7 minutes), St. Mark’s Square (15 minutes), and the Basilica of SS. Giovanni e Paolo (3 minutes). An ideal location to experience and explore the city with ease.\n\nThe apartment is located on the first floor (15 steps) in an exceptionally quiet and peaceful area. The calle is closed and opens onto the northern lagoon, with only a handful residents passing through. No nearby shops or restaurants means one rare luxury in Venice: complete tranquility and restful nights.\n\nInside, you’ll find a modern, fully equipped kitchen and fast Wi-Fi. The apartment offers two bedrooms, one of which is flexible and can be arranged either as a double (or twin beds) or transformed into a living area with two sofas. Just let us know your preferred setup. Each bedroom is equipped with online TV (Netflix) and air conditioning. A baby cot is available upon request at no additional cost.\n\nThe apartment is just 4 minutes from the Fondamente Nove vaporetto stop, with connections to all Venetian destinations and direct hydrofoil service to and from the airport. Excellent restaurants and bars are within easy reach, and a pharmacy and self-service laundry are conveniently located nearby (3 minutes).\n\nSMOKING, PETS, AND PARTIES ARE NOT ALLOWED	A charming and contemporary apartment set in the authentic heart of Venice, 	4	2	25000	https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/ac775915-efa2-4406-820d-eb3c543619c9-1776672327395.jpg	{https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/ac775915-efa2-4406-820d-eb3c543619c9-1776672327395.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/83199b58-98dd-443c-aad7-5de2ee0d696a-1776672335460.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/3cb07b0c-f16b-4c28-b1f4-8690175349b6-1776672340634.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/ffefe668-6cc6-468a-86ec-dd7072953b7a-1776672347415.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/631de58c-cd12-42ee-86a9-58969e705a15-1776672356342.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/0d5598b0-bb02-4952-af05-4b86c89547b8-1776672361155.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/479db910-2ed2-4a7a-9463-04362e2877ee-1776672369653.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/9bb913b0-47c4-43fe-8f98-a52d42f1c884-1776672380073.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/4a151392-845c-4902-809a-a34e776428ce-1776672388056.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-biri-apt-2/14bf294a-c7e6-4dfd-9240-1df07ca29c80-1776672412384.jpg}	{"Floor-to-ceiling windows","Natural light optimization","Scandinavian minimalist design","Artist workspace"}	{Towels,"Bed Sheets","Bathroom Amenities","Hair dryer",AC,"Fully equipped kitchen",Wi-Fi,"Smart TV",Safe,"Baby cot and high chair (on request)"}	{"address": "Downtown Art District", "coordinates": {"lat": 1.3521, "lng": 103.8198}}	t	2026-04-12 07:12:39.148792+00	2026-04-21 02:28:10.735719+00
d0e3aa54-8367-4f32-a6a6-d656bac9db01	ca-tera-apt-3	Ca' Tera' - Apt. 3	A charming and contemporary apartment set in the authentic heart of Venice, just a short walk from Rialto (7 minutes), St. Mark’s Square (15 minutes), and the Basilica of SS. Giovanni e Paolo (3 minutes). An ideal location to experience and explore the city with ease.\n\nThe apartment is located on the first floor (15 steps) in an exceptionally quiet and peaceful area. The calle is closed and opens onto the northern lagoon, with only a handful residents passing through. No nearby shops or restaurants means one rare luxury in Venice: complete tranquility and restful nights.\n\nInside, you’ll find a modern, fully equipped kitchen and fast Wi-Fi. The apartment offers two bedrooms, one of which is flexible and can be arranged either as a double (or twin beds) or transformed into a living area with two sofas. Just let us know your preferred setup. Each bedroom is equipped with online TV (Netflix) and air conditioning. A baby cot is available upon request at no additional cost.\n\nThe apartment is just 4 minutes from the Fondamente Nove vaporetto stop, with connections to all Venetian destinations and direct hydrofoil service to and from the airport. Excellent restaurants and bars are within easy reach, and a pharmacy and self-service laundry are conveniently located nearby (3 minutes).\n\nSMOKING, PETS, AND PARTIES ARE NOT ALLOWED	A charming and contemporary apartment set in the authentic heart of Venice..	4	2	25000	https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/92fb3cb8-1fcf-4adc-a3f0-cadc8d8f4a32-1776672478145.jpg	{https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/92fb3cb8-1fcf-4adc-a3f0-cadc8d8f4a32-1776672478145.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/f26cb595-0c77-4913-9deb-54fc19d24176-1776672482841.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/841c8623-83be-46ea-b2c9-808b6957d5cf-1776672486195.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/a1242e3a-2028-4123-9121-2a6a5bc9dd29-1776672489699.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/b81d8dd0-4f54-4604-b71b-40af20f78e43-1776672512725.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/dd6242aa-a805-48e1-864e-d6cd1c0cf600-1776672519714.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/97de23a0-9528-4e7c-98f3-b6f277f9833b-1776672523807.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/34bc3153-a7c3-4a15-8bbe-f702ef8c4aef-1776672528812.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/d4f90eca-19cd-4805-b742-8cda51ce399e-1776672532453.jpg,https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/ca-tera-apt-3/2a7663d8-6ef7-4aeb-946f-88bcb94e5f32-1776672556539.jpg}	{"Panoramic city views","Private rooftop terrace","Professional art studio","Natural northern light","Premium finishes"}	{Towels,"Bed Sheets","Bathroom Amenities","Hair dryer",AC,"Fully equipped kitchen",Wi-Fi,"Smart TV",Safe,"Baby cot and high chair (on request)"}	{"address": "Luxury Arts Tower", "coordinates": {"lat": 1.2834, "lng": 103.8607}}	t	2026-04-12 07:12:39.148792+00	2026-04-21 02:27:38.82755+00
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, user_id, apartment_id, check_in_date, check_out_date, total_guests, total_cents, status, special_requests, contact_info, created_at, updated_at) FROM stdin;
56981aea-c58b-4fd3-9d4d-29b51b370fb9	691769f3-9978-472b-9fb5-62c15543d7d9	3f667c8f-1e9a-4385-9ed8-2b0cf44446d4	2026-04-19	2026-04-20	2	25000	cancelled	note request	{"guest_name": "kakgun", "guest_email": "admin@admin.com", "guest_phone": "+624545676786"}	2026-04-19 08:40:01.024074+00	2026-04-19 09:55:24.459+00
3359dd1b-4860-41e7-8ba9-af7e7e7658c6	691769f3-9978-472b-9fb5-62c15543d7d9	d0e3aa54-8367-4f32-a6a6-d656bac9db01	2026-04-19	2026-04-20	2	95000	confirmed	note for michele	{"guest_name": "Michele", "guest_email": "Michele@gmail.com", "guest_phone": "+624545676786"}	2026-04-19 10:38:25.065728+00	2026-04-19 10:40:20.735+00
6e5b88d5-29ed-4b0d-951f-346c20d7c98c	691769f3-9978-472b-9fb5-62c15543d7d9	3f667c8f-1e9a-4385-9ed8-2b0cf44446d4	2026-04-19	2026-04-20	2	25000	completed	\N	{"guest_name": "jhon doe", "guest_email": "jhon@doe.com", "guest_phone": "+624545676786"}	2026-04-19 09:33:21.284055+00	2026-04-19 10:43:02.928+00
556ddecf-4221-4643-814d-4c23f4814fa0	691769f3-9978-472b-9fb5-62c15543d7d9	d0e3aa54-8367-4f32-a6a6-d656bac9db01	2026-04-19	2026-04-20	2	95000	cancelled	note special	{"guest_name": "kakgun", "guest_email": "admin@admin.com", "guest_phone": "+624545676786"}	2026-04-19 07:42:06.252363+00	2026-04-19 10:43:25.741+00
8e125466-29f6-4f17-b459-5c11da8684e2	691769f3-9978-472b-9fb5-62c15543d7d9	3f667c8f-1e9a-4385-9ed8-2b0cf44446d4	2026-04-19	2026-04-20	4	25000	confirmed	note for paull	{"guest_name": "Paull", "guest_email": "paull@gmail.com", "guest_phone": "+624545676786"}	2026-04-19 11:00:40.948918+00	2026-04-19 11:07:00.224+00
a7bcc697-51fc-4127-a6bf-6bae9bf17029	691769f3-9978-472b-9fb5-62c15543d7d9	739ebdf8-5ad7-46fb-aa3f-bae49305ec0d	2026-05-01	2026-05-02	3	65000	confirmed	dorce notes	{"guest_name": "Dorce", "guest_email": "dorce@gmail.com", "guest_phone": "+624545676786"}	2026-04-19 11:34:00.448162+00	2026-04-19 11:37:57.225+00
7e4c7cbc-ca3e-48f3-84e5-f5805637bd0d	691769f3-9978-472b-9fb5-62c15543d7d9	739ebdf8-5ad7-46fb-aa3f-bae49305ec0d	2026-04-29	2026-05-02	2	195000	pending	\N	{"guest_name": "Marcello Massoni", "guest_email": "marcello@gayaceramic.com", "guest_phone": "+628174745035"}	2026-04-20 02:22:52.643076+00	2026-04-20 02:22:52.643076+00
83ce5d45-c57c-4148-b9f9-c3eeebcb9afe	691769f3-9978-472b-9fb5-62c15543d7d9	739ebdf8-5ad7-46fb-aa3f-bae49305ec0d	2026-04-29	2026-05-02	2	195000	pending	\N	{"guest_name": "Marcello Massoni", "guest_email": "marcello@gayaceramic.com", "guest_phone": "+628174745035"}	2026-04-20 02:23:57.519981+00	2026-04-20 02:23:57.519981+00
de2fd5d2-898c-428c-9332-4247c337aeb5	691769f3-9978-472b-9fb5-62c15543d7d9	3f667c8f-1e9a-4385-9ed8-2b0cf44446d4	2026-04-20	2026-04-21	2	25000	pending	\N	{"guest_name": "julio", "guest_email": "julio@gmail.com", "guest_phone": "123456"}	2026-04-20 02:28:36.069507+00	2026-04-20 02:28:36.069507+00
83f6970e-b367-42d8-9a99-ef79ed42f81c	691769f3-9978-472b-9fb5-62c15543d7d9	d0e3aa54-8367-4f32-a6a6-d656bac9db01	2026-04-20	2026-04-21	2	95000	confirmed	\N	{"guest_name": "andrea", "guest_email": "andrea@gmail.com", "guest_phone": "+62123456789"}	2026-04-20 03:07:39.699354+00	2026-04-20 03:09:16.367+00
50107da1-0f38-41f8-8e42-fb6d25b65fda	691769f3-9978-472b-9fb5-62c15543d7d9	739ebdf8-5ad7-46fb-aa3f-bae49305ec0d	2026-04-29	2026-05-02	4	195000	confirmed	\N	{"guest_name": "Marcello Massoni", "guest_email": "marcello@gayaceramic.com", "guest_phone": "+628174745035"}	2026-04-20 08:00:40.370522+00	2026-04-20 08:02:16.109+00
\.


--
-- Data for Name: content_revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_revisions (id, section_id, key, payload, version, published_by, published_at) FROM stdin;
aae79b7c-a1df-4faa-8920-89c084fd69a5	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920", "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1920"]}, "about": {"title": {"en": "", "it": ""}, "content": {"en": "", "it": ""}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	5	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 13:50:28.486493+00
abfa45cc-334c-40cf-8e97-3dda0ba256ec	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920", "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1920"]}, "about": {"title": {"en": "made About Venice Parcley", "it": "Chi Siamo"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	7	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 13:51:42.628966+00
d588320c-0f38-42dd-8917-d43ad1085e97	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Made Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920", "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1920"]}, "about": {"title": {"en": "", "it": ""}, "content": {"en": "", "it": ""}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	9	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 13:56:05.33314+00
2d907bdc-22af-49fb-ad32-271bd9297021	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "", "it": ""}, "content": {"en": "", "it": ""}}, "intro": {"title": {"en": "Life at Shoreline, wrapped in artful calm and cinematic sea light.", "it": "La vita a Shoreline, avvolta da una calma sapientemente studiata e da una luce marina da film."}, "tagline": {"en": "made SHORELINE VIBES", "it": "ATMOSFERA DI COSTA"}, "description": {"en": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays.", "it": "Lasciatevi trasportare da spazi curati nei minimi dettagli, atmosfere costiere e ritmi esclusivi pensati per ospiti che apprezzano soggiorni all'insegna del design."}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	11	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 14:22:17.600523+00
bddd99e2-20f5-4b93-a441-8cf1eb2fd501	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "", "it": ""}, "content": {"en": "", "it": ""}}, "intro": {"title": {"en": "Life in the Heart of Venice.", "it": "Vita nel cuore di Venezia."}, "tagline": {"en": "SHORELINE VIBES", "it": "ATMOSFERA DI COSTA"}, "description": {"en": "Intimate stays where timeless Venetian character meets understated contemporary living elegance. Central. Private. Effortless.", "it": "Soggiorni intimi dove il fascino intramontabile di Venezia incontra la sobria eleganza del vivere contemporaneo. Centrale. Riservato. Senza sforzo."}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	13	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 14:24:23.357265+00
63b4a9ff-bd27-4c29-a0fe-134a90f51eaf	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "", "it": ""}, "content": {"en": "", "it": ""}}, "intro": {"title": {"en": "", "it": ""}, "tagline": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in evidenza"}, "description": {"en": "Designed for discerning travelers, each residence offers a calm and curated atmosphere, just steps from the city's most iconic landmarks.\\r\\nThoughtful details, refined materials, and a sense of quiet exclusivity.", "it": "Pensate per viaggiatori esigenti, ogni residenza offre un'atmosfera tranquilla e raffinata, a pochi passi dai luoghi più iconici della città.\\r\\nDettagli curati, materiali pregiati e un senso di serena esclusività."}}}	15	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 14:26:24.289847+00
52dd1729-bc57-49dd-8200-487bba1e76e7	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "Made About Venice Parcley", "it": "Chi Siamo"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "", "it": ""}, "tagline": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	17	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 14:41:04.037916+00
4edcfa9d-ace7-4282-a8ae-8c60234f3ebb	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "Made About Venice Parcley", "it": "Chi Siamo"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "", "it": ""}, "tagline": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	18	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 14:45:20.091607+00
f9b8a621-2525-4a42-aa98-ebec0f57c1a3	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "About Venice Parsley", "it": "Informazioni sul prezzemolo di Venezia"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "", "it": ""}, "tagline": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	20	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 14:52:36.900781+00
f43743c5-f7ac-413a-8199-e5beb36c869b	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "", "it": ""}, "content": {"en": "", "it": ""}}, "intro": {"title": {"en": "Life in the Heart of Venice.", "it": "Vita nel cuore di Venezia."}, "tagline": {"en": "SHORELINE VIBES", "it": "ATMOSFERA DI COSTA"}, "description": {"en": "Intimate stays where timeless Venetian character meets understated contemporary living elegance. Central. Private. Effortless.", "it": "Soggiorni intimi dove il fascino intramontabile di Venezia incontra la sobria eleganza del vivere contemporaneo. Centrale. Riservato. Senza sforzo."}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	22	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 14:56:55.070683+00
a73b26fe-0f99-494f-bfba-c2864cb38c39	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "", "it": ""}, "ctaText": {"en": "", "it": ""}, "subtitle": {"en": "", "it": ""}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "About Venice Parsley", "it": "Informazioni sul prezzemolo di Venezia"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique and artistic inspiration.", "it": "Mettiamo in contatto gli amanti dell'arte con straordinari spazi abitativi a Venezia, offrendo un'ispirazione artistica unica."}}, "intro": {"title": {"en": "", "it": ""}, "tagline": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}, "featured": {"title": {"en": "", "it": ""}, "description": {"en": "", "it": ""}}}	24	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 15:03:34.701079+00
e462cd35-307a-4b2d-b11b-21266ebbb364	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "About Venice Parcley", "it": "A proposito del prezzemolo di Venezia"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Mettiamo in contatto gli amanti dell'arte con straordinari spazi abitativi a Venezia, offrendo una miscela unica di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life in the Heart of Venice.", "it": "La vita nel cuore di Venezia."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Intimate stays where timeless Venetian character meets understated contemporary living elegance. Central. Private. Effortless.", "it": "Soggiorni intimi dove il carattere veneziano senza tempo incontra la sobria eleganza abitativa contemporanea. Centrale. Privato. Senza sforzo."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in vetrina"}, "description": {"en": "Designed for discerning travelers, each residence offers a calm and curated atmosphere, just steps from the citys most iconic landmarks.\\r\\nThoughtful details, refined materials, and a sense of quiet exclusivity.", "it": "Progettate per i viaggiatori più esigenti, ogni residenza offre un'atmosfera tranquilla e curata, a pochi passi dai monumenti più iconici della città.\\r\\nDettagli attenti, materiali raffinati e un senso di silenziosa esclusività."}}}	27	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 22:36:43.400104+00
edc9afba-d71c-4cbf-a67d-e2bf1de9acc6	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora gli appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/homepage-hero/0db998d0-570f-4cdd-a9af-ae80a724fb81-1776638272353.jpg", "https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/homepage-hero/937b3611-3033-4fc3-a59c-4cd366605329-1776638273628.jpg", "https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/homepage-hero/19791fc6-fa7f-42ae-9ea6-f3a07610aeff-1776638275170.jpg"]}, "about": {"title": {"en": "About Venice Parcley", "it": "A proposito del prezzemolo di Venezia"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Mettiamo in contatto gli amanti dell'arte con straordinari spazi abitativi a Venezia, offrendo una miscela unica di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life in the Heart of Venice.", "it": "La vita nel cuore di Venezia."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Intimate stays where timeless Venetian character meets understated contemporary living elegance. Central. Private. Effortless.", "it": "Soggiorni intimi dove il carattere veneziano senza tempo incontra la sobria eleganza abitativa contemporanea. Centrale. Privato. Senza sforzo."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in vetrina"}, "description": {"en": "Designed for discerning travelers, each residence offers a calm and curated atmosphere, just steps from the citys most iconic landmarks.\\r\\nThoughtful details, refined materials, and a sense of quiet exclusivity.", "it": "Progettate per i viaggiatori più esigenti, ogni residenza offre un'atmosfera tranquilla e curata, a pochi passi dai monumenti più iconici della città.\\r\\nDettagli attenti, materiali raffinati e un senso di silenziosa esclusività."}}}	29	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 22:38:40.170338+00
87c222c0-040f-439e-869c-a408db6cbebe	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora gli appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/homepage-hero/0db998d0-570f-4cdd-a9af-ae80a724fb81-1776638272353.jpg", "https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/homepage-hero/937b3611-3033-4fc3-a59c-4cd366605329-1776638273628.jpg", "https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/homepage-hero/19791fc6-fa7f-42ae-9ea6-f3a07610aeff-1776638275170.jpg"]}, "about": {"title": {"en": "About Venice Parcley", "it": "A proposito del prezzemolo di Venezia"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Mettiamo in contatto gli amanti dell'arte con straordinari spazi abitativi a Venezia, offrendo una miscela unica di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life in the Heart of Venice.", "it": "La vita nel cuore di Venezia."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Intimate stays where timeless Venetian character meets understated contemporary living elegance. Central. Private. Effortless.", "it": "Soggiorni intimi dove il carattere veneziano senza tempo incontra la sobria eleganza abitativa contemporanea. Centrale. Privato. Senza sforzo."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in vetrina"}, "description": {"en": "Designed for discerning travelers, each residence offers a calm and curated atmosphere, just steps from the citys most iconic landmarks.\\r\\nThoughtful details, refined materials, and a sense of quiet exclusivity.", "it": "Progettate per i viaggiatori più esigenti, ogni residenza offre un'atmosfera tranquilla e curata, a pochi passi dai monumenti più iconici della città.\\r\\nDettagli attenti, materiali raffinati e un senso di silenziosa esclusività."}}}	31	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 22:42:57.58537+00
84c0cf46-2ef1-4846-a08a-976fb7a463a2	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920", "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1920"]}, "about": {"title": {"en": "About Venice Parcley", "it": "Chi Siamo"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life at Shoreline, wrapped in artful calm and cinematic sea light.", "it": "Life at Shoreline, wrapped in artful calm and cinematic sea light."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays.", "it": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in Evidenza"}, "description": {"en": "Experience Venice like never before in our carefully curated collection of artistic apartments.", "it": "Vivi Venezia come mai prima d'ora nella nostra collezione curata di appartamenti artistici."}}}	38	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-20 03:14:19.765481+00
617c77c1-550c-484e-a332-b2ec12fbd212	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920", "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1920"]}, "about": {"title": {"en": "About Venice Parcley", "it": "Chi Siamo"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life at Shoreline, wrapped in artful calm and cinematic sea light.", "it": "Life at Shoreline, wrapped in artful calm and cinematic sea light."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays.", "it": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in Evidenza"}, "description": {"en": "Experience Venice like never before in our carefully curated collection of artistic apartments.", "it": "Vivi Venezia come mai prima d'ora nella nostra collezione curata di appartamenti artistici."}}}	48	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-20 05:00:07.931501+00
e6ef53a7-8852-4ebe-bcf0-726b4e751bd3	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920", "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1920"]}, "about": {"title": {"en": "About Venice Parcley", "it": "Chi Siamo"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life at Shoreline, wrapped in artful calm and cinematic sea light.", "it": "Life at Shoreline, wrapped in artful calm and cinematic sea light."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays.", "it": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in Evidenza"}, "description": {"en": "Experience Venice like never before in our carefully curated collection of artistic apartments.", "it": "Vivi Venezia come mai prima d'ora nella nostra collezione curata di appartamenti artistici."}}}	50	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-20 05:13:32.990691+00
49ee42c1-626d-4cce-8459-2c2f1b02bdda	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://zhdmgvhwrmstapywvfmu.supabase.co/storage/v1/object/public/apartment-images/apartments/homepage-hero/be12c7e0-6a95-4ca6-89d7-073f42f23626-1776662266188.webp"]}, "about": {"title": {"en": "About Venice Parcley", "it": "Chi Siamo"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life at Shoreline, wrapped in artful calm and cinematic sea light.", "it": "Life at Shoreline, wrapped in artful calm and cinematic sea light."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays.", "it": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in Evidenza"}, "description": {"en": "Experience Venice like never before in our carefully curated collection of artistic apartments.", "it": "Vivi Venezia come mai prima d'ora nella nostra collezione curata di appartamenti artistici."}}}	52	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-20 05:18:04.637734+00
c20b3423-a1c5-4cbc-a391-c80ddfcdb5a6	2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920", "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1920"]}, "about": {"title": {"en": "About Venice Parcley", "it": "Chi Siamo"}, "content": {"en": "We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Connettiamo gli amanti dell'arte con spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life at Shoreline, wrapped in artful calm and cinematic sea light.", "it": "Life at Shoreline, wrapped in artful calm and cinematic sea light."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays.", "it": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in Evidenza"}, "description": {"en": "Experience Venice like never before in our carefully curated collection of artistic apartments.", "it": "Vivi Venezia come mai prima d'ora nella nostra collezione curata di appartamenti artistici."}}}	56	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-20 07:52:30.551824+00
\.


--
-- Data for Name: content_sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_sections (id, key, payload, status, version, created_by, updated_by, created_at, updated_at) FROM stdin;
2c909497-399d-4e25-9cde-58a3673bcedd	homepage	{"hero": {"title": {"en": "Discover Artistic Living Spaces", "it": "Scopri Spazi di Vita Artistici"}, "ctaText": {"en": "Explore Apartments", "it": "Esplora Appartamenti"}, "subtitle": {"en": "Luxury apartments designed for art lovers and creative souls", "it": "Appartamenti di lusso progettati per amanti dell'arte e anime creative"}, "backgroundImages": ["https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920", "https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920", "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920"]}, "about": {"title": {"en": "About Venice Parsley", "it": "Chi Siamo"}, "content": {"en": "Extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.", "it": "Spazi abitativi straordinari a Venezia, offrendo un mix unico di alloggi di lusso e ispirazione artistica."}}, "intro": {"title": {"en": "Life at Shoreline, wrapped in artful calm and cinematic sea light.", "it": "Life at Shoreline, wrapped in artful calm and cinematic sea light."}, "tagline": {"en": "SHORELINE VIBES", "it": "SHORELINE VIBES"}, "description": {"en": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays.", "it": "Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays."}}, "featured": {"title": {"en": "Featured Apartments", "it": "Appartamenti in Evidenza"}, "description": {"en": "Experience Venice like never before in our carefully curated collection of artistic apartments.", "it": "Vivi Venezia come mai prima d'ora nella nostra collezione curata di appartamenti artistici."}}}	published	73	\N	691769f3-9978-472b-9fb5-62c15543d7d9	2026-04-19 13:25:13.489014+00	2026-04-21 02:32:50.803537+00
\.


--
-- Data for Name: database-schema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."database-schema" (id, created_at) FROM stdin;
\.


--
-- Data for Name: loyalty_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loyalty_points (id, user_id, points, type, booking_id, description, created_at) FROM stdin;
\.


--
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_items (id, label, href, is_active, sort_order, created_at, updated_at, content, map_embed) FROM stdin;
cd12998a-97a6-4bd7-ba6b-7ae2a96867d8	How to get here	/how-to-get-here	t	4	2026-04-17 13:45:21.941841+00	2026-04-21 06:42:02.123164+00	✈️ From Venice Marco Polo Airport:\nOPTION 1 — Water Taxi (fast + cinematic ~30 min)\nDirect to the canal dock just 20 meters from the home door.\nA bit expensive, but it feels like arriving in a film\n\nOPTION 2 — Alilaguna Boat (practical + scenic\n~ 50 min)\nTake the Blue line toward central Venice\nGet off at F.ta Nove and walk ~3 minutes.\n\n🚆 From Venice Santa Lucia train Station:\nOPTION 1 — Vaporetto (water bus -30 minutes)\nLine 1 or 2 along the Grand Canal\nGet off at Rialto, then walk ~7 minutes\nLine 4.2 or 5.2 \nGet off at F.ta Nove then walk ~3 minutes\n\nOPTION 2 — Walk (if you travel light \n~40 min)\nA maze, but a beautiful one\n\nTip: Follow GPS, but don’t trust it blindly. In Venice, being slightly lost is not a problem… It’s part of the design.	<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2679.1311996027594!2d12.340713100000002!3d45.4412177!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x477eb1315b93fbe1%3A0x611547f40d2da94!2sVenice%20Parsley!5e1!3m2!1sen!2sid!4v1776737193593!5m2!1sen!2sid" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
a6d821f6-6b3d-4399-baed-0d950baeb9d4	Neighbourhood	/neighbourhood	t	3	2026-04-17 13:45:21.941841+00	2026-04-21 02:09:22.038184+00	Cannareggio is a very large district on the northernmost part of the historic center of Venice.\n\n\nIt is, partially, a busy area, as many cross it only to go from the land landings to Rialto and San Marco, leaving out the most internal and particular part of the district.\n\n\nIt is an area absolutely worth discovering because it reserves secluded and little-frequented stunning corners, lived only by Venetians in their daily life. The places of interest are countless: the Ghetto, the churches of Sant'Alvise, the Madonna dell'Orto, the Jesuits, Fondamenta de la Sensa, the Sacca della Misericordia, etc.\n\n\nCannareggio is full of excellent restaurants and bacari (a type of popular Venetian tavern with a wide selection of wines by the glass and the typical "cicchetti" snacks) ... close to home you will find many ... and we will recommend the best ones!!!\n	https://maps.app.goo.gl/ctSnjyxuq5GytmQPA
e5d047f4-f373-48b4-a109-0b2c4aa5bf5c	Contact	/contact	t	5	2026-04-17 13:45:21.941841+00	2026-04-21 02:29:43.017611+00	Rio Terà dei Biri o del Parsemolo, 5384, \n30121 Venezia VE, Italy\n\nTel. +393470630960\nE-mail info@veniceparsley.com	<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2679.1311996027594!2d12.340713100000002!3d45.4412177!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x477eb1315b93fbe1%3A0x611547f40d2da94!2sVenice%20Parsley!5e1!3m2!1sen!2sid!4v1776737193593!5m2!1sen!2sid" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
aeca895b-d39d-435c-bb8e-0d5968accebc	Apartments	/apartments	t	2	2026-04-17 13:45:21.941841+00	2026-04-18 09:59:53.395248+00	apartments page	\N
c4420c8a-0aa0-468f-89da-63a3c2ee5fe6	About	/about	t	1	2026-04-17 13:45:21.941841+00	2026-04-21 02:42:09.814386+00	Ciao !!\n\nSiamo Marcello e Michela (Martino, Metello e Mario i nostri figli) viviamo e lavoriamo a Ubud, Bali (Indonesia) .... e siamo innamorati di Venezia !\n\nI nostri appartamenti sono nel cuore della Venezia popolare a due passi da Rialto (7 minuti), Piazza S. Marco (15 minuti) e Basilica SS. Giovanni e Paolo (3 minuti). Posizione perfetta per visitare tutta la città. \nGli appartamenti sono in una zona estremamente silenziosa e tranquilla. La nostra calle è chiusa, si affaccia sulla laguna nord di Venezia e quindi l’unico passaggio pedonale è dei pochi residenti soltanto. Non ci sono attività commerciali o ristoranti nelle immediate vicinanze … dormirete sonni tranquilli!! \n\nTroverete una cucina moderna e attrezzata e Wi-Fi veloce. \nCa' BIRI e Ca' TERA' hanno due camere da letto in ogni appartamento di cui una flessibile che si trasforma da matrimoniale (o 2 letti singoli) in soggiorno con due divani (fateci sapere la vostra disposizione preferita).\nOgni camera da letto è dotata di smart TV  e aria condizionata. \nCa' ASIA, invece, ha 3 camere da letto e 3 bagni e una grande sala TV con altana esclusiva, perfetta per colazioni e aperitivi o solamente per osservare con serenità la città dall'alto.\nLettino e seggiolone per bambini sono a disposizione, previa richiesta, senza costi aggiuntivi.\n\nVicinissimi all’imbarcadero del vaporetto di Fondamenta Nove (3 minuti – tutte le destinazioni e aliscafo da e per l’aeroporto) e circondati da ottimi ristoranti e bar. Accanto all’appartamento anche farmacia e lavanderia automatica (3 minuti).\nCom’e stato il tuo soggiorno?\n\nCerchiamo in tutti i modi di migliorare il nostro servizio e ci farebbe molto piacere sapere cosa pensi!\n\nSe Venice Parsley ha raggiunto (o superato) le tue aspettative, una recensione positiva sarebbe veramente importante per noi:\n\nGoogle review\n\nSe ci fosse invece qualcosa da migliorare scrivici un'email e faremo il possibile per perfezionare il nostro servizio seguendo i tuoi preziosi consigli.\n\n	
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, email, full_name, phone, role, preferred_driver_id, notification_preferences, created_at, updated_at) FROM stdin;
9ed09247-a87c-4024-9376-3e3ca428cabb	tes@admin.com	tess	\N	admin	\N	{"sms": false, "email": true}	2026-04-12 07:14:52.806348+00	2026-04-12 07:42:46.481216+00
691769f3-9978-472b-9fb5-62c15543d7d9	made@made.com	made	\N	admin	\N	{"sms": false, "email": true}	2026-04-12 07:44:08.455027+00	2026-04-12 08:00:54.175412+00
590ccd8f-fc79-40f8-9083-f382ba41c5a0	wayan@wayan.com	wayan	\N	admin	\N	{"sms": false, "email": true}	2026-04-12 08:23:44.989335+00	2026-04-12 08:26:28.263873+00
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, key, value, created_at, updated_at) FROM stdin;
d92506bf-5551-4ff7-98d4-49bf286b8e82	theme_colors	{"footer_color": "#1b211a", "header_bg_left": "#003049", "connector_color": "from-black-400 to-beige-500", "header_bg_right": "#1b211a"}	2026-04-17 13:45:21.941841+00	2026-04-17 13:45:21.941841+00
2d1bcc38-decb-428c-a525-00ba1a2166bd	logo_settings	{"logo_active": false}	2026-04-17 13:45:21.941841+00	2026-04-17 13:45:21.941841+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-04-09 13:20:56
20211116045059	2026-04-09 13:20:57
20211116050929	2026-04-09 13:20:58
20211116051442	2026-04-09 13:20:59
20211116212300	2026-04-09 13:21:00
20211116213355	2026-04-09 13:21:01
20211116213934	2026-04-09 13:21:03
20211116214523	2026-04-09 13:21:04
20211122062447	2026-04-09 13:21:05
20211124070109	2026-04-09 13:21:07
20211202204204	2026-04-09 13:21:08
20211202204605	2026-04-09 13:21:09
20211210212804	2026-04-09 13:21:12
20211228014915	2026-04-09 13:21:13
20220107221237	2026-04-09 13:21:14
20220228202821	2026-04-09 13:21:15
20220312004840	2026-04-09 13:21:17
20220603231003	2026-04-09 13:21:18
20220603232444	2026-04-09 13:21:19
20220615214548	2026-04-09 13:21:21
20220712093339	2026-04-09 13:21:22
20220908172859	2026-04-09 13:21:23
20220916233421	2026-04-09 13:21:24
20230119133233	2026-04-09 13:21:25
20230128025114	2026-04-09 13:21:27
20230128025212	2026-04-09 13:21:28
20230227211149	2026-04-09 13:21:29
20230228184745	2026-04-09 13:21:31
20230308225145	2026-04-09 13:21:32
20230328144023	2026-04-09 13:21:33
20231018144023	2026-04-09 13:21:34
20231204144023	2026-04-09 13:21:36
20231204144024	2026-04-09 13:21:37
20231204144025	2026-04-09 13:21:38
20240108234812	2026-04-09 13:21:39
20240109165339	2026-04-09 13:21:40
20240227174441	2026-04-09 13:21:42
20240311171622	2026-04-09 13:21:44
20240321100241	2026-04-09 13:21:47
20240401105812	2026-04-09 13:21:49
20240418121054	2026-04-09 13:21:51
20240523004032	2026-04-09 13:21:55
20240618124746	2026-04-09 13:21:56
20240801235015	2026-04-09 13:21:57
20240805133720	2026-04-09 13:21:58
20240827160934	2026-04-09 13:21:59
20240919163303	2026-04-09 13:22:01
20240919163305	2026-04-09 13:22:02
20241019105805	2026-04-09 13:22:03
20241030150047	2026-04-09 13:22:07
20241108114728	2026-04-09 13:22:08
20241121104152	2026-04-09 13:22:09
20241130184212	2026-04-09 13:22:11
20241220035512	2026-04-09 13:22:12
20241220123912	2026-04-09 13:22:13
20241224161212	2026-04-09 13:22:14
20250107150512	2026-04-09 13:22:15
20250110162412	2026-04-09 13:22:16
20250123174212	2026-04-09 13:22:18
20250128220012	2026-04-09 13:22:19
20250506224012	2026-04-09 13:22:20
20250523164012	2026-04-09 13:22:21
20250714121412	2026-04-09 13:22:23
20250905041441	2026-04-09 13:22:24
20251103001201	2026-04-09 13:22:25
20251120212548	2026-04-09 13:22:26
20251120215549	2026-04-09 13:22:28
20260218120000	2026-04-09 13:22:29
20260326120000	2026-04-12 06:44:34
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
apartment-images	apartment-images	\N	2026-04-15 14:08:13.296215+00	2026-04-15 14:08:13.296215+00	t	f	10000000	{image/jpeg,image/png,image/webp,image/gif,image/avif}	\N	STANDARD
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-04-09 11:57:04.023828
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-04-09 11:57:04.047953
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-04-09 11:57:04.054373
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-04-09 11:57:04.084278
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-04-09 11:57:04.100976
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-04-09 11:57:04.107595
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-04-09 11:57:04.114994
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-04-09 11:57:04.121818
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-04-09 11:57:04.128147
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-04-09 11:57:04.13519
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-04-09 11:57:04.142429
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-04-09 11:57:04.150604
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-04-09 11:57:04.158297
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-04-09 11:57:04.164623
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-04-09 11:57:04.172576
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-04-09 11:57:04.202247
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-04-09 11:57:04.211653
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-04-09 11:57:35.736284
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-04-09 11:57:35.760887
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-04-09 11:57:35.776401
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-04-09 11:57:35.798226
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-04-09 11:57:35.825748
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-04-09 11:57:35.858356
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-04-09 11:57:35.874263
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-04-09 11:57:35.883325
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-04-09 11:57:35.89338
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-04-09 11:57:35.902523
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-04-09 11:57:35.911134
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-04-09 11:57:35.919555
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-04-09 11:57:35.928225
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-04-09 11:57:35.936886
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-04-09 11:57:35.945424
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-04-09 11:57:35.955487
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-04-09 11:57:35.963904
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-04-09 11:57:35.972415
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-04-09 11:57:35.981544
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-04-09 11:57:35.98999
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-04-09 11:57:35.998835
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-04-09 11:57:36.010796
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-04-09 11:57:36.030529
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-04-09 11:57:36.038872
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-04-09 11:57:36.047282
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-04-09 11:57:36.0565
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-04-09 11:57:36.065119
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-04-09 11:57:36.073674
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-04-09 11:57:36.08366
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-04-09 11:57:36.098863
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-04-09 11:57:36.107956
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-04-09 11:57:36.116838
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-04-09 11:57:36.166244
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-04-09 11:57:36.175735
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-04-09 11:57:36.204048
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-04-09 11:57:36.207061
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-04-09 11:57:36.223065
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-04-09 11:57:36.228935
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-04-09 11:57:36.231975
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-04-09 11:57:36.242396
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-04-09 11:57:36.334229
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-04-09 11:57:36.344569
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
e2f8448c-abe5-4ba8-b9d7-824b64369664	apartment-images	apartments/ca-asia-apt-2/2ac4867c-dd02-4fbd-8566-28bf576ae753-1776262088504.jpg	\N	2026-04-15 14:08:17.17828+00	2026-04-15 14:08:17.17828+00	2026-04-15 14:08:17.17828+00	{"eTag": "\\"b7b81e2e95689b1f3c8b49b8f10ea585\\"", "size": 575159, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-15T14:08:18.000Z", "contentLength": 575159, "httpStatusCode": 200}	b58128cd-4c51-437d-9cf0-4e241f00f973	\N	{}
fa656985-c483-4c61-870b-7a2c98a75005	apartment-images	apartments/ca-tera-apt-3/34bc3153-a7c3-4a15-8bbe-f702ef8c4aef-1776672528812.jpg	\N	2026-04-20 08:08:48.910447+00	2026-04-20 08:08:48.910447+00	2026-04-20 08:08:48.910447+00	{"eTag": "\\"1180bf39ffdc041123a92d9477c3203a\\"", "size": 1010828, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:08:49.000Z", "contentLength": 1010828, "httpStatusCode": 200}	95abb0b2-0828-4a33-a8a9-b1d7e386bf5c	\N	{}
9a0db029-c25c-4678-a041-7602486bd3f4	apartment-images	apartments/ca-tera-apt-3/d4f90eca-19cd-4805-b742-8cda51ce399e-1776672532453.jpg	\N	2026-04-20 08:08:52.666094+00	2026-04-20 08:08:52.666094+00	2026-04-20 08:08:52.666094+00	{"eTag": "\\"7ea1edd6f916be95eaf26dbde55e45e0\\"", "size": 1473986, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:08:53.000Z", "contentLength": 1473986, "httpStatusCode": 200}	9db3022e-f8f8-449c-8e98-f607e3a0d4f9	\N	{}
e8325099-3bd3-4098-b24d-e6c4a97928b3	apartment-images	apartments/ca-tera-apt-3/2a7663d8-6ef7-4aeb-946f-88bcb94e5f32-1776672556539.jpg	\N	2026-04-20 08:09:16.609236+00	2026-04-20 08:09:16.609236+00	2026-04-20 08:09:16.609236+00	{"eTag": "\\"00b5172f83e0e16afacb1160f2123353\\"", "size": 627391, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:09:17.000Z", "contentLength": 627391, "httpStatusCode": 200}	f1ea9066-e84e-4d7d-b9db-1d37cec8e300	\N	{}
2032c4a4-b90c-4e86-b269-2168bdab6f56	apartment-images	apartments/homepage-hero/e4c01330-40a3-44e6-9b5e-c3c65113d2b1-1776610935162.jpg	\N	2026-04-19 15:02:20.404521+00	2026-04-19 15:02:20.404521+00	2026-04-19 15:02:20.404521+00	{"eTag": "\\"b7b81e2e95689b1f3c8b49b8f10ea585\\"", "size": 575159, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T15:02:21.000Z", "contentLength": 575159, "httpStatusCode": 200}	1a4118aa-9bb9-4aa1-92e0-f5a6bad42fd9	\N	{}
f4e08fe2-20e0-4975-8d59-bb541fc0cfab	apartment-images	apartments/homepage-hero/093ee944-6766-4502-9e15-222ed693114a-1776610943133.jpg	\N	2026-04-19 15:02:28.754926+00	2026-04-19 15:02:28.754926+00	2026-04-19 15:02:28.754926+00	{"eTag": "\\"9c7ef4fc9c2d6f0de9fc975516781d6b\\"", "size": 597749, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T15:02:29.000Z", "contentLength": 597749, "httpStatusCode": 200}	e333de66-06d1-4b54-b572-ddcbd7983701	\N	{}
29945576-029f-4e93-b864-7f31ee72758a	apartment-images	apartments/homepage-hero/31a694f8-9a10-4d68-8834-94a6645eb1c1-1776610953291.jpg	\N	2026-04-19 15:02:41.865932+00	2026-04-19 15:02:41.865932+00	2026-04-19 15:02:41.865932+00	{"eTag": "\\"e48e957c23a4cf4f0ff10cad1ad04f2e\\"", "size": 712004, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T15:02:42.000Z", "contentLength": 712004, "httpStatusCode": 200}	5b08a3e5-4024-48b3-82f0-c0d7a283e667	\N	{}
2fa98310-4cbc-435d-a187-ca58ea1b3c64	apartment-images	apartments/homepage-hero/710db96f-6227-4d8f-abb5-5e018434ac19-1776610963726.jpg	\N	2026-04-19 15:02:46.64915+00	2026-04-19 15:02:46.64915+00	2026-04-19 15:02:46.64915+00	{"eTag": "\\"87e7373a2a2c5ba2515c4058cc2ea767\\"", "size": 451263, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T15:02:47.000Z", "contentLength": 451263, "httpStatusCode": 200}	1934d2dd-f657-4744-b0e0-ad86d37fbcb8	\N	{}
79d17d57-ea7c-4813-b1c6-c580eca598e5	apartment-images	apartments/homepage-hero/0db998d0-570f-4cdd-a9af-ae80a724fb81-1776638272353.jpg	\N	2026-04-19 22:37:53.588229+00	2026-04-19 22:37:53.588229+00	2026-04-19 22:37:53.588229+00	{"eTag": "\\"23385441814608fe11dd3e8598cc8676\\"", "size": 150131, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T22:37:54.000Z", "contentLength": 150131, "httpStatusCode": 200}	ef5ea5d8-5bfc-4c62-a36c-0afd80e5e03d	\N	{}
0c917306-4f92-47c3-aa5f-b77a2dc5cf47	apartment-images	apartments/homepage-hero/937b3611-3033-4fc3-a59c-4cd366605329-1776638273628.jpg	\N	2026-04-19 22:37:55.134615+00	2026-04-19 22:37:55.134615+00	2026-04-19 22:37:55.134615+00	{"eTag": "\\"aa862025ae8777632938d253d7047c48\\"", "size": 254508, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T22:37:56.000Z", "contentLength": 254508, "httpStatusCode": 200}	0de60a6a-7c3f-42d9-b6aa-53575ed8fcd9	\N	{}
6aeb8a56-68c4-4dfd-a2aa-bbca93c77338	apartment-images	apartments/homepage-hero/99dee4a8-cea8-453a-b6d5-b0aa16016a67-1776735773848.jpg	\N	2026-04-21 01:42:56.35063+00	2026-04-21 01:42:56.35063+00	2026-04-21 01:42:56.35063+00	{"eTag": "\\"6818b18844cd9379d69920e311c852d5\\"", "size": 615113, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-21T01:42:57.000Z", "contentLength": 615113, "httpStatusCode": 200}	8ad428a8-4721-40ae-bf9d-d0380b88c362	\N	{}
ec1ce26f-dc1a-4576-9eb6-35803e50ab7f	apartment-images	apartments/homepage-hero/19791fc6-fa7f-42ae-9ea6-f3a07610aeff-1776638275170.jpg	\N	2026-04-19 22:37:57.382028+00	2026-04-19 22:37:57.382028+00	2026-04-19 22:37:57.382028+00	{"eTag": "\\"9c7ef4fc9c2d6f0de9fc975516781d6b\\"", "size": 597749, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T22:37:58.000Z", "contentLength": 597749, "httpStatusCode": 200}	69d06390-073c-44e5-9e3b-d36103b702f7	\N	{}
d716b557-c8b5-4406-9352-8d9662de0090	apartment-images	apartments/homepage-hero/070fd63e-9eb4-4622-996f-8adef49c75af-1776638277378.jpg	\N	2026-04-19 22:37:59.328914+00	2026-04-19 22:37:59.328914+00	2026-04-19 22:37:59.328914+00	{"eTag": "\\"87e7373a2a2c5ba2515c4058cc2ea767\\"", "size": 451263, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T22:38:00.000Z", "contentLength": 451263, "httpStatusCode": 200}	8cae0a50-e9a6-469f-b87e-b1ab71479fda	\N	{}
17109d11-38ba-4e14-95b4-75cb65ef4ea9	apartment-images	apartments/homepage-hero/1fd2b027-c188-4ae8-b3e9-0a6a0df4cb2a-1776638279346.jpg	\N	2026-04-19 22:38:01.659195+00	2026-04-19 22:38:01.659195+00	2026-04-19 22:38:01.659195+00	{"eTag": "\\"b7b81e2e95689b1f3c8b49b8f10ea585\\"", "size": 575159, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-19T22:38:02.000Z", "contentLength": 575159, "httpStatusCode": 200}	6eea277b-37d8-4337-9b91-614ac8c6e131	\N	{}
3e4f9de2-fd7b-4c42-8a57-7c52cbc47c98	apartment-images	apartments/homepage-hero/be12c7e0-6a95-4ca6-89d7-073f42f23626-1776662266188.webp	\N	2026-04-20 05:17:46.899126+00	2026-04-20 05:17:46.899126+00	2026-04-20 05:17:46.899126+00	{"eTag": "\\"24c221ce3fe57ea2c63328f559974925\\"", "size": 1858586, "mimetype": "image/webp", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T05:17:47.000Z", "contentLength": 1858586, "httpStatusCode": 200}	ba83a246-ea66-4d14-867d-23a538c6530f	\N	{}
860282b6-f6d4-454b-977d-066942479735	apartment-images	apartments/ca-asia-app-1/d8553bd2-f68b-4069-8e35-09bf7bc59c84-1776666822599.jpg	\N	2026-04-20 06:33:43.637652+00	2026-04-20 06:33:43.637652+00	2026-04-20 06:33:43.637652+00	{"eTag": "\\"a26ed68c544038b75c8a581863921111\\"", "size": 496587, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:33:44.000Z", "contentLength": 496587, "httpStatusCode": 200}	58d3f4a2-0e16-41c0-8aed-bc5f7b1ffd0f	\N	{}
79b46057-82d9-42e7-91d3-e080b4f22031	apartment-images	apartments/ca-asia-app-1/28b574f8-efaa-4714-9c60-b2c197a2d072-1776666825009.jpg	\N	2026-04-20 06:33:45.623309+00	2026-04-20 06:33:45.623309+00	2026-04-20 06:33:45.623309+00	{"eTag": "\\"e1010ba1d013aac73554310e4292df52\\"", "size": 485891, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:33:46.000Z", "contentLength": 485891, "httpStatusCode": 200}	0531ad59-f728-4291-8605-9767ee8f7afb	\N	{}
7f6e5b0a-a161-4111-8470-4aa78e0edae2	apartment-images	apartments/ca-asia-app-1/8a8d9ca1-5b92-4be6-baf1-155075c7e5a9-1776666826618.jpg	\N	2026-04-20 06:33:47.759606+00	2026-04-20 06:33:47.759606+00	2026-04-20 06:33:47.759606+00	{"eTag": "\\"890be8b0b1cf1526b5e066441b04fa5b\\"", "size": 636516, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:33:48.000Z", "contentLength": 636516, "httpStatusCode": 200}	92b66c0a-c50b-49cd-84bf-671f4a87486b	\N	{}
2bdd4360-17fb-419f-8c9e-4da7ddbe6db5	apartment-images	apartments/ca-asia-app-1/197db91c-b44d-42e6-8ca3-03aeda5b2fa9-1776666828809.jpg	\N	2026-04-20 06:33:49.817282+00	2026-04-20 06:33:49.817282+00	2026-04-20 06:33:49.817282+00	{"eTag": "\\"f62794b6a08fe727ed15d506e50d7011\\"", "size": 555461, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:33:50.000Z", "contentLength": 555461, "httpStatusCode": 200}	b8ea4fce-8a0c-4009-b62e-4db2adf0c3ce	\N	{}
58213a2f-3e3b-4c07-8ca5-87ffee418def	apartment-images	apartments/ca-asia-app-1/b7df8cdc-71e6-49cf-9c75-d0118c6b2960-1776666830773.jpg	\N	2026-04-20 06:33:52.055375+00	2026-04-20 06:33:52.055375+00	2026-04-20 06:33:52.055375+00	{"eTag": "\\"2fcaebca986794243c844630a7971e53\\"", "size": 691084, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:33:52.000Z", "contentLength": 691084, "httpStatusCode": 200}	b31d86c2-7d2f-4b4c-ba51-12bb8159f8c7	\N	{}
bf3759c2-eae9-4922-801c-0fd8f14c1fa0	apartment-images	apartments/ca-asia-app-1/396ae686-bf4c-4156-912c-054ed64ff975-1776666832997.jpg	\N	2026-04-20 06:33:54.38182+00	2026-04-20 06:33:54.38182+00	2026-04-20 06:33:54.38182+00	{"eTag": "\\"8ad43d1b2679a59e6c4aa0bc24e77623\\"", "size": 701756, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:33:55.000Z", "contentLength": 701756, "httpStatusCode": 200}	fc60fdaa-e7b8-469f-ad79-8df11d648ff9	\N	{}
fd6a2b77-5e9f-4d81-b8d8-95c5fff92a0a	apartment-images	apartments/ca-asia-app-1/5e0e9d47-3916-4581-93d0-f1398327efb7-1776666835343.jpg	\N	2026-04-20 06:33:56.184289+00	2026-04-20 06:33:56.184289+00	2026-04-20 06:33:56.184289+00	{"eTag": "\\"1456ea290886ecdba1e34ca6d50c9d86\\"", "size": 530107, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:33:57.000Z", "contentLength": 530107, "httpStatusCode": 200}	c09038c5-b659-4eaf-b6f6-a0210f961137	\N	{}
b6473ec4-7c36-436c-bc2f-9edec67ab28a	apartment-images	apartments/ca-asia-app-1/ae6e6d16-0832-4add-97fa-e7b6808af306-1776666837157.jpg	\N	2026-04-20 06:33:57.642724+00	2026-04-20 06:33:57.642724+00	2026-04-20 06:33:57.642724+00	{"eTag": "\\"4ae8ce15812c2905712bd94ce6fd62a1\\"", "size": 452561, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:33:58.000Z", "contentLength": 452561, "httpStatusCode": 200}	1969f132-fc51-4c6a-a265-4e85f1b95a16	\N	{}
1b160648-4c3a-46c8-a836-22f35c70b610	apartment-images	apartments/ca-asia-app-1/0a56c01f-cc9f-447f-b056-281d91db4fc7-1776666838618.jpg	\N	2026-04-20 06:33:59.124231+00	2026-04-20 06:33:59.124231+00	2026-04-20 06:33:59.124231+00	{"eTag": "\\"185622b0cbf6b0747b786070588c6a28\\"", "size": 433512, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:34:00.000Z", "contentLength": 433512, "httpStatusCode": 200}	17f937b3-6198-4f58-a8a4-dd8178be2489	\N	{}
a1334c69-71e4-4c72-a5cd-a0dc0771f1c5	apartment-images	apartments/ca-asia-app-1/1ff4d004-db29-4c59-b68f-a72d8b02897a-1776667040420.jpg	\N	2026-04-20 06:37:20.87225+00	2026-04-20 06:37:20.87225+00	2026-04-20 06:37:20.87225+00	{"eTag": "\\"f62794b6a08fe727ed15d506e50d7011\\"", "size": 555461, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:37:21.000Z", "contentLength": 555461, "httpStatusCode": 200}	7788fb5d-19d7-4672-880f-c7adb1e71c82	\N	{}
3a885167-4a30-4ef4-9078-fa6ccb21b4ab	apartment-images	apartments/ca-asia-app-1/7e0e83e6-c038-41be-8b7c-dd0e01573b16-1776667065278.jpg	\N	2026-04-20 06:37:45.562279+00	2026-04-20 06:37:45.562279+00	2026-04-20 06:37:45.562279+00	{"eTag": "\\"2dba435884e0f2bb7f79af642301056e\\"", "size": 520051, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:37:46.000Z", "contentLength": 520051, "httpStatusCode": 200}	feca5b47-7eda-47be-a06b-a67432a60af9	\N	{}
6f144382-8415-4e70-95bf-51ccb96f2136	apartment-images	apartments/ca-asia-app-1/f6b0eef2-6dbf-463b-9f88-0aaf835f08f7-1776667077908.jpg	\N	2026-04-20 06:37:58.225061+00	2026-04-20 06:37:58.225061+00	2026-04-20 06:37:58.225061+00	{"eTag": "\\"8ad43d1b2679a59e6c4aa0bc24e77623\\"", "size": 701756, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:37:59.000Z", "contentLength": 701756, "httpStatusCode": 200}	4fadd8b1-2dcb-4ceb-b88e-1aba884f6585	\N	{}
69a13ca5-07cc-43d1-b008-5e4c938d42de	apartment-images	apartments/ca-asia-app-1/d61b7e00-acba-464d-8dce-183bd3f5e90e-1776667091276.jpg	\N	2026-04-20 06:38:11.621957+00	2026-04-20 06:38:11.621957+00	2026-04-20 06:38:11.621957+00	{"eTag": "\\"271fbc03c4e09c04e3e6b46e581c60cc\\"", "size": 559458, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:38:12.000Z", "contentLength": 559458, "httpStatusCode": 200}	4c30df1b-0963-4dd7-8f46-71ea82bb1529	\N	{}
b404dca3-5656-4513-860f-a80f336b2d29	apartment-images	apartments/ca-asia-app-1/fc4089e9-bbf1-4c5f-a12e-abaeb2c4f20d-1776667094843.jpg	\N	2026-04-20 06:38:14.795235+00	2026-04-20 06:38:14.795235+00	2026-04-20 06:38:14.795235+00	{"eTag": "\\"4ae8ce15812c2905712bd94ce6fd62a1\\"", "size": 452561, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:38:15.000Z", "contentLength": 452561, "httpStatusCode": 200}	1560d5ab-52d1-4749-bfa3-be737adb6ea4	\N	{}
8a99ce6d-b58e-4b1e-98d7-037d5d76d9c0	apartment-images	apartments/ca-asia-app-1/6f00b76e-8235-4d24-8cec-e63cb035373d-1776667101074.jpg	\N	2026-04-20 06:38:21.926166+00	2026-04-20 06:38:21.926166+00	2026-04-20 06:38:21.926166+00	{"eTag": "\\"185622b0cbf6b0747b786070588c6a28\\"", "size": 433512, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:38:22.000Z", "contentLength": 433512, "httpStatusCode": 200}	0d20d107-f922-4b87-9813-bcb03d0272d9	\N	{}
b3848e86-97c5-4467-91d2-dc874055c7b4	apartment-images	apartments/ca-asia-app-1/ce5becb5-b412-42ce-8266-e2ab29b8cb74-1776667138283.jpg	\N	2026-04-20 06:38:58.834399+00	2026-04-20 06:38:58.834399+00	2026-04-20 06:38:58.834399+00	{"eTag": "\\"890be8b0b1cf1526b5e066441b04fa5b\\"", "size": 636516, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:38:59.000Z", "contentLength": 636516, "httpStatusCode": 200}	d78bdcb1-5961-4ffb-bfb5-87bd5e85ba74	\N	{}
2da964e4-c6e5-406f-aea7-f88a53f38452	apartment-images	apartments/ca-asia-app-1/1191b4a7-b843-47b6-96a2-31524fafcbae-1776667074147.jpg	\N	2026-04-20 06:37:54.675135+00	2026-04-20 06:37:54.675135+00	2026-04-20 06:37:54.675135+00	{"eTag": "\\"cd346a4ca18877f6483b389db184e4de\\"", "size": 577525, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:37:55.000Z", "contentLength": 577525, "httpStatusCode": 200}	b4c02aa7-582e-4480-92eb-c911021bf4e4	\N	{}
1c7da573-056e-44cb-93d5-a58ef8cc4e3c	apartment-images	apartments/ca-asia-app-1/eaf22f7d-857a-45c9-ad13-18d9b2336af5-1776667084183.jpg	\N	2026-04-20 06:38:04.53484+00	2026-04-20 06:38:04.53484+00	2026-04-20 06:38:04.53484+00	{"eTag": "\\"1456ea290886ecdba1e34ca6d50c9d86\\"", "size": 530107, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:38:05.000Z", "contentLength": 530107, "httpStatusCode": 200}	4e346f18-662e-4145-9f3e-fce6f4b3046e	\N	{}
502530d8-7cbb-4cd3-b5ab-ff1dfe6a5903	apartment-images	apartments/ca-asia-app-1/5becf661-7abc-4307-ad83-71ab1ed0b625-1776667107367.jpg	\N	2026-04-20 06:38:27.489056+00	2026-04-20 06:38:27.489056+00	2026-04-20 06:38:27.489056+00	{"eTag": "\\"e1010ba1d013aac73554310e4292df52\\"", "size": 485891, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T06:38:28.000Z", "contentLength": 485891, "httpStatusCode": 200}	0193c535-9c8d-4174-b46f-51f9c3c5f000	\N	{}
296aff81-5e2f-4ea3-bbb3-21aa34b87343	apartment-images	apartments/ca-biri-apt-2/ac775915-efa2-4406-820d-eb3c543619c9-1776672327395.jpg	\N	2026-04-20 08:05:27.951385+00	2026-04-20 08:05:27.951385+00	2026-04-20 08:05:27.951385+00	{"eTag": "\\"116c86558913e1002688efc9b7979ea0\\"", "size": 1582348, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:05:28.000Z", "contentLength": 1582348, "httpStatusCode": 200}	24fc3bf3-7e4d-46d3-9e70-3b1b5862c63c	\N	{}
525b063f-9c99-4c6f-a522-4f418b199633	apartment-images	apartments/ca-biri-apt-2/83199b58-98dd-443c-aad7-5de2ee0d696a-1776672335460.jpg	\N	2026-04-20 08:05:36.230908+00	2026-04-20 08:05:36.230908+00	2026-04-20 08:05:36.230908+00	{"eTag": "\\"3e2ec2b8ef3fd69d7377a6b32c20a58e\\"", "size": 1438731, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:05:37.000Z", "contentLength": 1438731, "httpStatusCode": 200}	ab33f2e1-a538-4c5c-adbd-b5d2afaa61af	\N	{}
e869fb04-4919-4d13-806d-13db1971a0dc	apartment-images	apartments/ca-biri-apt-2/3cb07b0c-f16b-4c28-b1f4-8690175349b6-1776672340634.jpg	\N	2026-04-20 08:05:41.348823+00	2026-04-20 08:05:41.348823+00	2026-04-20 08:05:41.348823+00	{"eTag": "\\"84175c71bf58b79ea51094c35962eed0\\"", "size": 1686843, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:05:42.000Z", "contentLength": 1686843, "httpStatusCode": 200}	3b8670ad-1f33-4d2d-8d52-f46e9147aa1e	\N	{}
ac2ada0e-b9b1-4fb0-84f7-94e77524ee65	apartment-images	apartments/ca-biri-apt-2/ffefe668-6cc6-468a-86ec-dd7072953b7a-1776672347415.jpg	\N	2026-04-20 08:05:48.123816+00	2026-04-20 08:05:48.123816+00	2026-04-20 08:05:48.123816+00	{"eTag": "\\"7884e0983343919340361e571b1783f1\\"", "size": 1361803, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:05:49.000Z", "contentLength": 1361803, "httpStatusCode": 200}	44dc9e43-5ded-4ab2-b8df-4fc50ae04da7	\N	{}
e497608d-260c-4227-944b-bd53c577c894	apartment-images	apartments/ca-biri-apt-2/631de58c-cd12-42ee-86a9-58969e705a15-1776672356342.jpg	\N	2026-04-20 08:05:57.063949+00	2026-04-20 08:05:57.063949+00	2026-04-20 08:05:57.063949+00	{"eTag": "\\"c5141837a82559bd1beee0d71a59dac8\\"", "size": 1388767, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:05:57.000Z", "contentLength": 1388767, "httpStatusCode": 200}	5a2c6a57-fd76-4805-8c71-28f6c2296799	\N	{}
3515c1d7-cc76-434f-a190-c3555fd306ad	apartment-images	apartments/ca-biri-apt-2/0d5598b0-bb02-4952-af05-4b86c89547b8-1776672361155.jpg	\N	2026-04-20 08:06:01.655337+00	2026-04-20 08:06:01.655337+00	2026-04-20 08:06:01.655337+00	{"eTag": "\\"540c2a9ed3f61235fbb3d187bb8ff0a0\\"", "size": 1134462, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:06:02.000Z", "contentLength": 1134462, "httpStatusCode": 200}	723bc75b-25ec-4e15-adec-f8dbc978fa0c	\N	{}
d734f68f-3261-4bf6-b922-fd0df03d0c98	apartment-images	apartments/ca-biri-apt-2/9bb913b0-47c4-43fe-8f98-a52d42f1c884-1776672380073.jpg	\N	2026-04-20 08:06:21.315865+00	2026-04-20 08:06:21.315865+00	2026-04-20 08:06:21.315865+00	{"eTag": "\\"07453d4691cce3f4976b3424c1243047\\"", "size": 1649474, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:06:22.000Z", "contentLength": 1649474, "httpStatusCode": 200}	24ca048b-b346-42f5-9adf-8e4fb564fc35	\N	{}
d1cd8376-959f-40c0-a5eb-c4ef7aa21eab	apartment-images	apartments/ca-tera-apt-3/a1242e3a-2028-4123-9121-2a6a5bc9dd29-1776672489699.jpg	\N	2026-04-20 08:08:09.822323+00	2026-04-20 08:08:09.822323+00	2026-04-20 08:08:09.822323+00	{"eTag": "\\"187c44e7742f2da011982ff85b0879de\\"", "size": 1417909, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:08:10.000Z", "contentLength": 1417909, "httpStatusCode": 200}	efbadfea-9e75-4562-a4c4-99301a50e453	\N	{}
efb6e0d6-d383-4ff9-9067-a50853d679ee	apartment-images	apartments/ca-tera-apt-3/dd6242aa-a805-48e1-864e-d6cd1c0cf600-1776672519714.jpg	\N	2026-04-20 08:08:40.248702+00	2026-04-20 08:08:40.248702+00	2026-04-20 08:08:40.248702+00	{"eTag": "\\"48ce96379b88ca075b10f59227b2d5d6\\"", "size": 1060674, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:08:41.000Z", "contentLength": 1060674, "httpStatusCode": 200}	a00975e5-725e-45d1-ae4f-5aca18723046	\N	{}
9a9d49ac-edb5-406d-bdd2-70faced493db	apartment-images	apartments/ca-biri-apt-2/479db910-2ed2-4a7a-9463-04362e2877ee-1776672369653.jpg	\N	2026-04-20 08:06:10.604912+00	2026-04-20 08:06:10.604912+00	2026-04-20 08:06:10.604912+00	{"eTag": "\\"e2bb036665d453ae2891ea707709e988\\"", "size": 1219555, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:06:11.000Z", "contentLength": 1219555, "httpStatusCode": 200}	71c86b4d-e5c7-4968-8175-427e8c3b8172	\N	{}
04a90dde-29f6-40aa-a8fd-c1b3285c01bd	apartment-images	apartments/ca-biri-apt-2/4a151392-845c-4902-809a-a34e776428ce-1776672388056.jpg	\N	2026-04-20 08:06:29.799424+00	2026-04-20 08:06:29.799424+00	2026-04-20 08:06:29.799424+00	{"eTag": "\\"8931f5b953678ede90a4254db828b38e\\"", "size": 1064497, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:06:30.000Z", "contentLength": 1064497, "httpStatusCode": 200}	481a6006-487d-4f9a-8b9e-815ebd45fbb8	\N	{}
6dd826cb-8ad9-4928-8f84-f5891d8c436b	apartment-images	apartments/ca-biri-apt-2/14bf294a-c7e6-4dfd-9240-1df07ca29c80-1776672412384.jpg	\N	2026-04-20 08:06:52.622809+00	2026-04-20 08:06:52.622809+00	2026-04-20 08:06:52.622809+00	{"eTag": "\\"d6dd9eeaae26ba813b157e730ab077a9\\"", "size": 223762, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:06:53.000Z", "contentLength": 223762, "httpStatusCode": 200}	0e0c4108-dc3c-451b-af25-b1096d5ad71c	\N	{}
352b6b3d-432b-4d95-8a96-7a784993a933	apartment-images	apartments/ca-tera-apt-3/92fb3cb8-1fcf-4adc-a3f0-cadc8d8f4a32-1776672478145.jpg	\N	2026-04-20 08:07:58.685633+00	2026-04-20 08:07:58.685633+00	2026-04-20 08:07:58.685633+00	{"eTag": "\\"372fd4a47d29444fe82defe2adbd917e\\"", "size": 1494999, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:07:59.000Z", "contentLength": 1494999, "httpStatusCode": 200}	eb829a60-8936-45dd-bf55-f5ccbdda55f0	\N	{}
605d44dc-2449-44f2-9c21-75e56842c947	apartment-images	apartments/ca-tera-apt-3/f26cb595-0c77-4913-9deb-54fc19d24176-1776672482841.jpg	\N	2026-04-20 08:08:03.222502+00	2026-04-20 08:08:03.222502+00	2026-04-20 08:08:03.222502+00	{"eTag": "\\"6e1825e57e7881ba020bcfa84b08111d\\"", "size": 1465632, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:08:04.000Z", "contentLength": 1465632, "httpStatusCode": 200}	ae885a3e-a06a-4ac2-8fa8-c145a0007b1f	\N	{}
8b2b891b-4d77-4c81-952d-77ebf1c5aabc	apartment-images	apartments/ca-tera-apt-3/841c8623-83be-46ea-b2c9-808b6957d5cf-1776672486195.jpg	\N	2026-04-20 08:08:06.580099+00	2026-04-20 08:08:06.580099+00	2026-04-20 08:08:06.580099+00	{"eTag": "\\"9ca027420fdea977d3f52d3628476d28\\"", "size": 1609614, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:08:07.000Z", "contentLength": 1609614, "httpStatusCode": 200}	ea69295c-fb73-4f17-b0ab-f05f2eef9433	\N	{}
d8bf9e86-8a75-4130-8b71-72f44c0971e2	apartment-images	apartments/ca-tera-apt-3/b81d8dd0-4f54-4604-b71b-40af20f78e43-1776672512725.jpg	\N	2026-04-20 08:08:33.474266+00	2026-04-20 08:08:33.474266+00	2026-04-20 08:08:33.474266+00	{"eTag": "\\"dc316bca763b3556ef7c83d35bed51bc\\"", "size": 1226031, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:08:34.000Z", "contentLength": 1226031, "httpStatusCode": 200}	30dd23c6-bb9e-49e8-ba9b-488ac7c76a49	\N	{}
33df0d5f-8fc4-4bc7-8474-16e8723578d3	apartment-images	apartments/ca-tera-apt-3/97de23a0-9528-4e7c-98f3-b6f277f9833b-1776672523807.jpg	\N	2026-04-20 08:08:44.224514+00	2026-04-20 08:08:44.224514+00	2026-04-20 08:08:44.224514+00	{"eTag": "\\"b658bbf59350e6ecca76b1798d3edde8\\"", "size": 1064514, "mimetype": "image/jpeg", "cacheControl": "max-age=31536000", "lastModified": "2026-04-20T08:08:45.000Z", "contentLength": 1064514, "httpStatusCode": 200}	7da457b7-fa42-469e-bf8f-d4ea8000ded1	\N	{}
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 85, true);


--
-- Name: database-schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."database-schema_id_seq"', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: apartments apartments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apartments
    ADD CONSTRAINT apartments_pkey PRIMARY KEY (id);


--
-- Name: apartments apartments_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apartments
    ADD CONSTRAINT apartments_slug_key UNIQUE (slug);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: content_revisions content_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_revisions
    ADD CONSTRAINT content_revisions_pkey PRIMARY KEY (id);


--
-- Name: content_sections content_sections_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_sections
    ADD CONSTRAINT content_sections_key_key UNIQUE (key);


--
-- Name: content_sections content_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_sections
    ADD CONSTRAINT content_sections_pkey PRIMARY KEY (id);


--
-- Name: database-schema database-schema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."database-schema"
    ADD CONSTRAINT "database-schema_pkey" PRIMARY KEY (id);


--
-- Name: loyalty_points loyalty_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loyalty_points
    ADD CONSTRAINT loyalty_points_pkey PRIMARY KEY (id);


--
-- Name: menu_items menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: settings settings_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_key_key UNIQUE (key);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: idx_bookings_apartment; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_apartment ON public.bookings USING btree (apartment_id);


--
-- Name: idx_bookings_dates; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_dates ON public.bookings USING btree (check_in_date, check_out_date);


--
-- Name: idx_bookings_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_status ON public.bookings USING btree (status);


--
-- Name: idx_bookings_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bookings_user ON public.bookings USING btree (user_id);


--
-- Name: idx_content_revisions_section; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_content_revisions_section ON public.content_revisions USING btree (section_id, version DESC);


--
-- Name: idx_content_sections_key_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_content_sections_key_status ON public.content_sections USING btree (key, status);


--
-- Name: idx_loyalty_points_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_loyalty_points_user ON public.loyalty_points USING btree (user_id);


--
-- Name: idx_menu_items_active_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_menu_items_active_order ON public.menu_items USING btree (is_active, sort_order);


--
-- Name: idx_profiles_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_email ON public.profiles USING btree (email);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: apartments update_apartments_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_apartments_updated_at BEFORE UPDATE ON public.apartments FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: content_sections update_content_sections_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_content_sections_updated_at BEFORE UPDATE ON public.content_sections FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: menu_items update_menu_items_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_menu_items_updated_at BEFORE UPDATE ON public.menu_items FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: profiles update_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: bookings bookings_apartment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_apartment_id_fkey FOREIGN KEY (apartment_id) REFERENCES public.apartments(id);


--
-- Name: bookings bookings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: content_revisions content_revisions_published_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_revisions
    ADD CONSTRAINT content_revisions_published_by_fkey FOREIGN KEY (published_by) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: content_revisions content_revisions_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_revisions
    ADD CONSTRAINT content_revisions_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.content_sections(id) ON DELETE CASCADE;


--
-- Name: content_sections content_sections_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_sections
    ADD CONSTRAINT content_sections_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: content_sections content_sections_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_sections
    ADD CONSTRAINT content_sections_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: loyalty_points loyalty_points_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loyalty_points
    ADD CONSTRAINT loyalty_points_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id);


--
-- Name: loyalty_points loyalty_points_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loyalty_points
    ADD CONSTRAINT loyalty_points_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: content_sections Admins can manage content sections; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage content sections" ON public.content_sections USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::public.user_role))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::public.user_role)))));


--
-- Name: menu_items Admins can manage menu items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage menu items" ON public.menu_items USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::public.user_role))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::public.user_role)))));


--
-- Name: settings Admins can manage settings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage settings" ON public.settings USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::public.user_role))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::public.user_role)))));


--
-- Name: content_revisions Admins can read revisions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can read revisions" ON public.content_revisions FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::public.user_role)))));


--
-- Name: apartments Apartments are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Apartments are viewable by everyone" ON public.apartments FOR SELECT USING ((is_active = true));


--
-- Name: menu_items Menu items are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Menu items are viewable by everyone" ON public.menu_items FOR SELECT USING (true);


--
-- Name: content_sections Published content is viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Published content is viewable by everyone" ON public.content_sections FOR SELECT USING ((status = 'published'::text));


--
-- Name: settings Settings are viewable by everyone; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Settings are viewable by everyone" ON public.settings FOR SELECT USING (true);


--
-- Name: bookings Users can create their own bookings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own bookings" ON public.bookings FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: profiles Users can insert own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert own profile" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- Name: loyalty_points Users can insert their own loyalty points; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own loyalty points" ON public.loyalty_points FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: profiles Users can update own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- Name: bookings Users can update their own bookings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own bookings" ON public.bookings FOR UPDATE USING ((auth.uid() = user_id)) WITH CHECK ((auth.uid() = user_id));


--
-- Name: profiles Users can view own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own profile" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- Name: bookings Users can view their own bookings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own bookings" ON public.bookings FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: loyalty_points Users can view their own loyalty points; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own loyalty points" ON public.loyalty_points FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: apartments; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.apartments ENABLE ROW LEVEL SECURITY;

--
-- Name: bookings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

--
-- Name: content_revisions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.content_revisions ENABLE ROW LEVEL SECURITY;

--
-- Name: content_sections; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.content_sections ENABLE ROW LEVEL SECURITY;

--
-- Name: database-schema; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public."database-schema" ENABLE ROW LEVEL SECURITY;

--
-- Name: loyalty_points; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.loyalty_points ENABLE ROW LEVEL SECURITY;

--
-- Name: menu_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.menu_items ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: settings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION award_loyalty_points(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.award_loyalty_points() TO anon;
GRANT ALL ON FUNCTION public.award_loyalty_points() TO authenticated;
GRANT ALL ON FUNCTION public.award_loyalty_points() TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE apartments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.apartments TO anon;
GRANT ALL ON TABLE public.apartments TO authenticated;
GRANT ALL ON TABLE public.apartments TO service_role;


--
-- Name: TABLE bookings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.bookings TO anon;
GRANT ALL ON TABLE public.bookings TO authenticated;
GRANT ALL ON TABLE public.bookings TO service_role;


--
-- Name: TABLE content_revisions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.content_revisions TO anon;
GRANT ALL ON TABLE public.content_revisions TO authenticated;
GRANT ALL ON TABLE public.content_revisions TO service_role;


--
-- Name: TABLE content_sections; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.content_sections TO anon;
GRANT ALL ON TABLE public.content_sections TO authenticated;
GRANT ALL ON TABLE public.content_sections TO service_role;


--
-- Name: TABLE "database-schema"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."database-schema" TO anon;
GRANT ALL ON TABLE public."database-schema" TO authenticated;
GRANT ALL ON TABLE public."database-schema" TO service_role;


--
-- Name: SEQUENCE "database-schema_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."database-schema_id_seq" TO anon;
GRANT ALL ON SEQUENCE public."database-schema_id_seq" TO authenticated;
GRANT ALL ON SEQUENCE public."database-schema_id_seq" TO service_role;


--
-- Name: TABLE loyalty_points; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.loyalty_points TO anon;
GRANT ALL ON TABLE public.loyalty_points TO authenticated;
GRANT ALL ON TABLE public.loyalty_points TO service_role;


--
-- Name: TABLE menu_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.menu_items TO anon;
GRANT ALL ON TABLE public.menu_items TO authenticated;
GRANT ALL ON TABLE public.menu_items TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: TABLE settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.settings TO anon;
GRANT ALL ON TABLE public.settings TO authenticated;
GRANT ALL ON TABLE public.settings TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict ApXGyaBjhmWI3aqZKlZxDwwUBTBEyhJrLshHSOCL0GfxXH95I5keOdF5VezS9Vn

