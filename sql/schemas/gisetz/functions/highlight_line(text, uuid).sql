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
-- Name: highlight_line(text, uuid); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION highlight_line(text, uuid) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    table_name alias for $1;
    uuid4select alias for $2;
BEGIN

IF ('v_vol2vol' = table_name) THEN

    INSERT INTO gisetz.highlight(the_geom)
        SELECT the_geom    FROM public.v_muf_con WHERE uu_id = uuid4select;

ELSIF ('v_cab_con' = table_name) THEN

    INSERT INTO gisetz.highlight(the_geom)
        SELECT the_geom    FROM public.v_cab_con WHERE uu_id = uuid4select;

ELSIF ('all_dev_to_mufcab' = table_name) THEN

    RETURN 0;

ELSIF ('all_con_port' = table_name) THEN

    INSERT INTO gisetz.highlight(the_geom)
        SELECT the_geom    FROM public.all_con_port WHERE uu_id = uuid4select;

END IF;

RETURN 1;

END;
$_$;


--
-- Name: highlight_line(text, uuid); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION highlight_line(text, uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION highlight_line(text, uuid) FROM postgres;
GRANT ALL ON FUNCTION highlight_line(text, uuid) TO postgres;
GRANT ALL ON FUNCTION highlight_line(text, uuid) TO PUBLIC;
GRANT ALL ON FUNCTION highlight_line(text, uuid) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

