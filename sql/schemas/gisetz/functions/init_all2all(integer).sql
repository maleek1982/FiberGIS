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
-- Name: init_all2all(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION init_all2all(integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    init_state alias for $1;
    out_str text;
BEGIN
out_str='';

-- чистим таблицу gisetz.z_all2all
DELETE FROM gisetz.z_all2all;
--Закончили чистим таблицу gisetz.z_all2all

-- вносим данные из v_muf_con (все варки в муфтах с volid > 0)
    -- gisetz.init_vmufcon_to_all2all(uuid)
    PERFORM gisetz.init_vmufcon_to_all2all(uu_id) 
            FROM v_muf_con 
            WHERE deleted >= 0 and volid > 0 and volid1 > 0;
--Закончили вносим данные из v_muf_con (все варки в муфтах с volid > 0)

-- вносим данные из v_muf_con (все варки в муфтах с volid = 0, т.е. обрабатываем разветвители)
--Закончили вносим данные из v_muf_con (все варки в муфтах с volid = 0, т.е. обрабатываем разветвители)

-- вносим данные из v_cab_con (все кабеля между муфтами)
    -- gisetz.init_vcabcon_to_all2all(uuid)
    PERFORM gisetz.init_vcabcon_to_all2all(uu_id) 
            FROM public.v_cab_con 
            WHERE deleted >= 0;
--Закончили вносим данные из v_cab_con (все кабеля между муфтами)

-- вносим данные из all_dev_to_mufcab (соеденяет кабель в муфте с ODF-ом)
    -- gisetz.init_alldevtomufcab_to_all2all(uuid)
    PERFORM gisetz.init_alldevtomufcab_to_all2all(uu_id) 
            FROM public.all_dev_to_mufcab 
            WHERE deleted >= 0;
--Закончили вносим данные из all_dev_to_mufcab (соеденяет кабель в муфте с ODF-ом)

-- вносим данные из all_con_port (все коммутации между активным оборудованием, ODF, CWDM, etc.)
    -- gisetz.init_allconport_to_all2all(uuid)
    PERFORM gisetz.init_allconport_to_all2all(uu_id) 
            FROM public.all_con_port 
            WHERE deleted >= 0 and con_type <> 44;
--Закончили вносим данные из all_con_port (все коммутации между активным оборудованием, ODF, CWDM, etc.)

-- вносим данные из all_dev_geom
    UPDATE all_dev_geom SET podgon=1 
        FROM dev_type dt
        WHERE dev_type_id = dt.id  and  dt.get_port_descr_type = 'cwdm';
--Закончили вносим данные из all_dev_geom

RETURN out_str;

END;
$_$;


--
-- Name: init_all2all(integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION init_all2all(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION init_all2all(integer) FROM postgres;
GRANT ALL ON FUNCTION init_all2all(integer) TO postgres;
GRANT ALL ON FUNCTION init_all2all(integer) TO PUBLIC;
GRANT ALL ON FUNCTION init_all2all(integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

