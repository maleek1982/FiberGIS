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
-- Name: aaa_con_update(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_con_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    i integer;
    mcv_row v_mufcabvol%ROWTYPE;
    mcv1_row v_mufcabvol%ROWTYPE;
--    mc_row v_mufcab%ROWTYPE;
--    mc1_row v_mufcab%ROWTYPE;
BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
        IF (-9999 = OLD.deleted) THEN
            RETURN OLD;
        END IF;
        -- Помечаем сварку как удаленную
        --UPDATE v_muf_con SET deleted=-9999, dinst=now() WHERE uu_id=OLD.uu_id;
        UPDATE v_muf_con SET deleted=-9999, dinst=now(), proj=-1 WHERE uu_id=OLD.uu_id;
        -- ЗАКОНЧИЛИ Помечаем сварку как удаленную
    RETURN NULL;

    ELSIF (TG_OP = 'INSERT')THEN
        IF (NEW.the_geom IS NULL) THEN
        NEW.the_geom := MakeLine(aaa_vol_point(NEW.mid, NEW.cabid, NEW.volid), aaa_vol_point(NEW.mid1, NEW.cabid1, NEW.volid1));
        END IF;
        -- Вставляем сварку с пометкой "удаленная"
        NEW.deleted = -9999;
        -- ЗАКОНЧИЛИ Вставляем сварку с пометкой "удаленная"
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN

        IF (NEW.the_geom IS NULL) THEN
        NEW.the_geom := MakeLine(aaa_vol_point(OLD.mid, OLD.cabid, OLD.volid), aaa_vol_point(OLD.mid1, OLD.cabid1, OLD.volid1));
        END IF;

        NEW.mid = OLD.mid;
        NEW.cabid = OLD.cabid;
        NEW.volid = OLD.volid;
        NEW.mid1 = OLD.mid1;
        NEW.cabid1 = OLD.cabid1;
        NEW.volid1 = OLD.volid1;
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NULL;

    ELSIF (TG_OP = 'INSERT') THEN
        -- Убираем пометку "удаленная" со свежевставленной сварки
        UPDATE v_muf_con SET deleted=0 WHERE uu_id=NEW.uu_id;
        -- ЗАКОНЧИЛИ Убираем пометку "удаленная" со свежевставленной сварки
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
        -- Чистим таблицу z_all2all, если сварка помечена как "удаленная"
        IF (NEW.deleted < 0) THEN
            DELETE FROM z_all2all WHERE p_table_uuid = OLD.uu_id;
        END IF;
        -- ЗАКОНЧИЛИ Чистим таблицу z_all2all, если сварка помечена как "удаленная"
        
        UPDATE z_all2all SET deleted=NEW.proj WHERE p_table_uuid=OLD.uu_id;
        
        -- Заполняем таблицу z_all2all
        IF (NEW.deleted >= 0 and OLD.deleted < 0 and NEW.volid > 0 and NEW.volid1 > 0) THEN
        SELECT * INTO STRICT mcv_row from v_mufcabvol mcv 
            WHERE mcv.mid = NEW.mid and mcv.cabid = NEW.cabid and mcv.volid = NEW.volid;
        SELECT * INTO STRICT mcv1_row from v_mufcabvol mcv 
            WHERE mcv.mid = NEW.mid1 and mcv.cabid = NEW.cabid1 and mcv.volid = NEW.volid1;
        INSERT INTO z_all2all(
            table1, table1_uuid, 
            table2, table2_uuid, 
            p_table, p_table_uuid)
        VALUES (
            'v_mufcabvol', mcv_row.uu_id, 
            'v_mufcabvol', mcv1_row.uu_id, 
            'v_vol2vol', NEW.uu_id),
            (
            'v_mufcabvol', mcv1_row.uu_id, 
            'v_mufcabvol', mcv_row.uu_id, 
            'v_vol2vol', NEW.uu_id);
        END IF;
        -- ЗАКОНЧИЛИ Заполняем таблицу z_all2all    

        -- Заполняем таблицу z_all2all для случая с разветвителем/cwdm
        IF (NEW.deleted >= 0 and OLD.deleted < 0 and NEW.volid = 0) THEN
                -- 1) Нужно сформировать в таблице z_all2all все связи между "кабелем" и волокнами,
                -- в качестве p_table_uuid лучше использовать uuid сварки с volid = 0
                -- но можно использовать и uuid "кабеля"
                -- 2) изменение параметров кабеля 
                --    а) имя - определяет CWDM или 10% 50%
                --    б) кол-во волокон определяет тип разветвителя 1:4 1:8..
                -- должно приводить к изменению типов связей в п.1
        -- 3) формирование сварки "кабель" -- волокно
        --
                -- пункты 1 и 2 лучше вынести в тригер с изменениями параметров кабеля
            INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
                SELECT 
                'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
                'v_mufcab' as table2, mc.uu_id as table2_uuid, 
                'v_vol2vol' as p_table, OLD.uu_id as p_table_uuid
                FROM v_mufcabvol mcv,  v_mufcab mc
                    WHERE mcv.mid = OLD.mid1 and mcv.cabid = OLD.cabid1 and mcv.volid = OLD.volid1
                        and mc.mid = OLD.mid and mc.cabid = OLD.cabid;
            INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
                SELECT 
                'v_mufcab' as table1, mc.uu_id as table1_uuid, 
                'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
                'v_vol2vol' as p_table, OLD.uu_id as p_table_uuid
                FROM v_mufcabvol mcv,  v_mufcab mc
                    WHERE mcv.mid = OLD.mid1 and mcv.cabid = OLD.cabid1 and mcv.volid = OLD.volid1
                        and mc.mid = OLD.mid and mc.cabid = OLD.cabid;
        END IF;
        IF (NEW.deleted >= 0 and OLD.deleted < 0 and NEW.volid1 = 0) THEN
            INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
                SELECT 
                'v_mufcabvol' as table1, mcv.uu_id as table1_uuid, 
                'v_mufcab' as table2, mc.uu_id as table2_uuid, 
                'v_vol2vol' as p_table, OLD.uu_id as p_table_uuid
                FROM v_mufcabvol mcv,  v_mufcab mc
                    WHERE mcv.mid = OLD.mid and mcv.cabid = OLD.cabid and mcv.volid = OLD.volid
                        and mc.mid = OLD.mid1 and mc.cabid = OLD.cabid1;
            INSERT INTO z_all2all(table1, table1_uuid, table2, table2_uuid, p_table, p_table_uuid)
                SELECT 
                'v_mufcab' as table1, mc.uu_id as table1_uuid, 
                'v_mufcabvol' as table2, mcv.uu_id as table2_uuid, 
                'v_vol2vol' as p_table, OLD.uu_id as p_table_uuid
                FROM v_mufcabvol mcv,  v_mufcab mc
                    WHERE mcv.mid = OLD.mid and mcv.cabid = OLD.cabid and mcv.volid = OLD.volid
                        and mc.mid = OLD.mid1 and mc.cabid = OLD.cabid1;
        END IF;
        -- ЗАКОНЧИЛИ Заполняем таблицу z_all2all для случая с разветвителем/cwdm

    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_con_update(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_con_update() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_con_update() FROM postgres;
GRANT ALL ON FUNCTION aaa_con_update() TO postgres;
GRANT ALL ON FUNCTION aaa_con_update() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_con_update() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

