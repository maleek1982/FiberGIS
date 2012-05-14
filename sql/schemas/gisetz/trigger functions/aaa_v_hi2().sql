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
-- Name: aaa_v_hi2(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_v_hi2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    i integer;
    mcv_row v_mufcabvol%ROWTYPE;
    super_path text;
    host_ip text;
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

        SELECT host(client_addr)::text INTO host_ip FROM pg_stat_get_activity(pg_backend_pid());

--------------------------------------------------------------------------------------------------------

    WITH RECURSIVE t(u1, u2, k, 
                path, 
                path2, 
--                path3, 
                p_table_uuid,
                cycle, 
                cycle_lambda, 
                cycle_type, 
                c_lambda, 
                c_type, 
                p_tab
            ) AS (
        VALUES (mcv_row.uu_id, mcv_row.uu_id, 0, 
                '', 
                cast(array[mcv_row.uu_id] as text), --path2
--                cast(array[mcv_row.uu_id] as text), 
                mcv_row.uu_id::uuid,
                FALSE, --cycle
                FALSE, --cycle_lambda
                FALSE, --cycle_type
                0, --c_lambda
                0, 
                ' '
            )
            UNION --ALL
        SELECT g.table2_uuid, t.u1, k+1, 
                path||g.p_table, 
                cast(cast(t.path2 as uuid[]) || g.table2_uuid as text), --path2
--                cast(cast(t.path3 as uuid[]) || g.p_table_uuid as text), 
                g.p_table_uuid,
                g.table2_uuid = any (cast(t.path2 as uuid[])), --cycle
                not lambda_bool(t.c_lambda, g.lambda), --cycle_lambda
                not (c_type <> g.con_type or p_tab <> g.p_table), --cycle_type
                lambda_int(t.c_lambda, g.lambda), --c_lambda
                g.con_type, 
                g.p_table
            FROM t t, z_all2all g 
            WHERE     g.table1_uuid = t.u1 and 
                g.deleted >= 0 
                and not cycle 
                and not cycle_lambda 
                and not cycle_type 
                and k < 500
    )
--    SELECT 'dev='||port.dev_id||E'\nport='||port.port_id||E'\nname='||port."name"||E'\ndescr='||port.descr, t.path, 1
--    SELECT t.path, t.path3, 1
--            INTO f_path, super_path, f_use
    SELECT cast(array_agg(t.p_table_uuid) as text)
            INTO super_path
        FROM t WHERE not cycle 
                and not cycle_lambda 
                and not cycle_type
        --WHERE t.path like 'v_cab_con%' or t.path like 'all_dev_to_mufcab%'
        --ORDER BY t.k DESC LIMIT 1
        ;

--------------------------------------------------------------------------------------------------------

    NEW.descr = super_path;
    DELETE FROM v_highlight WHERE added_by_ip=host_ip and label= NEW.label;
    INSERT INTO v_highlight(the_geom, added_by_ip, label) SELECT the_geom, host_ip, NEW.label FROM v_muf_con WHERE uu_id = any (cast(super_path as uuid[]));
    INSERT INTO v_highlight(the_geom, added_by_ip, label) SELECT the_geom, host_ip, NEW.label FROM v_cab_con WHERE uu_id = any (cast(super_path as uuid[]));
    INSERT INTO v_highlight(the_geom, added_by_ip, label) SELECT the_geom, host_ip, NEW.label FROM all_con_port WHERE uu_id = any (cast(super_path as uuid[]));
    
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

