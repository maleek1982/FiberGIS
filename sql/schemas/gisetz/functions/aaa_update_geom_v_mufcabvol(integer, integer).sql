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
-- Name: aaa_update_geom_v_mufcabvol(integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_update_geom_v_mufcabvol(integer, integer) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    mid alias for $1;
    cabid alias for $2;

BEGIN

-- RETURN

UPDATE v_mufcabvol 

-- SET (the_geom_vol, the_geom_desc)=(aaa_volocno_geom(v_mufcab.the_geom, v_mufcabvol.volid, v_mufcab.flip, v_mufcab.rot),
-- aaa_voldesc_geom(v_mufcab.the_geom, v_mufcabvol.volid, v_mufcab.flip, v_mufcab.rot)) 
SET (the_geom_vol, the_geom_desc)=(aaa_vol_z_geom(v_mufcab.the_geom, v_mufcabvol.volid, v_mufcab.flip, v_mufcab.rot, 1),
aaa_voldesc_geom(v_mufcab.the_geom, v_mufcabvol.volid, v_mufcab.flip, v_mufcab.rot)) 

FROM v_mufcab

WHERE v_mufcab.mid=mid
  AND v_mufcabvol.mid=mid
  AND v_mufcab.cabid=cabid
  AND v_mufcabvol.cabid=cabid;
RETURN mid;
 
END;
$_$;


--
-- Name: aaa_update_geom_v_mufcabvol(integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_update_geom_v_mufcabvol(integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_update_geom_v_mufcabvol(integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_update_geom_v_mufcabvol(integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_update_geom_v_mufcabvol(integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_update_geom_v_mufcabvol(integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

