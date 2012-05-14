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
-- Name: int_to_text(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION int_to_text(integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    a alias for $1;
    b text;
BEGIN

IF (9 < a) THEN
    b = ''||a;
    RETURN b;
ELSE 
    b = '0'||a;
    RETURN b;
END IF;

END;
$_$;


--
-- PostgreSQL database dump complete
--

