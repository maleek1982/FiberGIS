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
-- Name: aaa_v_mufcabvol_restr_afupd(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_v_mufcabvol_restr_afupd() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    i integer;
BEGIN

IF (NEW.vol_type_def > OLD.vol_type_def and NEW.vol_type_def > 10) THEN
    PERFORM aaa_st_name_propagation(NEW.mid, NEW.cabid, NEW.volid);
END IF;
RETURN NEW;

END;
$$;


--
-- Name: aaa_v_mufcabvol_restr_afupd(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_v_mufcabvol_restr_afupd() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_v_mufcabvol_restr_afupd() FROM postgres;
GRANT ALL ON FUNCTION aaa_v_mufcabvol_restr_afupd() TO postgres;
GRANT ALL ON FUNCTION aaa_v_mufcabvol_restr_afupd() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_v_mufcabvol_restr_afupd() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

