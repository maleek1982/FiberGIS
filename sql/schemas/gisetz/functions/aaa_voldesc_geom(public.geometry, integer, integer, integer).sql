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
-- Name: aaa_voldesc_geom(public.geometry, integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_voldesc_geom(public.geometry, integer, integer, integer) RETURNS public.geometry
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    the_geom alias for $1;        -- point geometry 
    num alias for $2;        -- volocno number [1..128]
    flip alias for $3;            -- flip -1 or 1
    rot alias for $4;            -- rot 0,1,2 or 3

BEGIN

RETURN 
Translate(
  RotateZ(
    Translate(
        Scale(
            GeometryFromText(
            'POLYGON((-10 1,-1 1,-1 -1,-10 -1,-10 1))'),
flip  -- flop 1 or -1
        ,1,1),0,
num   -- smeshenie vniz na nomer volokna
    *(-2),0),
rot   -- povorot 0,1,2 or 3
  *(pi()/2)),
X(the_geom),
Y(the_geom)
);
 
END;
$_$;


--
-- Name: aaa_voldesc_geom(public.geometry, integer, integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_voldesc_geom(public.geometry, integer, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_voldesc_geom(public.geometry, integer, integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_voldesc_geom(public.geometry, integer, integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_voldesc_geom(public.geometry, integer, integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_voldesc_geom(public.geometry, integer, integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

