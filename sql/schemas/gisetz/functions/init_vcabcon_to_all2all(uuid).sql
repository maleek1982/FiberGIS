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
-- Name: init_vcabcon_to_all2all(uuid); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION init_vcabcon_to_all2all(uuid) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    uu_id alias for $1;
    cabcon_row v_cab_con%ROWTYPE;
    mcv_row v_mufcabvol%ROWTYPE;
    mcv1_row v_mufcabvol%ROWTYPE;
    out_str text;
BEGIN
out_str='OK';

-- вносим данные из v_cab_con (все кабеля между муфтами)
    BEGIN
        SELECT * INTO STRICT cabcon_row from v_cab_con c WHERE c.uu_id = uu_id and c.deleted >= 0;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'NONE';
            WHEN TOO_MANY_ROWS THEN
                RETURN 'MANY';
    END;

    INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
        SELECT 
        'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
        'v_mufcabvol' as table2, mcv1.uu_id as table2_uuid, 
        'v_cab_con' as p_table, cabcon_row.uu_id as p_table_uuid
        FROM v_mufcabvol mcv, v_mufcabvol mcv1
            WHERE mcv.mid = cabcon_row.mid and mcv.cabid = cabcon_row.cabid and
            mcv1.mid = cabcon_row.mid1 and mcv1.cabid = cabcon_row.cabid1 and
            mcv.volid = mcv1.volid;

    INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
        SELECT 
        'v_mufcabvol' as table1, mcv1.uu_id as table1_uuid, 
        'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
        'v_cab_con' as p_table, cabcon_row.uu_id as p_table_uuid
        FROM v_mufcabvol mcv, v_mufcabvol mcv1
            WHERE mcv.mid = cabcon_row.mid and mcv.cabid = cabcon_row.cabid and
            mcv1.mid = cabcon_row.mid1 and mcv1.cabid = cabcon_row.cabid1 and
            mcv.volid = mcv1.volid;

--Закончили вносим данные из v_cab_con (все кабеля между муфтами)

RETURN out_str;

END;
$_$;


--
-- Name: init_vcabcon_to_all2all(uuid); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION init_vcabcon_to_all2all(uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION init_vcabcon_to_all2all(uuid) FROM postgres;
GRANT ALL ON FUNCTION init_vcabcon_to_all2all(uuid) TO postgres;
GRANT ALL ON FUNCTION init_vcabcon_to_all2all(uuid) TO PUBLIC;
GRANT ALL ON FUNCTION init_vcabcon_to_all2all(uuid) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

