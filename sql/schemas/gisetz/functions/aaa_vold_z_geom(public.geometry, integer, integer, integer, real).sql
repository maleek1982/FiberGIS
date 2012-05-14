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
-- Name: aaa_vold_z_geom(public.geometry, integer, integer, integer, real); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_vold_z_geom(public.geometry, integer, integer, integer, real) RETURNS public.geometry
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    the_geom alias for $1;        -- point geometry 
    num alias for $2;        -- volocno number [1..128]
    flip alias for $3;            -- flip -1 or 1
    rot alias for $4;            -- rot 0,1,2 or 3
    zoom alias for $5;
BEGIN

RETURN 
Translate(
Scale(
  RotateZ(
    Translate(
        Scale(
            GeometryFromText(
            'POLYGON((-2 1,-12 1,-12 -1,-2 -1,-2 1))'),
flip  -- flop 1 or -1
        ,1,1),0,
num   -- smeshenie vniz na nomer volokna
    *(-2),0),
rot   -- povorot 0,1,2 or 3
  *(pi()/2)),
1/zoom,1/zoom,1
),
X(the_geom),
Y(the_geom)
);
 
END;
$_$;


--
-- Name: aaa_vold_z_geom(public.geometry, integer, integer, integer, real); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_vold_z_geom(public.geometry, integer, integer, integer, real) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_vold_z_geom(public.geometry, integer, integer, integer, real) FROM postgres;
GRANT ALL ON FUNCTION aaa_vold_z_geom(public.geometry, integer, integer, integer, real) TO postgres;
GRANT ALL ON FUNCTION aaa_vold_z_geom(public.geometry, integer, integer, integer, real) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_vold_z_geom(public.geometry, integer, integer, integer, real) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

