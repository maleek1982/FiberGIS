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
-- Name: aaa_st_name_new(integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_st_name_new(integer, integer, integer) RETURNS v_mufcabvol
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    mid alias for $1; 
    cabid alias for $2;
    volid alias for $3;

    start_mufcabvol_row     v_mufcabvol%ROWTYPE;
    curent_mufcabvol_row     v_mufcabvol%ROWTYPE;
    curent_mufcab_row     v_mufcab%ROWTYPE;
    curent_mufta_row     v_mufta%ROWTYPE;

    curent_cab_con_row     v_cab_con%ROWTYPE;
    curent_muf_con_row    v_muf_con%ROWTYPE;
    
    find_varka integer;
    find_kabel integer;

    to_olt integer;
    to_onu integer;

    k integer;
    z integer;
    curent_mid integer; 
    curent_cabid integer;
    curent_volid integer;

    signal_los_db real;

    cab_con_row         v_cab_con%ROWTYPE;
    cabcol_row         w_cabcolor%ROWTYPE;
BEGIN
k=1;
z=0;
to_olt=0;
to_onu=0;

signal_los_db=0;
curent_mid = mid;
curent_cabid = cabid;
curent_volid = volid;
--DELETE FROM log_tb;
/*
по переданным функции 
    mid cabid volid 
находим запись в таблице
    v_mufcabvol
и заносим ее в
    start_mufcabvol_row
в результате имеем полную информацию о стартовой точке волокна
*/
    BEGIN
    SELECT * INTO STRICT start_mufcabvol_row from v_mufcabvol
        where v_mufcabvol.mid=mid and v_mufcabvol.cabid=cabid and v_mufcabvol.volid=volid;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    start_mufcabvol_row.st_length := 0;
-- закончили --
/*
а в start_mufcabvol_row - накапливаем параметры, шоб потом заапдейтить исследуемое волокно (mid cabid volid)

вводим параметр 
    cab_con_row v_cab_con%ROWTYPE - строка из таблици, в которой хранятся все куски кабелей между муфтами

первым шагом ищем кабель у которого начало или конец совпадают с тем, что нужно нам
*/

    start_mufcabvol_row.vol_type := 5; -- код цвета волокна, треугольничка, 5-белый
    
    BEGIN
    SELECT * INTO STRICT cab_con_row from v_cab_con 
        where (v_cab_con.mid = start_mufcabvol_row.mid and v_cab_con.cabid = start_mufcabvol_row.cabid and v_cab_con.deleted > -9999) or (v_cab_con.mid1 = start_mufcabvol_row.mid and v_cab_con.cabid1 = start_mufcabvol_row.cabid and v_cab_con.deleted > -9999);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN    
        /* 
        Если нужный кабель нашелся:
        заносим его парамерты в cab_con_row v_cab_con%ROWTYPE и 
        ищем какого цвета должно быть волокно, исходя из его номера и типа кабеля (таблица w_cabcolor)
        */
        BEGIN
        SELECT * INTO STRICT cabcol_row FROM w_cabcolor 
            WHERE w_cabcolor.typeid = cab_con_row.typeid and w_cabcolor.volid = start_mufcabvol_row.volid;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                NULL;
                WHEN TOO_MANY_ROWS THEN
                NULL;
        END;
            IF FOUND THEN
            start_mufcabvol_row.vol_type = cabcol_row.vol_colid;
            END IF;
    END IF;

    -- ну и цвет волокна, на русском, заганяем в st_descr
    BEGIN
    SELECT name_r INTO STRICT start_mufcabvol_row.st_descr FROM w_color 
        WHERE colid = start_mufcabvol_row.vol_type;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
-- закончили --

find_kabel=1;
--z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'приступаем к поиску', '1');

LOOP
    k=k+1;
    EXIT WHEN k > 200;

IF find_kabel=1 THEN
------------------------------------------------------------------------------------------
    SELECT * INTO curent_cab_con_row from v_cab_con 
        where (v_cab_con.mid=curent_mid and v_cab_con.cabid=curent_cabid and v_cab_con.deleted > -9999); 
        IF FOUND THEN -- нашли кабель
            curent_mid=curent_cab_con_row.mid1;
            curent_cabid=curent_cab_con_row.cabid1;
            curent_volid=curent_volid;
            start_mufcabvol_row.st_length=start_mufcabvol_row.st_length + length(curent_cab_con_row.the_geom) + 7;
            signal_los_db=signal_los_db + (length(curent_cab_con_row.the_geom) + 7)/1000*(-0.45);
            find_kabel=0;
--        z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'нашли кабель НАЧАЛО', to_olt || to_onu);
        ELSE

        SELECT * INTO curent_cab_con_row from v_cab_con 
            where (v_cab_con.mid1=curent_mid and v_cab_con.cabid1=curent_cabid and v_cab_con.deleted > -9999); 
            IF FOUND THEN -- нашли кабель
                curent_mid=curent_cab_con_row.mid;
                curent_cabid=curent_cab_con_row.cabid;
                curent_volid=curent_volid;
                start_mufcabvol_row.st_length=start_mufcabvol_row.st_length + length(curent_cab_con_row.the_geom) + 7;
                signal_los_db=signal_los_db + (length(curent_cab_con_row.the_geom) + 7)/1000*(-0.45);
                find_kabel=0;
