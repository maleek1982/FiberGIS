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
-- Name: aaa_all_dev_to_mufcab(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_all_dev_to_mufcab() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    i integer;
--    mcv_row public.v_mufcabvol%ROWTYPE;
--    mcv1_row public.v_mufcabvol%ROWTYPE;
BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
        -- Помечаем сварку как удаленную
        UPDATE public.all_dev_to_mufcab SET deleted=-9999 WHERE uu_id=OLD.uu_id;
        --UPDATE public.v_muf_con SET deleted=-9999, dinst=now(), proj=-1 WHERE uu_id=OLD.uu_id;
        -- ЗАКОНЧИЛИ Помечаем сварку как удаленную
    RETURN NULL;

    ELSIF (TG_OP = 'INSERT')THEN
        --IF (NEW.the_geom IS NULL) THEN
        --NEW.the_geom := MakeLine(aaa_vol_point(NEW.mid, NEW.cabid, NEW.volid), aaa_vol_point(NEW.mid1, NEW.cabid1, NEW.volid1));
        --END IF;
        -- Вставляем сварку с пометкой "удаленная"
        NEW.deleted = -9999;
        -- ЗАКОНЧИЛИ Вставляем сварку с пометкой "удаленная"
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN

        --IF (NEW.the_geom IS NULL) THEN
        --NEW.the_geom := MakeLine(aaa_vol_point(OLD.mid, OLD.cabid, OLD.volid), aaa_vol_point(OLD.mid1, OLD.cabid1, OLD.volid1));
        --END IF;

        NEW.mid = OLD.mid;
        NEW.cabid = OLD.cabid;
        NEW.all_dev_id = OLD.all_dev_id;
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NULL;

    ELSIF (TG_OP = 'INSERT') THEN
        -- Убираем пометку "удаленная" со свежевставленной сварки
        UPDATE public.all_dev_to_mufcab SET deleted=0 WHERE uu_id=NEW.uu_id;
        -- ЗАКОНЧИЛИ Убираем пометку "удаленная" со свежевставленной сварки
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
        -- Чистим таблицу gisetz.z_all2all, если сварка помечена как "удаленная"
        IF (NEW.deleted < 0) THEN
            DELETE FROM gisetz.z_all2all WHERE p_table_uuid = OLD.uu_id;
        END IF;
        -- ЗАКОНЧИЛИ Чистим таблицу gisetz.z_all2all, если сварка помечена как "удаленная"
        -- Заполняем таблицу gisetz.z_all2all
        IF (NEW.deleted >= 0 and OLD.deleted < 0) THEN
            PERFORM gisetz.init_alldevtomufcab_to_all2all(NEW.uu_id);
        END IF;
        -- ЗАКОНЧИЛИ Заполняем таблицу gisetz.z_all2all    
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_all_dev_to_mufcab(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_all_dev_to_mufcab() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_all_dev_to_mufcab() FROM postgres;
GRANT ALL ON FUNCTION aaa_all_dev_to_mufcab() TO postgres;
GRANT ALL ON FUNCTION aaa_all_dev_to_mufcab() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_all_dev_to_mufcab() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

