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
-- Name: init_allconport_to_all2all(uuid); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION init_allconport_to_all2all(uuid) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    uu_id alias for $1;
    con_row all_con_port%ROWTYPE;
    p_row all_port_geom%ROWTYPE;
    p1_row all_port_geom%ROWTYPE;
    out_str text;
BEGIN
out_str='OK';

-- вносим данные из v_muf_con (все варки в муфтах с volid > 0)
    BEGIN
        SELECT * INTO STRICT con_row from all_con_port c WHERE c.uu_id = uu_id;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'NONE';
            WHEN TOO_MANY_ROWS THEN
                RETURN 'MANY';
    END;
    IF (con_row.proj >= 0) THEN
    
        SELECT * INTO STRICT p_row from all_port_geom p 
            WHERE p.dev_id = con_row.apg_dev_id and p.port_id = con_row.apg_port_id;

        SELECT * INTO STRICT p1_row from all_port_geom p 
            WHERE p.dev_id = con_row.apg_dev_id1 and p.port_id = con_row.apg_port_id1;

        INSERT INTO z_all2all(
            table1, table1_uuid, 
            table2, table2_uuid, 
            p_table, p_table_uuid,
            lambda, con_type)
        VALUES (
            'all_port_geom', p_row.uu_id, 
            'all_port_geom', p1_row.uu_id, 
            'all_con_port', con_row.uu_id,
            con_row.lambda, con_row.con_type),
            (
            'all_port_geom', p1_row.uu_id, 
            'all_port_geom', p_row.uu_id, 
            'all_con_port', con_row.uu_id,
            con_row.lambda, con_row.con_type);

    ELSE

        out_str='NO_PROJ';
    
    END IF;
--Закончили вносим данные из v_muf_con (все варки в муфтах с volid > 0)

-- вносим данные из v_muf_con (все варки в муфтах с volid = 0, т.е. обрабатываем разветвители)
--Закончили вносим данные из v_muf_con (все варки в муфтах с volid = 0, т.е. обрабатываем разветвители)

RETURN out_str;

END;
$_$;


--
-- Name: init_allconport_to_all2all(uuid); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION init_allconport_to_all2all(uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION init_allconport_to_all2all(uuid) FROM postgres;
GRANT ALL ON FUNCTION init_allconport_to_all2all(uuid) TO postgres;
GRANT ALL ON FUNCTION init_allconport_to_all2all(uuid) TO PUBLIC;
GRANT ALL ON FUNCTION init_allconport_to_all2all(uuid) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

