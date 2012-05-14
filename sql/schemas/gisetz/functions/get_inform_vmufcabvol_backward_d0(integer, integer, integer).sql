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
-- Name: get_inform_vmufcabvol_backward_d0(integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION get_inform_vmufcabvol_backward_d0(in_mid integer, in_cabid integer, in_volid integer, OUT near_end_vol_type integer, OUT far_end_uuid uuid, OUT far_end_name text, OUT far_end_descr text, OUT far_end_voluse integer, OUT length double precision, OUT attenuation double precision) RETURNS record
    LANGUAGE plpgsql STRICT
    AS $$
DECLARE
    
    in_uuid uuid;
    path_text text;

BEGIN

    SELECT uu_id INTO in_uuid from v_mufcabvol where mid = in_mid and cabid = in_cabid and volid = in_volid;
        
    BEGIN
    SELECT ccol.vol_colid INTO STRICT near_end_vol_type FROM v_cab_con vcc, w_cabcolor ccol
        WHERE ((vcc.mid = in_mid and vcc.cabid = in_cabid and vcc.deleted > -9999) or (vcc.mid1 = in_mid and vcc.cabid1 = in_cabid and vcc.deleted > -9999))
            and (ccol.typeid = vcc.typeid and ccol.volid = in_volid);
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            near_end_vol_type = 5;
            WHEN TOO_MANY_ROWS THEN
            near_end_vol_type = 5;
    END;
    
    WITH RECURSIVE t(u1, u2, k, path, path2, cycle, c_lambda, c_type, p_tab, sum_length, sum_att) AS (
        VALUES (in_uuid, in_uuid, 0, ''::text, cast(array[in_uuid] as text), FALSE, 999, 0, ' ', 0::double precision, 0::double precision)
            UNION
        SELECT g.table2_uuid, t.u1, k+1, path||g.p_table, cast(cast(t.path2 as uuid[]) || g.table2_uuid as text), g.table2_uuid = any (cast(t.path2 as uuid[])),
                gisetz.lambda_int(t.c_lambda, g.lambda),
                    g.con_type, g.p_table, t.sum_length + g.length * 1.09, t.sum_att + g.attenuation 
            FROM t t, gisetz.z_all2all g 
            WHERE g.table1_uuid = t.u1 and g.table2_uuid <> t.u2 
                and g.deleted >= 0 and (g.p_table like 'v_cab_con' or g.p_table like 'v_vol2vol' or g.p_table like 'v_mufcab') and not cycle and k < 500 and g.deleted <> -1
                and (c_type <> g.con_type or p_tab <> g.p_table)
                and gisetz.lambda_bool(t.c_lambda, g.lambda)
        )
        SELECT t.sum_length, t.sum_att, t.k, t.u1, t.path
            INTO length, attenuation, far_end_voluse, far_end_uuid, path_text
        FROM t 
        WHERE ((t.path like 'v_cab_con%') or (t.path like 'v_mufcab%') or (t.path like ''))
        ORDER BY t.k DESC LIMIT 1;
        
    attenuation = (ceil(attenuation*10))/10;
    length = ceil(length);
    
    IF ((path_text LIKE '%v_vol2vol') or (path_text LIKE '')) THEN
        SELECT mcv.vol_use, mcv.descr, attenuation || ' ' || coalesce(mc.descr, '') || ' v#' || mcv.volid INTO far_end_voluse, far_end_descr, far_end_name 
            FROM v_mufcabvol mcv, v_mufcab mc 
            WHERE mcv.uu_id = far_end_uuid and mc.cabid = mcv.cabid and mc.mid = mcv.mid;
    ELSE
        SELECT -1, '', attenuation || ' tk.' || coalesce(m.name, '') INTO far_end_voluse, far_end_descr, far_end_name 
            FROM v_mufcabvol mcv, v_mufta m 
            WHERE mcv.uu_id = far_end_uuid and m.gid = mcv.mid;
    END IF;

    -- some bug, bad work with CWDM filter in FOSC
    far_end_voluse = COALESCE(far_end_voluse, 99);
    far_end_descr = COALESCE(far_end_descr, ' ');
    far_end_name = COALESCE(far_end_name, ' ');
    --
    
    IF path_text LIKE '%v_mufcab%' THEN
        far_end_voluse = 99;
    END IF;
    
    RETURN;
    
END;
$$;


--
-- Name: get_inform_vmufcabvol_backward_d0(integer, integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION get_inform_vmufcabvol_backward_d0(in_mid integer, in_cabid integer, in_volid integer, OUT near_end_vol_type integer, OUT far_end_uuid uuid, OUT far_end_name text, OUT far_end_descr text, OUT far_end_voluse integer, OUT length double precision, OUT attenuation double precision) FROM PUBLIC;
REVOKE ALL ON FUNCTION get_inform_vmufcabvol_backward_d0(in_mid integer, in_cabid integer, in_volid integer, OUT near_end_vol_type integer, OUT far_end_uuid uuid, OUT far_end_name text, OUT far_end_descr text, OUT far_end_voluse integer, OUT length double precision, OUT attenuation double precision) FROM postgres;
GRANT ALL ON FUNCTION get_inform_vmufcabvol_backward_d0(in_mid integer, in_cabid integer, in_volid integer, OUT near_end_vol_type integer, OUT far_end_uuid uuid, OUT far_end_name text, OUT far_end_descr text, OUT far_end_voluse integer, OUT length double precision, OUT attenuation double precision) TO postgres;
GRANT ALL ON FUNCTION get_inform_vmufcabvol_backward_d0(in_mid integer, in_cabid integer, in_volid integer, OUT near_end_vol_type integer, OUT far_end_uuid uuid, OUT far_end_name text, OUT far_end_descr text, OUT far_end_voluse integer, OUT length double precision, OUT attenuation double precision) TO PUBLIC;
GRANT ALL ON FUNCTION get_inform_vmufcabvol_backward_d0(in_mid integer, in_cabid integer, in_volid integer, OUT near_end_vol_type integer, OUT far_end_uuid uuid, OUT far_end_name text, OUT far_end_descr text, OUT far_end_voluse integer, OUT length double precision, OUT attenuation double precision) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

