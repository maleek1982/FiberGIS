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
-- Name: aaaaaaa(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaaaaaa(integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    conid alias for $1;
    mcv_row v_mufcabvol%ROWTYPE;
    mcv_row2 v_mufcabvol%ROWTYPE;
    mc_row v_mufcab%ROWTYPE;
    mc_row2 v_mufcab%ROWTYPE;
    m_row v_mufta%ROWTYPE;
    m_row2 v_mufta%ROWTYPE;
BEGIN


-- Start Point
    BEGIN
    SELECT v_mufcabvol.* INTO STRICT mcv_row from v_mufcabvol, v_muf_addcon 
    where Distance(v_mufcabvol.the_geom_vol, StartPoint(v_muf_addcon.the_geom))=0
    and v_muf_addcon.conid=conid;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN conid;
        WHEN TOO_MANY_ROWS THEN
        RETURN conid;
    END;

SELECT v_mufcab.* INTO mc_row from v_mufcab 
    where v_mufcab.mid = mcv_row.mid
    and v_mufcab.cabid = mcv_row.cabid;

SELECT v_mufta.* INTO m_row from v_mufta 
    where v_mufta.gid = mcv_row.mid;

UPDATE v_muf_addcon SET (the_geom) = (SetPoint(the_geom, 0, 
    aaa_volp_z_geom(mc_row.the_geom, mcv_row.volid, mc_row.flip, mc_row.rot, m_row.zoom)
    ))
    WHERE v_muf_addcon.conid=conid;


-- End Point
    BEGIN
    SELECT v_mufcabvol.* INTO STRICT mcv_row2 from v_mufcabvol, v_muf_addcon 
    where Distance(v_mufcabvol.the_geom_vol, EndPoint(v_muf_addcon.the_geom))=0
    and v_muf_addcon.conid=conid;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN conid;
        WHEN TOO_MANY_ROWS THEN
        RETURN conid;
    END;

SELECT v_mufcab.* INTO mc_row2 from v_mufcab 
    where v_mufcab.mid = mcv_row2.mid
    and v_mufcab.cabid = mcv_row2.cabid;

SELECT v_mufta.* INTO m_row2 from v_mufta 
    where v_mufta.gid = mcv_row2.mid;

UPDATE v_muf_addcon SET (the_geom) = (SetPoint(the_geom, (npoints(the_geom)-1), 
    aaa_volp_z_geom(mc_row2.the_geom, mcv_row2.volid, mc_row2.flip, mc_row2.rot, m_row2.zoom)
    ))
    WHERE v_muf_addcon.conid=conid;


RETURN ' m-' || mcv_row.mid || ' c-' || mcv_row.cabid || ' v-' || mcv_row.volid || '    m-' || mcv_row2.mid || ' c-' || mcv_row2.cabid || ' v-' || mcv_row2.volid;
 
END;
$_$;


--
-- Name: aaaaaaa(integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaaaaaa(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaaaaaa(integer) FROM postgres;
GRANT ALL ON FUNCTION aaaaaaa(integer) TO postgres;
GRANT ALL ON FUNCTION aaaaaaa(integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaaaaaa(integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

