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
-- Name: aaa_cab_con(integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_cab_con(integer, integer) RETURNS public.geometry
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    mid alias for $1;
    cabid alias for $2;

    the_polygeom geometry;
    mc_row v_mufcab%ROWTYPE;
    m_row v_mufta%ROWTYPE;
BEGIN

    SELECT v_mufcab.* INTO mc_row from v_mufcab
        where v_mufcab.mid = mid
        and v_mufcab.cabid = cabid;

    SELECT v_mufta.* INTO m_row from v_mufta
        where v_mufta.gid = mid;


    the_polygeom = ST_Scale(ST_GeometryFromText('POLYGON((-19 0,-17 0,-17 -1,-19 -1,-19 0))'),mc_row.flip,2*mc_row.vol_use,1); -- flop 1 or -1
    the_polygeom = ST_Translate(the_polygeom,0,1*(-1),0); -- smeshenie vniz na nomer volokna volid
    the_polygeom = ST_RotateZ(the_polygeom, mc_row.rot*(pi()/2)); -- povorot 0,1,2 or 3
    the_polygeom = ST_Scale(the_polygeom,0.005,0.005,1.0); -- 1/m_row.zoom,1/m_row.zoom,1)
    the_polygeom = ST_Translate(the_polygeom, ST_X(mc_row.the_geom), ST_Y(mc_row.the_geom));
    the_polygeom = ST_SetSRID(the_polygeom, 900913);

    RETURN the_polygeom;

END;
$_$;


--
-- Name: FUNCTION aaa_cab_con(integer, integer); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_cab_con(integer, integer) IS '
Возвращает геометрию полигона-Кабеля в Муфте, по номеру-Муфты и номеру-Кабеля в ней.
Использует таблицы:
    v_mufta - Муфты.
        значения:
        хм... странно, никакие...
    v_mufcab - Кабель в муфте.
        значения:
        flip - зеркальное отображение (1 или -1),
        rot - вращение кабеля (0,1,2 или 3),
        vol_use - кол-во используемых волокон,
        the_geom - геометрия-точка за которую можно перетаскивать кабель.
';


--
-- Name: aaa_cab_con(integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_cab_con(integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_cab_con(integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_cab_con(integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_cab_con(integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_cab_con(integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

