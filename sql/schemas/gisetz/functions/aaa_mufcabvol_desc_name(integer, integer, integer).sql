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
-- Name: aaa_mufcabvol_desc_name(integer, integer, integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_mufcabvol_desc_name(mid integer, cabid integer, volid integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
    mid alias for $1; 
    cabid alias for $2;
    volid alias for $3;
    f_mid integer; 
    f_cabid integer;
    f_volid integer;
    f_path text;
    mcv_row v_mufcabvol%ROWTYPE;
    full_name text;
BEGIN
    SELECT v_mufcabvol.* INTO mcv_row from v_mufcabvol 
        where v_mufcabvol.mid = mid and v_mufcabvol.cabid = cabid and v_mufcabvol.volid = volid;

    WITH RECURSIVE t(u1, u2, k, path) AS (
        VALUES (mcv_row.uu_id, mcv_row.uu_id, 0, '')
            UNION --ALL
        SELECT g.table2_uuid, t.u1, k+1, path||g.p_table 
            FROM t t, gisetz.z_all2all g 
            WHERE g.table1_uuid = t.u1 and g.table2_uuid <> t.u2 and k < 2000
    )
    SELECT 'm#'||g.mid||' c#'||g.cabid||' v#'||g.volid||' - '||g.st_name||' k='||t.k, g.mid, g.cabid, g.volid, t.path 
            INTO full_name, f_mid, f_cabid, f_volid, f_path
        FROM t, v_mufcabvol g 
        WHERE t.u1 = g.uu_id and (t.path like 'v_cab_con%' or t.path like '') and
            (NOT EXISTS(select * from gisetz.z_all2all gg where gg.table1_uuid = t.u1 and gg.table2_uuid <> t.u2) or t.k=0)
        ORDER BY t.k DESC;
    IF (f_path like '%v_cab_con') THEN
        full_name = 'm#'||f_mid;
    END IF;
RETURN full_name;
 
END;
$_$;


--
-- Name: aaa_mufcabvol_desc_name(integer, integer, integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_mufcabvol_desc_name(mid integer, cabid integer, volid integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_mufcabvol_desc_name(mid integer, cabid integer, volid integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_mufcabvol_desc_name(mid integer, cabid integer, volid integer) TO postgres;
GRANT ALL ON FUNCTION aaa_mufcabvol_desc_name(mid integer, cabid integer, volid integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_mufcabvol_desc_name(mid integer, cabid integer, volid integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

