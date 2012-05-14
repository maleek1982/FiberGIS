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
-- Name: init_vmufcab_to_all2all(uuid); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION init_vmufcab_to_all2all(uuid) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    init_uu_id alias for $1;
    mufcab_row public.v_cab_con%ROWTYPE;
    out_str text;
BEGIN
out_str='OK';

        -- 1) Нужно сформировать в таблице gisetz.z_all2all все связи между "кабелем" и волокнами,
        -- в качестве p_table_uuid будем использовать uuid "кабеля"

-- вносим данные из v_mufcab (все каличные "кабеля" разветвители и cwdm)
    BEGIN
        SELECT * INTO STRICT mufcab_row FROM public.v_mufcab mc WHERE mc.uu_id = init_uu_id;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'NONE';
            WHEN TOO_MANY_ROWS THEN
                RETURN 'MANY';
    END;

    INSERT INTO gisetz.z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
        SELECT 
        'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
        'v_mufcab' as table2, init_uu_id as table2_uuid, 
        'v_mufcab' as p_table, init_uu_id as p_table_uuid
        FROM public.v_mufcabvol mcv
            WHERE mcv.mid = mufcab_row.mid and mcv.cabid = mufcab_row.cabid;

    INSERT INTO gisetz.z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
        SELECT 
        'v_mufcab' as table1, init_uu_id as table1_uuid, 
        'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
        'v_mufcab' as p_table, init_uu_id as p_table_uuid
        FROM public.v_mufcabvol mcv
            WHERE mcv.mid = mufcab_row.mid and mcv.cabid = mufcab_row.cabid;

--Закончили вносим данные из v_mufcab (все каличные "кабеля" разветвители и cwdm)

RETURN out_str;

END;
$_$;


--
-- PostgreSQL database dump complete
--

