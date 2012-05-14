--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = gisetz, pg_catalog;

--
-- Name: dev_name_sufix2(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION dev_name_sufix2(integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    a alias for $1;
    sufix text;
BEGIN


WITH RECURSIVE newdevname(k, mod, dev, ndn) AS (
        SELECT 0, 0, dd.id, '.'||gisetz.int_to_text(pp.port_id)
        FROM all_dev_geom dd, all_port_geom pp, dev_type tt
        WHERE a = pp.id and dd.id = pp.dev_id and dd.dev_type_id = tt.id
--        VALUES (0, 17, ''::text)
    UNION ALL
        SELECT n.k+1, m.used_by, d.id, '.' || gisetz.int_to_text(m.mod_id) || ndn
        FROM newdevname n, all_dev_geom d, all_mod_geom m, dev_type t
        WHERE m.used_by = n.dev and d.id = m.dev_id and d.dev_type_id = t.id
    )
SELECT ndn INTO sufix
FROM newdevname ORDER BY k DESC LIMIT 1;


RETURN sufix;

END;
$_$;


--
-- PostgreSQL database dump complete
--

