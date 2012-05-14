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
-- Name: aaa_listchildren(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_listchildren(integer) RETURNS SETOF integer
    LANGUAGE sql
    AS $_$
--    SELECT id FROM all_dev_geom WHERE id = $1;
    SELECT id FROM all_dev_geom WHERE mod_to_dev = $1;
$_$;


--
-- Name: aaa_listchildren(integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_listchildren(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_listchildren(integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_listchildren(integer) TO postgres;
GRANT ALL ON FUNCTION aaa_listchildren(integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_listchildren(integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

