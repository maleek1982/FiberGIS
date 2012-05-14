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
-- Name: tmv_vcabcon_to_zall2all_it(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION tmv_vcabcon_to_zall2all_it() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    new_length double precision;
    new_attenuation double precision;

BEGIN

    new_length = ST_Length3D_Spheroid(ST_Transform(NEW.the_geom, 4326), 'SPHEROID["WGS_1984", 6378137.0, 298.257223563]');
    new_attenuation = 0.4 * (new_length/1000.0);
    
    INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid, length, attenuation)
        SELECT 
        'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
        'v_mufcabvol' as table2, mcv1.uu_id as table2_uuid, 
        'v_cab_con' as p_table, NEW.uu_id as p_table_uuid,
        new_length as length, new_attenuation as attenuation
        FROM v_mufcabvol mcv, v_mufcabvol mcv1
            WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid and
            mcv1.mid = NEW.mid1 and mcv1.cabid = NEW.cabid1 and
            mcv.volid = mcv1.volid;

    INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid, length, attenuation)
        SELECT 
        'v_mufcabvol' as table1, mcv1.uu_id as table1_uuid, 
        'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
        'v_cab_con' as p_table, NEW.uu_id as p_table_uuid,
        new_length as length, new_attenuation as attenuation
        FROM v_mufcabvol mcv, v_mufcabvol mcv1
            WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid and
            mcv1.mid = NEW.mid1 and mcv1.cabid = NEW.cabid1 and
            mcv.volid = mcv1.volid;

    RETURN NEW;

END;
$$;


--
-- Name: tmv_vcabcon_to_zall2all_it(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION tmv_vcabcon_to_zall2all_it() FROM PUBLIC;
REVOKE ALL ON FUNCTION tmv_vcabcon_to_zall2all_it() FROM postgres;
GRANT ALL ON FUNCTION tmv_vcabcon_to_zall2all_it() TO postgres;
GRANT ALL ON FUNCTION tmv_vcabcon_to_zall2all_it() TO PUBLIC;
GRANT ALL ON FUNCTION tmv_vcabcon_to_zall2all_it() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

