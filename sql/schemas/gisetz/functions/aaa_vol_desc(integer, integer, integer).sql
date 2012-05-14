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
-- Name: aaa_vol_desc(integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_vol_desc(integer, integer, integer) RETURNS public.geometry
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    mid alias for $1; 
    cabid alias for $2;
    volid alias for $3;
    mc_row v_mufcab%ROWTYPE;
    m_row v_mufta%ROWTYPE;
    the_polygeom geometry;
BEGIN

    SELECT v_mufcab.* INTO mc_row from v_mufcab 
        where v_mufcab.mid = mid
        and v_mufcab.cabid = cabid;

    SELECT v_mufta.* INTO m_row from v_mufta 
        where v_mufta.gid = mid;


the_polygeom = Translate(

Scale(
  RotateZ(
    Translate(
        Scale(
            GeometryFromText(
            'POLYGON((-15 1,-2 1,-2 -1,-15 -1,-15 1))'),
mc_row.flip  -- flop 1 or -1
        ,1,1),0,
volid   -- smeshenie vniz na nomer volokna
    *(-2),0),
mc_row.rot   -- povorot 0,1,2 or 3
  *(pi()/2)),
-- 1/m_row.zoom,1/m_row.zoom,1)
0.005,0.005,1.0)

,
X(mc_row.the_geom),
Y(mc_row.the_geom)
);
    the_polygeom = ST_SetSRID(the_polygeom, 900913);

    RETURN the_polygeom;
 
END;
$_$;


--
-- Name: aaa_vol_desc(integer, integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_vol_desc(integer, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_vol_desc(integer, integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_vol_desc(integer, integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_vol_desc(integer, integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_vol_desc(integer, integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

