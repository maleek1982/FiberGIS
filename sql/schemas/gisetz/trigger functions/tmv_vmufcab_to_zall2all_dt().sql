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
-- Name: tmv_vmufcab_to_zall2all_dt(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION tmv_vmufcab_to_zall2all_dt() RETURNS trigger
    LANGUAGE plpgsql STRICT
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    att_db double precision;
BEGIN

    DELETE FROM z_all2all WHERE p_table_uuid = OLD.uu_id;

    RETURN OLD;

END;
$$;


--
-- Name: tmv_vmufcab_to_zall2all_dt(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION tmv_vmufcab_to_zall2all_dt() FROM PUBLIC;
REVOKE ALL ON FUNCTION tmv_vmufcab_to_zall2all_dt() FROM postgres;
GRANT ALL ON FUNCTION tmv_vmufcab_to_zall2all_dt() TO postgres;
GRANT ALL ON FUNCTION tmv_vmufcab_to_zall2all_dt() TO PUBLIC;
GRANT ALL ON FUNCTION tmv_vmufcab_to_zall2all_dt() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