--        z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'нашли кабель КОНЕЦ', to_olt || to_onu);
            ELSE

            SELECT * INTO curent_muf_con_row from v_muf_con 
                where (v_muf_con.mid=curent_mid and v_muf_con.cabid=curent_cabid and v_muf_con.volid=0) and (v_muf_con.proj=0 or v_muf_con.proj=1);
                IF FOUND THEN -- нашли разветвитель
                    to_olt=1;
                    curent_mid=curent_mid;
                    curent_cabid=curent_muf_con_row.cabid1;
                    signal_los_db=signal_los_db - 0.1;
                    signal_los_db=signal_los_db + log(1.0/curent_mufcab_row.vol_use)*10;
                    SELECT * INTO curent_mufcab_row from v_mufcab where (v_mufcab.mid=curent_mid and v_mufcab.cabid=curent_muf_con_row.cabid);
                    IF (curent_volid=1) and (curent_mufcab_row.vol_use = 2) and NOT(SUBSTRING(curent_mufcab_row.descr, '[^0-9]*([0-9]*)%[^0-9]*') = '') THEN
                        signal_los_db=signal_los_db - log(1.0/curent_mufcab_row.vol_use)*10 + log((1.0-(SUBSTRING(curent_mufcab_row.descr, '[^0-9]*([0-9]*)%[^0-9]*')::real)/100))*10;
                    END IF;
                    IF (curent_volid=2) and (curent_mufcab_row.vol_use = 2) and NOT(SUBSTRING(curent_mufcab_row.descr, '[^0-9]*([0-9]*)%[^0-9]*') = '') THEN
                        signal_los_db=signal_los_db - log(1.0/curent_mufcab_row.vol_use)*10 + log((SUBSTRING(curent_mufcab_row.descr, '[^0-9]*([0-9]*)%[^0-9]*')::real)/100)*10;
                    END IF;
                    curent_volid=curent_muf_con_row.volid1;
                    find_kabel=1;
--        z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'нашли разветвитель НАЧАЛО', to_olt || to_onu);
                ELSE

                SELECT * INTO curent_muf_con_row from v_muf_con 
                    where (v_muf_con.mid1=curent_mid and v_muf_con.cabid1=curent_cabid and v_muf_con.volid1=0) and (v_muf_con.proj=0 or v_muf_con.proj=1);
                    IF FOUND THEN -- нашли разветвитель
                        to_olt=1;
                        curent_mid=curent_mid;
                        curent_cabid=curent_muf_con_row.cabid;
                        signal_los_db=signal_los_db - 0.1;
                        SELECT * INTO curent_mufcab_row from v_mufcab where (v_mufcab.mid=curent_mid and v_mufcab.cabid=curent_muf_con_row.cabid1);
                        IF (curent_volid=1) and (curent_mufcab_row.vol_use = 2) and NOT(SUBSTRING(curent_mufcab_row.descr, '[^0-9]*([0-9]*)%[^0-9]*') = '') THEN
                            signal_los_db=signal_los_db - log(1.0/curent_mufcab_row.vol_use)*10 + log((1.0-(SUBSTRING(curent_mufcab_row.descr, '[^0-9]*([0-9]*)%[^0-9]*')::real)/100))*10;
                        END IF;
                        IF (curent_volid=2) and (curent_mufcab_row.vol_use = 2) and NOT(SUBSTRING(curent_mufcab_row.descr, '[^0-9]*([0-9]*)%[^0-9]*') = '') THEN
                            signal_los_db=signal_los_db - log(1.0/curent_mufcab_row.vol_use)*10 + log((SUBSTRING(curent_mufcab_row.descr, '[^0-9]*([0-9]*)%[^0-9]*')::real)/100)*10;
                        END IF;
                        signal_los_db=signal_los_db + log(1.0/curent_mufcab_row.vol_use)*10;
                        curent_volid=curent_muf_con_row.volid;
                        find_kabel=1;
--        z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'нашли разветвитель КОНЕЦ', to_olt || to_onu);
                    ELSE -- не нашли кабель

                        ---------------------------
                        SELECT * INTO curent_mufcabvol_row from v_mufcabvol where (v_mufcabvol.mid=curent_mid and v_mufcabvol.cabid=curent_cabid and v_mufcabvol.volid=curent_volid);
                        SELECT * INTO curent_mufcab_row from v_mufcab where (v_mufcab.mid=curent_mid and v_mufcab.cabid=curent_cabid);
                        SELECT * INTO curent_mufta_row from v_mufta where v_mufta.gid=curent_mid;
                        start_mufcabvol_row.vol_use=curent_mufcabvol_row.vol_use;
                        --start_mufcabvol_row.st_location='волокно закончилось в муфте (возможно на ODF) ' || curent_mufta_row.name || '. Сигнал затух на ' || signal_los_db;
                        start_mufcabvol_row.st_location='Оконечен ' || curent_mufta_row.name || '. Сигнал затух на ' || ceil(signal_los_db*10)/10;
                        start_mufcabvol_row.st_name= -ceil(signal_los_db*10)/10 || ' ' || curent_mufcab_row.descr || ' v#' || curent_volid;
