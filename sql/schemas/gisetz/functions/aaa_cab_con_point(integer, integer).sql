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
-- Name: aaa_cab_con_point(integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_cab_con_point(integer, integer) RETURNS public.geometry
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    mid alias for $1;
    cabid alias for $2;

    the_pointgeom geometry;
    mc_row v_mufcab%ROWTYPE;
    m_row v_mufta%ROWTYPE;
BEGIN

    SELECT v_mufcab.* INTO mc_row from v_mufcab
        where v_mufcab.mid = mid
        and v_mufcab.cabid = cabid;

    SELECT v_mufta.* INTO m_row from v_mufta
        where v_mufta.gid = mid;

    the_pointgeom = ST_Scale(ST_GeometryFromText('POINT(-18 -1)'),mc_row.flip,1*mc_row.vol_use,1); -- smeshenie vniz na nomer volokna volid
    the_pointgeom = ST_Translate(the_pointgeom,0,1*(-1),0); -- flop 1 or -1
    the_pointgeom = ST_RotateZ(the_pointgeom, mc_row.rot*(pi()/2)); -- povorot 0,1,2 or 3
    the_pointgeom = ST_Scale(the_pointgeom,0.005,0.005,1.0); -- 1/m_row.zoom,1/m_row.zoom,1)
    the_pointgeom = ST_Translate(the_pointgeom, ST_X(mc_row.the_geom), ST_Y(mc_row.the_geom));
    the_pointgeom = ST_SetSRID(the_pointgeom, 900913);

    RETURN the_pointgeom;

END;
$_$;


--
-- Name: FUNCTION aaa_cab_con_point(integer, integer); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_cab_con_point(integer, integer) IS '
Возвращает геометрию точки-середины-полигона-Кабеля в Муфте, по номеру-Муфты и номеру-Кабеля в ней.
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
-- Name: aaa_cab_con_point(integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_cab_con_point(integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_cab_con_point(integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_cab_con_point(integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_cab_con_point(integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_cab_con_point(integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

