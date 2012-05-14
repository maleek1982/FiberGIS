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
-- Name: tmv_vcabcon_to_zall2all_ut(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION tmv_vcabcon_to_zall2all_ut() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    new_length double precision;
    new_attenuation double precision;

BEGIN

    new_length = ST_Length3D_Spheroid(ST_Transform(NEW.the_geom, 4326), 'SPHEROID["WGS_1984", 6378137.0, 298.257223563]');
    new_attenuation = 0.4 * (new_length/1000.0);

    -- protect some changes
    NEW.uu_id = OLD.uu_id;
    NEW.mid = OLD.mid;
    NEW.cabid = OLD.cabid;
    NEW.mid1 = OLD.mid1;
    NEW.cabid1 = OLD.cabid1;
    --
    
    UPDATE z_all2all
        SET length=new_length, attenuation=new_attenuation
        WHERE p_table_uuid = NEW.uu_id;

    RETURN NEW;

END;
$$;


--
-- Name: tmv_vcabcon_to_zall2all_ut(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION tmv_vcabcon_to_zall2all_ut() FROM PUBLIC;
REVOKE ALL ON FUNCTION tmv_vcabcon_to_zall2all_ut() FROM postgres;
GRANT ALL ON FUNCTION tmv_vcabcon_to_zall2all_ut() TO postgres;
GRANT ALL ON FUNCTION tmv_vcabcon_to_zall2all_ut() TO PUBLIC;
GRANT ALL ON FUNCTION tmv_vcabcon_to_zall2all_ut() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

