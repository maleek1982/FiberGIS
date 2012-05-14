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
-- Name: aaa_vol_angle(integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_vol_angle(integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    mid alias for $1; 
    cabid alias for $2;
    volid alias for $3;
    mc_row v_mufcab%ROWTYPE;
BEGIN

    SELECT v_mufcab.* INTO mc_row from v_mufcab 
        where v_mufcab.mid = mid
        and v_mufcab.cabid = cabid;

RETURN mc_row.rot*90;
 
END;
$_$;


--
-- Name: aaa_vol_angle(integer, integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_vol_angle(integer, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_vol_angle(integer, integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_vol_angle(integer, integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_vol_angle(integer, integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_vol_angle(integer, integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

