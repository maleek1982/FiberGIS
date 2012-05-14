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
-- Name: tmv_vmufcab_to_zall2all_it(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION tmv_vmufcab_to_zall2all_it() RETURNS trigger
    LANGUAGE plpgsql STRICT
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $_$
DECLARE
    att_db double precision;
BEGIN

    -- IF new.descr like 5% 10% 50% etc, vol_use must be =2, but not controled
    -- GO
    IF (NEW.descr ~* '[[:digit:]+]%$') THEN
        
        att_db = 0.2 - log((1.0-(SUBSTRING(NEW.descr, '[^0-9]*([0-9]*)%[^0-9]*')::double precision)/100))*10;
        INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid, length, attenuation)
            SELECT 
            'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
            'v_mufcab' as table2, NEW.uu_id as table2_uuid, 
            'v_mufcab' as p_table, NEW.uu_id as p_table_uuid,
            0.2::double precision as length,
            att_db as attenuation
            FROM v_mufcabvol mcv
                WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid and mcv.volid = 1;
        INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid, length, attenuation)
            SELECT 
            'v_mufcab' as table1, NEW.uu_id as table1_uuid, 
            'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
            'v_mufcab' as p_table, NEW.uu_id as p_table_uuid,
            0.2::double precision as length,
            att_db as attenuation
            FROM v_mufcabvol mcv
                WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid and mcv.volid = 1;
    
        att_db = 0.2 - log(((SUBSTRING(NEW.descr, '[^0-9]*([0-9]*)%[^0-9]*')::double precision)/100))*10;
        INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid, length, attenuation)
            SELECT 
            'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
            'v_mufcab' as table2, NEW.uu_id as table2_uuid, 
            'v_mufcab' as p_table, NEW.uu_id as p_table_uuid,
            0.2::double precision as length,
            att_db as attenuation
            FROM v_mufcabvol mcv
                WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid and mcv.volid = 2;
        INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid, length, attenuation)
            SELECT 
            'v_mufcab' as table1, NEW.uu_id as table1_uuid, 
            'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
            'v_mufcab' as p_table, NEW.uu_id as p_table_uuid,
            0.2::double precision as length,
            att_db as attenuation
            FROM v_mufcabvol mcv
                WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid and mcv.volid = 2;
    
    END IF;
    -- OK

    -- IF new.descr like 1:2 1:4 1:n etc, vol_use must be 2 4 ... n, but not controled
    -- GO
    IF (( NEW.descr IN ('1:n','1:2','1:4','1:8')) and (NEW.vol_use > 0 )) THEN
        
        INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid, length, attenuation)
            SELECT 
            'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
            'v_mufcab' as table2, NEW.uu_id as table2_uuid, 
            'v_mufcab' as p_table, NEW.uu_id as p_table_uuid,
            0.2::double precision as length,
            0.2 - log(1::double precision/NEW.vol_use)*10 as attenuation
            FROM v_mufcabvol mcv
                WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid;

        INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid, length, attenuation)
            SELECT 
            'v_mufcab' as table1, NEW.uu_id as table1_uuid, 
            'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
            'v_mufcab' as p_table, NEW.uu_id as p_table_uuid,
            0.2::double precision as length,
            0.2 - log(1::double precision/NEW.vol_use)*10 as attenuation
            FROM v_mufcabvol mcv
                WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid;

    END IF;
    -- OK

    RETURN NEW;

END;
$_$;


--
-- Name: tmv_vmufcab_to_zall2all_it(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION tmv_vmufcab_to_zall2all_it() FROM PUBLIC;
REVOKE ALL ON FUNCTION tmv_vmufcab_to_zall2all_it() FROM postgres;
GRANT ALL ON FUNCTION tmv_vmufcab_to_zall2all_it() TO postgres;
GRANT ALL ON FUNCTION tmv_vmufcab_to_zall2all_it() TO PUBLIC;
GRANT ALL ON FUNCTION tmv_vmufcab_to_zall2all_it() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

