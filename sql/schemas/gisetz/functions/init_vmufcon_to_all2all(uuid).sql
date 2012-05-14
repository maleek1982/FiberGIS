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
-- Name: init_vmufcon_to_all2all(uuid); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION init_vmufcon_to_all2all(uuid) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    uu_id alias for $1;
    mcon_row public.v_muf_con%ROWTYPE;
    mcv_row public.v_mufcabvol%ROWTYPE;
    mcv1_row public.v_mufcabvol%ROWTYPE;
    out_str text;
BEGIN
out_str='OK';

-- вносим данные из v_muf_con (все варки в муфтах с volid > 0)
    BEGIN
        SELECT * INTO STRICT mcon_row from public.v_muf_con c WHERE c.uu_id = uu_id and c.volid > 0 and c.volid1 > 0;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'NONE';
            WHEN TOO_MANY_ROWS THEN
                RETURN 'MANY';
    END;
    IF (mcon_row.proj >= 0) THEN
    
        SELECT * INTO STRICT mcv_row from public.v_mufcabvol mcv 
            WHERE mcv.mid = mcon_row.mid and mcv.cabid = mcon_row.cabid and mcv.volid = mcon_row.volid;

        SELECT * INTO STRICT mcv1_row from public.v_mufcabvol mcv 
            WHERE mcv.mid = mcon_row.mid1 and mcv.cabid = mcon_row.cabid1 and mcv.volid = mcon_row.volid1;

        INSERT INTO gisetz.z_all2all(
            table1, table1_uuid, 
            table2, table2_uuid, 
            p_table, p_table_uuid)
        VALUES (
            'v_mufcabvol', mcv_row.uu_id, 
            'v_mufcabvol', mcv1_row.uu_id, 
            'v_vol2vol', mcon_row.uu_id),
            (
            'v_mufcabvol', mcv1_row.uu_id, 
            'v_mufcabvol', mcv_row.uu_id, 
            'v_vol2vol', mcon_row.uu_id);

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
-- Name: init_vmufcon_to_all2all(uuid); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION init_vmufcon_to_all2all(uuid) FROM PUBLIC;
REVOKE ALL ON FUNCTION init_vmufcon_to_all2all(uuid) FROM postgres;
GRANT ALL ON FUNCTION init_vmufcon_to_all2all(uuid) TO postgres;
GRANT ALL ON FUNCTION init_vmufcon_to_all2all(uuid) TO PUBLIC;
GRANT ALL ON FUNCTION init_vmufcon_to_all2all(uuid) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

