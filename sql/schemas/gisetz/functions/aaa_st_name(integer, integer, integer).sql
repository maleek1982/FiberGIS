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
-- Name: aaa_st_name(integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_st_name(integer, integer, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    mid alias for $1; 
    cabid alias for $2;
    volid alias for $3;

    b integer;
    c integer;
    l integer;

    aa_los_db real;
    st_to real;

    a_row  v_mufcabvol%ROWTYPE;
    a1_row v_mufcabvol%ROWTYPE;
    a2_row v_mufcabvol%ROWTYPE;
    aa_row v_mufcabvol%ROWTYPE;

    b_row  v_cab_con%ROWTYPE;
    bb_row v_cab_con%ROWTYPE;

    c_row  v_muf_con%ROWTYPE;

    mc_row v_mufcab%ROWTYPE;

    cabcol_row w_cabcolor%ROWTYPE;

--    mc_row v_mufcab%ROWTYPE;
--    m_row v_mufta%ROWTYPE;
BEGIN

--st_name := '';
--st_descr := '';
--st_location := '';

l = 0;
--a_row.mid:=mid;
--a_row.cabid:=cabid;
--a_row.volid:=volid;

/*
по переданным функции 
    mid cabid volid 
находим запись в таблице
    v_mufcabvol
и заносим ее в
    a_row и aa_row на всякий случай ( :-)
в результате имеем полную информацию о стартовой точке волокна
*/
    BEGIN
    SELECT * INTO STRICT a_row from v_mufcabvol
        where v_mufcabvol.mid=mid and v_mufcabvol.cabid=cabid and v_mufcabvol.volid=volid;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    aa_row := a_row;
    aa_row.st_length := 0;
-- закончили --

/*
АГА! a_row - это текущее значение ползанья по волокну,
а в aa_row - накапливаем параметры, шоб потом заапдейтить исследуемое волокно (mid cabid volid)

вводим параметр 
    bb_row v_cab_con%ROWTYPE - строка из таблици, в которой хранятся все куски кабелей между муфтами

первым шагом ищем кабель у которого начало или конец совпадают с тем, что нужно нам
*/

    aa_row.vol_type := 5; -- код цвета волокна, треугольничка, 5-белый
    
    BEGIN
    SELECT * INTO STRICT bb_row from v_cab_con 
        where (v_cab_con.mid = a_row.mid and v_cab_con.cabid = a_row.cabid) or (v_cab_con.mid1 = a_row.mid and v_cab_con.cabid1 = a_row.cabid);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN    
        /* 
        Если нужный кабель нашелся:
        заносим его парамерты в bb_row v_cab_con%ROWTYPE и 
        ищем какого цвета должно быть волокно, исходя из его номера и типа кабеля (таблица w_cabcolor)
        */
        BEGIN
        SELECT * INTO STRICT cabcol_row FROM w_cabcolor 
            WHERE w_cabcolor.typeid = bb_row.typeid and w_cabcolor.volid = a_row.volid;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                NULL;
                WHEN TOO_MANY_ROWS THEN
                NULL;
        END;
            IF FOUND THEN
                aa_row.vol_type := cabcol_row.vol_colid;
                --aa_row.st_descr := 'Color=' || cabcol_row.vol_colid;
            END IF;
    END IF;

    -- ну и цвет волокна, на русском, заганяем в st_descr
    BEGIN
    SELECT name_r INTO STRICT aa_row.st_descr FROM w_color 
        WHERE colid = aa_row.vol_type;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;

-- закончили --


 LOOP
/*
---Начало--- Для А найти В(два конца), по mid и cabid
Немножко повторяемся, по a_row - т.е. волкну в муфте, ищем кабель
    b_row v_cab_con%ROWTYPE

*/
    b=0;
    BEGIN
    SELECT * INTO STRICT b_row from v_cab_con 
        where (v_cab_con.mid=a_row.mid and v_cab_con.cabid=a_row.cabid) 
            or (v_cab_con.mid1 = a_row.mid and v_cab_con.cabid1 = a_row.cabid);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            /*
            -- не нашли продолжение кабеля, а вдруг это разветвитель?
            тогда должна существовать варка в муфте для mid=a_row.mid, cabid=a_row.cabid и volid=0
            */
                BEGIN
                SELECT * INTO STRICT c_row from v_muf_con 
                    where (v_muf_con.mid=a_row.mid and v_muf_con.cabid=a_row.cabid and v_muf_con.volid=0) 
                    or (v_muf_con.mid1=a_row.mid and v_muf_con.cabid1=a_row.cabid and v_muf_con.volid1=0);
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        /*
                        неа, не разветвитель
                        нужно вернуть имя
                        */
                        BEGIN
                        SELECT * INTO STRICT mc_row from v_mufcab
                            where v_mufcab.mid=a_row.mid and v_mufcab.cabid=a_row.cabid;
                            EXCEPTION
                                WHEN NO_DATA_FOUND THEN
                                NULL;
                                WHEN TOO_MANY_ROWS THEN
                                NULL;
                        END;
                        aa_row.st_length=ceil(1.09*aa_row.st_length);
                        st_to := 0;
                        IF (aa_row.st_length > 0) and (aa_row.ref_length > 0) THEN
                            st_to := ceil(aa_row.ref_length*100/aa_row.st_length);
                        END IF;
                        aa_row.st_name := st_to || ' ' || mc_row.descr || ' v#' || a_row.volid;
                        aa_row.vol_use := a_row.vol_use;
                        UPDATE v_mufcabvol SET vol_use=aa_row.vol_use, vol_type=aa_row.vol_type, st_name=aa_row.st_name, st_descr=aa_row.st_descr, st_length=aa_row.st_length
                            WHERE v_mufcabvol.mid=aa_row.mid and v_mufcabvol.cabid=aa_row.cabid and v_mufcabvol.volid=aa_row.volid;
                            RETURN aa_row.st_name;
                        -- RETURN aa_row.st_name;
                        WHEN TOO_MANY_ROWS THEN
                        NULL;
                END;
                IF FOUND THEN
                b=3; -- сплирер мля
                END IF;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;


    IF b=0 THEN
    BEGIN
    SELECT * INTO STRICT b_row from v_cab_con 
        where v_cab_con.mid=a_row.mid and v_cab_con.cabid=a_row.cabid;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
    -- нашелся для первого конца А1 будем искать для v_cab_con.cabid1
    b=1;
    aa_row.st_length := aa_row.st_length + length(b_row.the_geom)/100 + 7;
    END IF;
    END IF;

    IF b=0 THEN
    BEGIN
    SELECT * INTO STRICT b_row from v_cab_con 
        where v_cab_con.mid1 = a_row.mid and v_cab_con.cabid1 = a_row.cabid;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
    -- нашелся для второго конца А1 будем искать для v_cab_con.cabid
    b=2;
    aa_row.st_length := aa_row.st_length + length(b_row.the_geom)/100 + 7;
    END IF;
    END IF;

    IF b=3 THEN
    -- это разветвитель,
    IF c_row.volid=0  THEN b=1; END IF;
    IF c_row.volid1=0 THEN b=2; END IF;
    -- a_row.volid=0;
    -- нужно вернуть имя
    aa_row.st_name := 'GEPON_ ' || l;
    aa_row.vol_use := 99;
    UPDATE v_mufcabvol SET vol_use=aa_row.vol_use, vol_type=aa_row.vol_type, st_name=aa_row.st_name, st_descr=aa_row.st_descr, st_length=aa_row.st_length
        WHERE v_mufcabvol.mid=aa_row.mid and v_mufcabvol.cabid=aa_row.cabid and v_mufcabvol.volid=aa_row.volid;
    RETURN aa_row.st_name;
    END IF;


---Конец--- Для А найти В

---Начало--- Для В найти А1, по mid и cabid, +a.volid
-- Для b_row.mid, b_row.cabid и a_row.volid ищем волокно с обратной сторны кабеля, и записываем в a1_row
    BEGIN
    SELECT * INTO STRICT a1_row from v_mufcabvol
        where (b=2 and (v_mufcabvol.mid=b_row.mid and v_mufcabvol.cabid=b_row.cabid and v_mufcabvol.volid=a_row.volid))
            or
              (b=1 and (v_mufcabvol.mid=b_row.mid1 and v_mufcabvol.cabid=b_row.cabid1 and v_mufcabvol.volid=a_row.volid));
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            -- не нашли волокно на кабеле, возвращаем ошибку
----------------------------------------------------------            RETURN 'Ошибка:' || a_row.st_name;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
    END IF;
---Конец--- Для B найти A1

---Начало--- Для А1 найти C(два конца), по mid, cabid и volid
    c=0;
    BEGIN
    SELECT * INTO STRICT c_row from v_muf_con 
        where v_muf_con.mid=a1_row.mid and v_muf_con.cabid=a1_row.cabid and v_muf_con.volid=a1_row.volid;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
    -- нашелся для первого конца С будем искать A2 для v_muf_con.volid1
    c=1;
    END IF;


    IF c=0 THEN
    BEGIN
    SELECT * INTO STRICT c_row from v_muf_con 
        where v_muf_con.mid1=a1_row.mid and v_muf_con.cabid1=a1_row.cabid and v_muf_con.volid1=a1_row.volid;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
    -- нашелся для второго конца С будем искать A2 для v_muf_con.volid
    c=2;
    END IF;
    END IF;

    IF c=0 THEN
    -- !!!!!!! не нашли кросировку в муфте, нужно вернуть имя
    /*
    aa_row.st_name := l || ' ' || a1_row.st_name; -неподходит, 
    нужно вставить имя муфты в которой закончилось волокно
    */
    SELECT name INTO STRICT aa_row.st_name from v_mufta
        WHERE gid=a1_row.mid;
    aa_row.st_name := 'тк ' || aa_row.st_name;
    --aa_row.vol_use := a1_row.vol_use;
    aa_row.vol_use := -1;

    UPDATE v_mufcabvol SET vol_use=aa_row.vol_use, vol_type = aa_row.vol_type, st_name = aa_row.st_name, st_descr=aa_row.st_descr, st_length=ceil(aa_row.st_length)
        WHERE v_mufcabvol.mid=aa_row.mid and v_mufcabvol.cabid=aa_row.cabid and v_mufcabvol.volid=aa_row.volid;
    RETURN aa_row.st_name;
--    RETURN 'c=0';
    END IF;

--    RETURN c || 'C=' || c_row.name ;
---Конец--- Для A1 найти C

---Начало--- Для C найти А2, по mid и cabid, +volid
    BEGIN
    SELECT * INTO STRICT a2_row from v_mufcabvol 
        where (c=2 and (v_mufcabvol.mid=c_row.mid and v_mufcabvol.cabid=c_row.cabid and v_mufcabvol.volid=c_row.volid))
            or
              (c=1 and (v_mufcabvol.mid=c_row.mid1 and v_mufcabvol.cabid=c_row.cabid1 and v_mufcabvol.volid=c_row.volid1));
--        where v_mufcabvol.mid = c_row.mid and v_mufcabvol.cabid = c_row.cabid;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            -- это разветвитель!!! т.к. он идет на нулевое волокно в кабеле
            aa_row.st_name := 'ONU ' || l;
            aa_row.vol_use := 99;
            UPDATE v_mufcabvol SET vol_use=aa_row.vol_use, vol_type=aa_row.vol_type, st_name=aa_row.st_name, st_descr=aa_row.st_descr, st_length=aa_row.st_length
                WHERE v_mufcabvol.mid=aa_row.mid and v_mufcabvol.cabid=aa_row.cabid and v_mufcabvol.volid=aa_row.volid;
            RETURN aa_row.st_name;
            --NULL;
            WHEN TOO_MANY_ROWS THEN
            aa_row.st_name := 'Ошибка:' || a_row.st_name;
            RETURN aa_row.st_name;
            --NULL;
    END;
    IF FOUND THEN
    a_row = a2_row;
    END IF;
---Конец--- Для C найти A2
l = l + 1;
IF l>100 THEN
    aa_row.st_name := l || ' LOOP';
    RETURN aa_row.st_name;
END IF;
 END LOOP;

---------------------------------------------------------------RETURN 'test----';
 
END;
$_$;


--
-- Name: FUNCTION aaa_st_name(integer, integer, integer); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_st_name(integer, integer, integer) IS '
Ползаем по волокну.
';


--
-- Name: aaa_st_name(integer, integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_st_name(integer, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_st_name(integer, integer, integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_st_name(integer, integer, integer) TO postgres;
GRANT ALL ON FUNCTION aaa_st_name(integer, integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_st_name(integer, integer, integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

