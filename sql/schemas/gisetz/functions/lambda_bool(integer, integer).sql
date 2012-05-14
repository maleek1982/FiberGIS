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
-- Name: lambda_bool(integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION lambda_bool(integer, integer) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    a alias for $1;
    b alias for $2;
BEGIN

IF (-1 = b) THEN RETURN 1;
END IF;

IF ((a*b <> 0) and (a <> b)) THEN
    RETURN 0;
ELSE 
    RETURN 1;
END IF;

END;
$_$;


--
-- Name: lambda_bool(integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION lambda_bool(integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION lambda_bool(integer, integer) FROM postgres;
GRANT ALL ON FUNCTION lambda_bool(integer, integer) TO postgres;
GRANT ALL ON FUNCTION lambda_bool(integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION lambda_bool(integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

