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
-- Name: patch_count_by_port_id(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION patch_count_by_port_id(integer) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    p_id alias for $1;
    patch_count integer;
    patch_count2 integer;
BEGIN

SELECT count(*) INTO patch_count
    FROM all_con_port
    WHERE (apg_id = p_id or apg_id1 = p_id) and con_type IN (1,2,33) and deleted >= 0;

SELECT count(*) INTO patch_count2
    FROM all_con_port
    WHERE (
    (apg_id IN (SELECT apg_id1 FROM all_con_port WHERE apg_id = p_id and con_type = 99 )) 
        OR 
    (apg_id IN (SELECT apg_id FROM all_con_port WHERE apg_id1 = p_id and con_type = 99))
        OR
    (apg_id1 IN (SELECT apg_id1 FROM all_con_port WHERE apg_id = p_id and con_type = 99 )) 
        OR 
    (apg_id1 IN (SELECT apg_id FROM all_con_port WHERE apg_id1 = p_id and con_type = 99))

    ) and con_type IN (1,2,33) and deleted >= 0;
    
patch_count = patch_count + patch_count2;

RETURN patch_count;

END;
$_$;


--
-- PostgreSQL database dump complete
--

