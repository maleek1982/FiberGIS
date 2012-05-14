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
-- Name: aaa_con_add(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_con_add() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    i integer;
    k integer;
--    x1 real;
--    x2 real;
--    y1 real;
--    y2 real;

    mcv_row v_mufcabvol%ROWTYPE;
    mcv_row2 v_mufcabvol%ROWTYPE;
    mc_row v_mufcab%ROWTYPE;
    mc_row2 v_mufcab%ROWTYPE;
    m_row v_mufta%ROWTYPE;
    m_row2 v_mufta%ROWTYPE;
BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

-----BEFORE-----INSERT-UPDATE------------------------------------------------------------------
    ELSIF ((TG_OP = 'INSERT') OR (TG_OP = 'UPDATE'))THEN
    i := 0;
    k := 0;
-- Start Point
    BEGIN
    SELECT * INTO STRICT mcv_row from v_mufcabvol 
        where (v_mufcabvol.the_geom_vol IS NOT NULL) and (Distance(v_mufcabvol.the_geom_vol, StartPoint(NEW.the_geom))=0);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
        i:= i + 1;
        SELECT v_mufcab.* INTO mc_row from v_mufcab 
            where v_mufcab.mid = mcv_row.mid
            and v_mufcab.cabid = mcv_row.cabid;

        SELECT v_mufta.* INTO m_row from v_mufta 
            where v_mufta.gid = mcv_row.mid;

        NEW.the_geom := SetPoint(NEW.the_geom, 0, aaa_vol_point(mcv_row.mid, mcv_row.cabid, mcv_row.volid));

    END IF;
-- end of Start Point----------------------------------------------

-- End Point
    BEGIN
    SELECT * INTO STRICT mcv_row2 from v_mufcabvol
        where (v_mufcabvol.the_geom_vol IS NOT NULL) and Distance(v_mufcabvol.the_geom_vol, EndPoint(NEW.the_geom))=0;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
        i:= i + 2;
        SELECT v_mufcab.* INTO mc_row2 from v_mufcab 
            where v_mufcab.mid = mcv_row2.mid
            and v_mufcab.cabid = mcv_row2.cabid;

        SELECT v_mufta.* INTO m_row2 from v_mufta 
            where v_mufta.gid = mcv_row2.mid;

        NEW.the_geom := SetPoint(NEW.the_geom, (npoints(NEW.the_geom)-1), 
            aaa_vol_point(mcv_row2.mid, mcv_row2.cabid, mcv_row2.volid));

    END IF;

-- end of End Point----------------------------------------------


IF i<3 THEN
-- CABLE Start Point
    BEGIN
    SELECT * INTO STRICT mc_row from v_mufcab 
        where Distance(v_mufcab.the_geom_con, StartPoint(NEW.the_geom))=0;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
        k:= k + 1;
--        SELECT v_mufcab.* INTO mc_row from v_mufcab 
--            where v_mufcab.mid = mcv_row.mid
--            and v_mufcab.cabid = mcv_row.cabid;

        SELECT v_mufta.* INTO m_row from v_mufta 
            where v_mufta.gid = mc_row.mid;

        NEW.the_geom := SetPoint(NEW.the_geom, 0, aaa_cab_con_point(mc_row.mid, mc_row.cabid));

    END IF;
-- end of Start Point----------------------------------------------

-- End Point
    BEGIN
    SELECT * INTO STRICT mc_row2 from v_mufcab
        where Distance(v_mufcab.the_geom_con, EndPoint(NEW.the_geom))=0;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    IF FOUND THEN
        k:= k + 2;
--        SELECT v_mufcab.* INTO mc_row2 from v_mufcab 
--            where v_mufcab.mid = mcv_row2.mid
--            and v_mufcab.cabid = mcv_row2.cabid;

        SELECT v_mufta.* INTO m_row2 from v_mufta 
            where v_mufta.gid = mc_row2.mid;

        NEW.the_geom := SetPoint(NEW.the_geom, (npoints(NEW.the_geom)-1), 
            aaa_cab_con_point(mc_row2.mid, mc_row2.cabid));

    END IF;

-- CABLE end of End Point----------------------------------------------
END IF;

---------------------------------------------------------------------------------------------

NEW.the_geom := aaa_con_fit(NEW.the_geom);

--------------------------------------------------------------------------------------
-- Take con
    IF i = 3 THEN

    INSERT INTO v_muf_con(mid, cabid, volid, mid1, cabid1, volid1, name, descr, dreg, dinst, the_geom)
    VALUES (mcv_row.mid, mcv_row.cabid, mcv_row.volid, mcv_row2.mid, mcv_row2.cabid, mcv_row2.volid, NEW.conid,
    mcv_row.mid || '.' || mcv_row.cabid || '.' || mcv_row.volid || 
    '-' || mcv_row2.mid || '.' || mcv_row2.cabid || '.' || mcv_row2.volid
    , now(), now(), NEW.the_geom);

        IF (TG_OP = 'UPDATE') THEN
        DELETE FROM v_muf_addcon WHERE conid = NEW.conid;
        END IF;

    RETURN NULL;
    END IF;


    IF i = 1 and k = 2 THEN

    INSERT INTO v_muf_con(mid, cabid, volid, mid1, cabid1, volid1, name, descr, dreg, dinst, the_geom)
    VALUES (mcv_row.mid, mcv_row.cabid, mcv_row.volid, mc_row2.mid, mc_row2.cabid, 0, NEW.conid,
    mcv_row.mid || '.' || mcv_row.cabid || '.' || mcv_row.volid || 
    '-' || mc_row2.mid || '.' || mc_row2.cabid || '.0'
    , now(), now(), NEW.the_geom);

        IF (TG_OP = 'UPDATE') THEN
        DELETE FROM v_muf_addcon WHERE conid = NEW.conid;
        END IF;

    RETURN NULL;
    END IF;


    IF i = 2 and k = 1 THEN

    INSERT INTO v_muf_con(mid, cabid, volid, mid1, cabid1, volid1, name, descr, dreg, dinst, the_geom)
    VALUES (mc_row.mid, mc_row.cabid, 0, mcv_row2.mid, mcv_row2.cabid, mcv_row2.volid, NEW.conid,
    mc_row.mid || '.' || mc_row.cabid || '.0' || 
    '-' || mcv_row2.mid || '.' || mcv_row2.cabid || '.' || mcv_row2.volid
    , now(), now(), NEW.the_geom);

        IF (TG_OP = 'UPDATE') THEN
        DELETE FROM v_muf_addcon WHERE conid = NEW.conid;
        END IF;

    RETURN NULL;
    END IF;




    IF k = 3 THEN

    INSERT INTO v_cab_con(mid, cabid, mid1, cabid1, descr, name, dreg, dinst, the_geom)
    VALUES (mc_row.mid, mc_row.cabid, mc_row2.mid, mc_row2.cabid, NEW.conid, 
    NEW.conid,
--    mc_row.name || '.' || mc_row.cabid || '-' || mc_row2.name || '.' || mc_row2.cabid,
    now(), now(), NEW.the_geom);

        IF (TG_OP = 'UPDATE') THEN
        DELETE FROM v_muf_addcon WHERE conid = NEW.conid;
        END IF;

    RETURN NULL;
    END IF;


    RETURN NEW;

-----END-----BEFORE-----INSERT-UPDATE---------------------------------------------------------------------

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NULL;

    ELSIF (TG_OP = 'INSERT') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_con_add(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_con_add() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_con_add() FROM postgres;
GRANT ALL ON FUNCTION aaa_con_add() TO postgres;
GRANT ALL ON FUNCTION aaa_con_add() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_con_add() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

