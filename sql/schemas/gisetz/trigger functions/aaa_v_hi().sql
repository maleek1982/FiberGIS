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
-- Name: aaa_v_hi(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_v_hi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    i integer;
    mcv_row v_mufcabvol%ROWTYPE;
    super_path text;
    full_name text;
    f_path text;
    f_use integer;
    
BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT')THEN

        SELECT * INTO mcv_row from v_mufcabvol 
        where (v_mufcabvol.the_geom_desc IS NOT NULL) and (Distance(v_mufcabvol.the_geom_desc, NEW.the_geom)=0);

--------------------------------------------------------------------------------------------------------

    WITH RECURSIVE t(u1, u2, k, path, path2, path3, cycle, c_lambda, c_type, p_tab) AS (
        VALUES (mcv_row.uu_id, mcv_row.uu_id, 0, '', cast(array[mcv_row.uu_id] as text), cast(array[mcv_row.uu_id] as text), FALSE, 0, 0, ' ')
            UNION --ALL
        SELECT g.table2_uuid, t.u1, k+1, path||g.p_table, cast(cast(t.path2 as uuid[]) || g.table2_uuid as text), cast(cast(t.path3 as uuid[]) || g.p_table_uuid as text), g.table2_uuid = any (cast(t.path2 as uuid[])),
                g.lambda, g.con_type, g.p_table
            FROM t t, gisetz.z_all2all g 
            WHERE g.table1_uuid = t.u1 and g.table2_uuid <> t.u2 and g.deleted >= 0 and not cycle and k < 500
                and (c_type <> g.con_type or p_tab <> g.p_table)
    )
--    SELECT 'dev='||port.dev_id||E'\nport='||port.port_id||E'\nname='||port."name"||E'\ndescr='||port.descr, t.path, 1
    SELECT t.path, t.path3, 1
            INTO f_path, super_path, f_use
        FROM t
        WHERE t.path like 'v_cab_con%' or t.path like 'all_dev_to_mufcab%'
        ORDER BY t.k DESC LIMIT 1;

--------------------------------------------------------------------------------------------------------

    NEW.descr = super_path;
    DELETE FROM gisetz.v_highlight;
    INSERT INTO gisetz.v_highlight(the_geom) SELECT the_geom FROM public.v_muf_con WHERE uu_id = any (cast(super_path as uuid[]));
    INSERT INTO gisetz.v_highlight(the_geom) SELECT the_geom FROM public.v_cab_con WHERE uu_id = any (cast(super_path as uuid[]));
    INSERT INTO gisetz.v_highlight(the_geom) SELECT the_geom FROM public.all_con_port WHERE uu_id = any (cast(super_path as uuid[]));
    
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- PostgreSQL database dump complete
--

