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
-- Name: init_alldevgeom_to_all2all(uuid); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION init_alldevgeom_to_all2all(uuid) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    uu_id alias for $1;
    dr public.all_dev_geom%ROWTYPE;
    dtr public.dev_type%ROWTYPE;
--    mcv_row public.v_mufcabvol%ROWTYPE;
--    port_row public.all_port_geom%ROWTYPE;
    out_str text;
BEGIN
out_str='OK';

-- вносим данные из all_dev_geom (все связи внутри устройства)
    BEGIN
        SELECT * INTO STRICT dr from public.all_dev_geom c WHERE c.uu_id = uu_id;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'NONE';
            WHEN TOO_MANY_ROWS THEN
                RETURN 'MANY';
    END;

    BEGIN
        SELECT * INTO STRICT dtr from public.dev_type c WHERE c.id = dr.dev_type_id;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'NONE';
            WHEN TOO_MANY_ROWS THEN
                RETURN 'MANY';
    END;

    DELETE FROM gisetz.z_all2all WHERE p_table_uuid = dr.uu_id;

    INSERT INTO gisetz.z_all2all(

        table1, table1_uuid, 
        table2, table2_uuid, 
        p_table, p_table_uuid,
        lambda)
        
        SELECT 
        'all_port_geom' as table1, 
            p1.uu_id as table1_uuid, 
        'all_port_geom' as table2, 
            p2.uu_id as table2_uuid, 
        'all_dev_geom' as p_table, 
            dr.uu_id as p_table_uuid,
        dpc.lambda as lambda
        FROM public.all_port_geom p1, public.all_port_geom p2, gisetz.dev_port_con dpc
            WHERE p1.dev_id = dr.id and p2.dev_id = dr.id and 

            dpc.dev_type_id = dtr.id and

            p1.port_id = dpc.dev_port_id and p2.port_id = dpc.dev_port_id1;


    INSERT INTO gisetz.z_all2all(

        table1, table1_uuid, 
        table2, table2_uuid, 
        p_table, p_table_uuid,
        lambda)
        
        SELECT 
        'all_port_geom' as table1, 
            p1.uu_id as table1_uuid, 
        'all_port_geom' as table2, 
            p2.uu_id as table2_uuid, 
        'all_dev_geom' as p_table, 
            dr.uu_id as p_table_uuid,
        dpc.lambda as lambda
        FROM public.all_port_geom p1, public.all_port_geom p2, gisetz.dev_port_con dpc
            WHERE p1.dev_id = dr.id and p2.dev_id = dr.id and 

            dpc.dev_type_id = dtr.id and

            p2.port_id = dpc.dev_port_id and p1.port_id = dpc.dev_port_id1;

--Закончили вносим данные из v_cab_con (все кабеля между муфтами)

RETURN out_str;

END;
$_$;


--
-- Name: init_alldevgeom_to_all2all(uuid); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION init_alldevgeom_to_all2all(uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION init_alldevgeom_to_all2all(uuid) FROM postgres;
GRANT ALL ON FUNCTION init_alldevgeom_to_all2all(uuid) TO postgres;
GRANT ALL ON FUNCTION init_alldevgeom_to_all2all(uuid) TO PUBLIC;
GRANT ALL ON FUNCTION init_alldevgeom_to_all2all(uuid) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

