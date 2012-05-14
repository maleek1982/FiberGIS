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
-- Name: aaa_vol_fitting(integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_vol_fitting(fmid integer, fcabid integer, fvolid integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    fmid alias for $1; 
    fcabid alias for $2;
    fvolid alias for $3;
    fthe_geom geometry;
    f_mid integer; 
    f_cabid integer;
    f_volid integer;
    f_path text;
    full_name text;
    full_name2 text;
    f_ats text;
    f_odf text;
    f_volokno text;
    f_use integer;
    mcv_row v_mufcabvol%ROWTYPE;
    mc_row v_mufcab%ROWTYPE;
    m_row v_mufta%ROWTYPE;
BEGIN

    SELECT v_mufcabvol.* INTO mcv_row from v_mufcabvol 
        where v_mufcabvol.mid = fmid
        and v_mufcabvol.cabid = fcabid
        and v_mufcabvol.volid = fvolid;

    SELECT v_mufcab.* INTO mc_row from v_mufcab 
        where v_mufcab.mid = fmid
        and v_mufcab.cabid = fcabid;

    SELECT v_mufta.* INTO m_row from v_mufta 
        where v_mufta.gid = fmid;

--(1)------ gisetz.v_mcv_d1

    IF (mcv_row.volid > mc_row.vol_use) THEN
        DELETE FROM gisetz.v_mcv_d1 where mid = fmid and cabid = fcabid and volid = fvolid;
    ELSE 
        fthe_geom = ST_SetSRID(Translate(Scale(RotateZ(Translate(Scale(GeometryFromText(
            'POLYGON((-5 0.95,-2.05 0.95,-2.05 -0.95,-5 -0.95,-5 0.95))'), mc_row.flip, 1, 1), 0, fvolid*(-2), 0), mc_row.rot*(pi()/2)), 0.005,0.005,1.0),
            X(mc_row.the_geom), Y(mc_row.the_geom)), 900913);
        DELETE FROM gisetz.v_mcv_d1 where mid = fmid and cabid = fcabid and volid = fvolid;
        INSERT INTO gisetz.v_mcv_d1(mid, cabid, volid, use, angle, descr, the_geom) VALUES (fmid, fcabid, fvolid, mcv_row.vol_use, 0, '', fthe_geom);
    END IF;
-------- gisetz.v_mcv_d1

--(2)------ gisetz.v_mcv_d2

    fthe_geom = ST_SetSRID(Translate(Scale(RotateZ(Translate(Scale(GeometryFromText(
        'POLYGON((-10 1,-5 1,-5 -1,-10 -1,-10 1))'), mc_row.flip, 1, 1), 0, fvolid*(-2), 0), mc_row.rot*(pi()/2)), 0.005,0.005,1.0),
        X(mc_row.the_geom), Y(mc_row.the_geom)), 900913);
    
    DELETE FROM gisetz.v_mcv_d2 where mid = fmid and cabid = fcabid and volid = fvolid;
    
    --select SUBSTRING('10.121a sdd 020 90', '[^0-9]*([0-9]*)')::integer

--------------------------------------------------------------------------------------------------------

    WITH RECURSIVE t(u1, u2, k, path, path2, cycle) AS (
        VALUES (mcv_row.uu_id, mcv_row.uu_id, 0, '', cast(array[mcv_row.uu_id] as text), FALSE)
            UNION --ALL
        SELECT g.table2_uuid, t.u1, k+1, path||g.p_table, cast(cast(t.path2 as uuid[]) || g.table2_uuid as text), g.table2_uuid = any (cast(t.path2 as uuid[])) 
            FROM t t, gisetz.z_all2all g 
            WHERE g.table1_uuid = t.u1 and g.table2_uuid <> t.u2 and g.deleted >= 0 and (g.p_table like 'v_cab_con' or g.p_table like 'v_vol2vol') and not cycle and k < 500
    )
    SELECT 'm#'||g.mid||' c#'||g.cabid||' v#'||g.volid||' - '||g.st_name||' k='||t.k, g.mid, g.cabid, g.volid, t.path 
            INTO full_name, f_mid, f_cabid, f_volid, f_path
        FROM t, v_mufcabvol g 
        WHERE t.u1 = g.uu_id and ((t.path like 'v_cab_con%' and t.path like '%v_vol2vol') or t.path like '')
        ORDER BY t.k DESC LIMIT 1;

--------------------------------------------------------------------------------------------------------

    SELECT ats, odf INTO f_ats, f_odf FROM gisetz.mc_to_atsodf WHERE mid=f_mid and cabid=f_cabid;
    full_name = f_ats||' '||f_odf||' '||f_volid;

UPDATE gisetz.v_mcv_d1 d1
    SET descr=v_mufcabvol.descr FROM v_mufcabvol 
    WHERE    d1.mid = fmid
        and d1.cabid = fcabid
        and d1.volid = fvolid
        and v_mufcabvol.mid = f_mid
        and v_mufcabvol.cabid = f_cabid
        and v_mufcabvol.volid = f_volid;

    f_use = 0;
    
    SELECT ' '||orders_id, ' '||name||' ( '|| company ||E' )\n\n'||result||E'\n\n'||parameters, onoff INTO full_name, full_name2, f_use FROM journal_orders 
        WHERE (ats = f_ats) and (odf = f_odf) and (SUBSTRING('0'||volokno, '[^0-9]*([0-9]*)')::integer) = f_volid 
    ORDER BY orders_id DESC LIMIT 1;
    
    INSERT INTO gisetz.v_mcv_d2(mid, cabid, volid, use, angle, descr, the_geom, descr2) VALUES (fmid, fcabid, fvolid, f_use, 90*mc_row.rot, full_name, fthe_geom, full_name2);

-------- gisetz.v_mcv_d2

/*--(3)------ gisetz.v_mcv_d3

    fthe_geom = ST_SetSRID(Translate(Scale(RotateZ(Translate(Scale(GeometryFromText(
        'POLYGON((-15 1,-10 1,-10 -1,-15 -1,-15 1))'), mc_row.flip, 1, 1), 0, fvolid*(-2), 0), mc_row.rot*(pi()/2)), 0.005,0.005,1.0),
        X(mc_row.the_geom), Y(mc_row.the_geom)), 900913);
    
    DELETE FROM gisetz.v_mcv_d3 where mid = fmid and cabid = fcabid and volid = fvolid;

--------------------------------------------------------------------------------------------------------

    WITH RECURSIVE t(u1, u2, k, path, path2, cycle, c_lambda, c_type, p_tab) AS (
        VALUES (mcv_row.uu_id, mcv_row.uu_id, 0, '', cast(array[mcv_row.uu_id] as text), FALSE, 0, 0, ' ')
            UNION --ALL
        SELECT g.table2_uuid, t.u1, k+1, path||g.p_table, cast(cast(t.path2 as uuid[]) || g.table2_uuid as text), g.table2_uuid = any (cast(t.path2 as uuid[])),
                gisetz.lambda_int(t.c_lambda, g.lambda), --g.lambda, 
                    g.con_type, g.p_table
            FROM t t, gisetz.z_all2all g 
            WHERE g.table1_uuid = t.u1 and g.table2_uuid <> t.u2 
                and g.deleted >= 0 and not cycle and k < 99
                and (c_type <> g.con_type or p_tab <> g.p_table)
    )
--    SELECT 'dev='||port.dev_id||E'\nport='||port.port_id||E'\nname='||port."name"||E'\ndescr='||port.descr, t.path, 1
    SELECT 'dev='||port.dev_id||E'\nport='||port.port_id||E' name='||port."name"||E'\n\ndescr='||port.descr, t.path, t.c_lambda+1
            INTO full_name, f_path, f_use
        FROM t, all_port_geom port 
        WHERE t.u1 = port.uu_id and ((t.path like 'v_cab_con%' or t.path like 'all_dev_to_mufcab%') and t.path like '%all_con_port')
        ORDER BY t.k DESC LIMIT 1;

--------------------------------------------------------------------------------------------------------

    IF f_use > 1000 THEN f_use = 10; END IF;
    INSERT INTO gisetz.v_mcv_d3(mid, cabid, volid, use, angle, descr, the_geom) VALUES (fmid, fcabid, fvolid, coalesce(f_use, 0), 90*mc_row.rot, full_name, fthe_geom);

*/-------- gisetz.v_mcv_d3



RETURN astext(fthe_geom);
 
END;
$_$;


--
-- PostgreSQL database dump complete
--

