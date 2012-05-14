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
-- Name: init_alldevtomufcab_to_all2all(uuid); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION init_alldevtomufcab_to_all2all(uuid) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    uu_id alias for $1;
    con_row public.all_dev_to_mufcab%ROWTYPE;
--    mcv_row public.v_mufcabvol%ROWTYPE;
--    port_row public.all_port_geom%ROWTYPE;
    out_str text;
BEGIN
out_str='OK';

-- вносим данные из v_cab_con (все кабеля между муфтами)
    BEGIN
        SELECT * INTO STRICT con_row from public.all_dev_to_mufcab c WHERE c.uu_id = uu_id and c.deleted >= 0;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'NONE';
            WHEN TOO_MANY_ROWS THEN
                RETURN 'MANY';
    END;

    INSERT INTO gisetz.z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
        SELECT 
        'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
        'all_port_geom' as table2, port.uu_id as table2_uuid, 
        'all_dev_to_mufcab' as p_table, con_row.uu_id as p_table_uuid
        FROM public.v_mufcabvol mcv, public.all_port_geom port
            WHERE mcv.mid = con_row.mid and mcv.cabid = con_row.cabid and
            port.dev_id = con_row.all_dev_id and
            mcv.volid = port.port_id;

    INSERT INTO gisetz.z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
        SELECT 
        'all_port_geom' as table1, port.uu_id as table1_uuid, 
        'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
        'all_dev_to_mufcab' as p_table, con_row.uu_id as p_table_uuid
        FROM public.v_mufcabvol mcv, public.all_port_geom port
            WHERE mcv.mid = con_row.mid and mcv.cabid = con_row.cabid and
            port.dev_id = con_row.all_dev_id and
            mcv.volid = port.port_id;

--Закончили вносим данные из v_cab_con (все кабеля между муфтами)

RETURN out_str;

END;
$_$;


--
-- Name: init_alldevtomufcab_to_all2all(uuid); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION init_alldevtomufcab_to_all2all(uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION init_alldevtomufcab_to_all2all(uuid) FROM postgres;
GRANT ALL ON FUNCTION init_alldevtomufcab_to_all2all(uuid) TO postgres;
GRANT ALL ON FUNCTION init_alldevtomufcab_to_all2all(uuid) TO PUBLIC;
GRANT ALL ON FUNCTION init_alldevtomufcab_to_all2all(uuid) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