--        z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'не нашли кабель', to_olt || to_onu);
                        EXIT;
                        ---------------------------

                    END IF;
                END IF;
            END IF;
        END IF;

------------------------------------------------------------------------------------------    
--    EXIT;
ELSE
            SELECT * INTO curent_muf_con_row from v_muf_con 
                where (v_muf_con.mid=curent_mid and v_muf_con.cabid=curent_cabid and v_muf_con.volid=curent_volid) and (v_muf_con.proj=0 or v_muf_con.proj=1);
                IF FOUND THEN -- нашли варку
                    curent_mid=curent_mid;
                    curent_cabid=curent_muf_con_row.cabid1;
                    curent_volid=curent_muf_con_row.volid1;
                    find_kabel=1;
                    signal_los_db=signal_los_db - 0.1;
--    z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'нашли варку НАЧАЛО', to_olt || to_onu);
                    IF curent_volid = 0 THEN to_onu=1; EXIT; END IF; --уперлись в разветвитель
                ELSE
                SELECT * INTO curent_muf_con_row from v_muf_con 
                    where (v_muf_con.mid1=curent_mid and v_muf_con.cabid1=curent_cabid and v_muf_con.volid1=curent_volid) and (v_muf_con.proj=0 or v_muf_con.proj=1);
                    IF FOUND THEN -- нашли варку
                        curent_mid=curent_mid;
                        curent_cabid=curent_muf_con_row.cabid;
                        curent_volid=curent_muf_con_row.volid;
                        find_kabel=1;
                        signal_los_db=signal_los_db - 0.1;
--    z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'нашли варку КОНЕЦ', to_olt || to_onu);
                        IF curent_volid = 0 THEN to_onu=1; EXIT; END IF; --уперлись в разветвитель
                    ELSE -- ниче не нашли
                        ---------------------------
--    z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'не нашли варку', to_olt || to_onu);
                        SELECT * INTO curent_mufcabvol_row from v_mufcabvol where (v_mufcabvol.mid=curent_mid and v_mufcabvol.cabid=curent_cabid and v_mufcabvol.volid=curent_volid);
                        SELECT * INTO curent_mufcab_row from v_mufcab where (v_mufcab.mid=curent_mid and v_mufcab.cabid=curent_cabid);
                        SELECT * INTO curent_mufta_row from v_mufta where v_mufta.gid=curent_mid;
                        start_mufcabvol_row.vol_use=-1;
                        --start_mufcabvol_row.st_location='волокно закончилось в муфте обрыв ' || curent_mufta_row.name || '. Сигнал затух на ' || signal_los_db;
                        start_mufcabvol_row.st_location='Обрыв ' || curent_mufta_row.name || '. Сигнал затух на ' || ceil(signal_los_db*10)/10;
                        start_mufcabvol_row.st_name= -ceil(signal_los_db*10)/10 || ' тк' || curent_mufta_row.name;
                        EXIT;
                        ---------------------------
                    END IF;
                END IF;
END IF;

END LOOP;

IF to_olt=1 THEN start_mufcabvol_row.vol_use=99; END IF;
IF to_onu=1 THEN start_mufcabvol_row.vol_use=99; END IF;

UPDATE v_mufcabvol
   SET name=start_mufcabvol_row.name, descr=start_mufcabvol_row.descr, vol_use=start_mufcabvol_row.vol_use, vol_type=start_mufcabvol_row.vol_type, 
       vol_type_def=start_mufcabvol_row.vol_type_def, the_geom_vol=start_mufcabvol_row.the_geom_vol, the_geom_desc=start_mufcabvol_row.the_geom_desc, 
       st_name=start_mufcabvol_row.st_name, st_descr=start_mufcabvol_row.st_descr, st_location=start_mufcabvol_row.st_location, vol_angle=start_mufcabvol_row.vol_angle, st_length=start_mufcabvol_row.st_length, 
       ref_length=start_mufcabvol_row.ref_length, st_to_ref=start_mufcabvol_row.st_to_ref
 WHERE (v_mufcabvol.mid=start_mufcabvol_row.mid and v_mufcabvol.cabid=start_mufcabvol_row.cabid and v_mufcabvol.volid=start_mufcabvol_row.volid);

start_mufcabvol_row.the_geom_vol = NULL;
start_mufcabvol_row.the_geom_desc = NULL;
RETURN start_mufcabvol_row;


END;
$_$;


--
-- Name: FUNCTION aaa_st_name_new(integer, integer, integer); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_st_name_new(integer, integer, integer) IS '
Ползаем по волокну.
';


--
-- Name: aaa_st_name_new(integer, integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_st_name_new(integer, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_st_name_new(integer, integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_st_name_new(integer, integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_st_name_new(integer, integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_st_name_new(integer, integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

