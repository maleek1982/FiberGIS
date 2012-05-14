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
-- Name: aaa_st_name_propagation(integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_st_name_propagation(integer, integer, integer) RETURNS v_mufcabvol
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

    propagation_volokno integer;
    propagation_kabel integer;

    to_olt integer;
    to_onu integer;

    k integer;
    z integer;
    curent_mid integer; 
    curent_cabid integer;
    curent_volid integer;
    curent_vol_type_def integer;

    signal_los_db real;

    cab_con_row         v_cab_con%ROWTYPE;
    cabcol_row         w_cabcolor%ROWTYPE;
BEGIN
find_varka=0;
propagation_volokno = 0;
propagation_kabel = 0;

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
по переданным функции         mid cabid volid 
находим запись в таблице     v_mufcabvol
и заносим ее в             start_mufcabvol_row
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
    curent_vol_type_def = start_mufcabvol_row.vol_type_def;

-- закончили --
/*
а в start_mufcabvol_row - накапливаем параметры, шоб потом заапдейтить исследуемое волокно (mid cabid volid)
вводим параметр 
    cab_con_row v_cab_con%ROWTYPE - строка из таблици, в которой хранятся все куски кабелей между муфтами
первым шагом ищем кабель у которого начало или конец совпадают с тем, что нужно нам
*/

/*
    start_mufcabvol_row.vol_type := 5; -- код цвета волокна, треугольничка, 5-белый

    BEGIN
    SELECT * INTO STRICT cab_con_row from v_cab_con 
        where (v_cab_con.mid = start_mufcabvol_row.mid and v_cab_con.cabid = start_mufcabvol_row.cabid) or (v_cab_con.mid1 = start_mufcabvol_row.mid and v_cab_con.cabid1 = start_mufcabvol_row.cabid);
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
/*        BEGIN
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
*/


find_kabel=1;
--z=z+1; INSERT INTO log_tb VALUES (z, curent_mid, curent_cabid, curent_volid, 'find_kabel=' || find_kabel, 'приступаем к поиску', '1');



SELECT * INTO curent_muf_con_row from v_muf_con
    WHERE (v_muf_con.mid=curent_mid and v_muf_con.cabid=curent_cabid and v_muf_con.volid=curent_volid) and (v_muf_con.proj=0 or v_muf_con.proj=1);
    IF FOUND 
    THEN --нашли варку
        curent_mid = curent_muf_con_row.mid1;
        curent_cabid = curent_muf_con_row.cabid1;
        curent_volid = curent_muf_con_row.volid1;
        IF (curent_muf_con_row.volid1 > 0) 
            THEN 
                UPDATE v_mufcabvol SET vol_type_def = curent_vol_type_def 
                    WHERE v_mufcabvol.mid=curent_mid and v_mufcabvol.cabid=curent_cabid and v_mufcabvol.volid=curent_volid;
                find_varka = 1; 
            ELSE 
                propagation_kabel = 1; 
        END IF;
    ELSE
        SELECT * INTO curent_muf_con_row from v_muf_con 
        WHERE (v_muf_con.mid1=curent_mid and v_muf_con.cabid1=curent_cabid and v_muf_con.volid1=curent_volid) and (v_muf_con.proj=0 or v_muf_con.proj=1);
        IF FOUND 
        THEN --нашли варку
            curent_mid = curent_muf_con_row.mid;
            curent_cabid = curent_muf_con_row.cabid;
            curent_volid = curent_muf_con_row.volid;
        IF (curent_muf_con_row.volid > 0) 
            THEN 
                UPDATE v_mufcabvol SET vol_type_def = curent_vol_type_def 
                    WHERE v_mufcabvol.mid=curent_mid and v_mufcabvol.cabid=curent_cabid and v_mufcabvol.volid=curent_volid;
                find_varka = 1; 
            ELSE 
                propagation_kabel = 1; 
            END IF;
        END IF;
    END IF;

IF find_varka = 1 
    THEN
    SELECT * INTO curent_cab_con_row from v_cab_con 
        WHERE (v_cab_con.mid=curent_mid and v_cab_con.cabid=curent_cabid); 
        IF FOUND 
        THEN -- нашли кабель
            propagation_volokno = 1;
            curent_mid = curent_cab_con_row.mid1;
            curent_cabid = curent_cab_con_row.cabid1;
        ELSE
            SELECT * INTO curent_cab_con_row from v_cab_con 
            WHERE (v_cab_con.mid1=curent_mid and v_cab_con.cabid1=curent_cabid); 
            IF FOUND 
            THEN -- нашли кабель
                propagation_volokno = 1;
                curent_mid = curent_cab_con_row.mid;
                curent_cabid = curent_cab_con_row.cabid;
            END IF;
        END IF;
END IF;


IF (propagation_volokno = 1) THEN
    UPDATE v_mufcabvol SET vol_type_def = curent_vol_type_def WHERE v_mufcabvol.mid=curent_mid and v_mufcabvol.cabid=curent_cabid and v_mufcabvol.volid=curent_volid;
--    SELECT * INTO STRICT start_mufcabvol_row from v_mufcabvol WHERE v_mufcabvol.mid=curent_mid and v_mufcabvol.cabid=curent_cabid and v_mufcabvol.volid=curent_volid;
--    start_mufcabvol_row.name = 'propagation_volokno';
END IF;

IF (propagation_kabel = 1) THEN
--    start_mufcabvol_row.volid = curent_volid;
--    start_mufcabvol_row.cabid = curent_cabid;
--    start_mufcabvol_row.mid = curent_mid;
--    start_mufcabvol_row.name = 'propagation_kabel';
    UPDATE v_mufcabvol SET vol_type_def = curent_vol_type_def WHERE v_mufcabvol.mid=curent_mid and v_mufcabvol.cabid=curent_cabid and v_mufcabvol.the_geom_desc is NOT NULL;
--    NULL;
END IF;

--start_mufcabvol_row.the_geom_vol = NULL;
--start_mufcabvol_row.the_geom_desc = NULL;

RETURN start_mufcabvol_row;


END;
$_$;


--
-- Name: FUNCTION aaa_st_name_propagation(integer, integer, integer); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_st_name_propagation(integer, integer, integer) IS 'Распространение подписи по волокну на один шаг.';


--
-- Name: aaa_st_name_propagation(integer, integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_st_name_propagation(integer, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_st_name_propagation(integer, integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_st_name_propagation(integer, integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_st_name_propagation(integer, integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_st_name_propagation(integer, integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

