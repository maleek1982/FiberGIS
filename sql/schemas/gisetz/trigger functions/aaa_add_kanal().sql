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
-- Name: aaa_add_kanal(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_add_kanal() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    i integer;
    start_toptrack toptrack%ROWTYPE;
    end_toptrack toptrack%ROWTYPE;
    start_point geometry;
    end_point geometry;
    track_geom geometry;

BEGIN

---------------------------------------------------------------------------
    BEGIN
    SELECT tt.* INTO STRICT start_toptrack FROM toptrack tt
        WHERE tt.the_geom && Expand(StartPoint(NEW.the_geom),30)
        ORDER BY Distance(tt.the_geom,StartPoint(NEW.the_geom))
        LIMIT 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;
    start_point = start_toptrack.the_geom;
    end_point = ST_SetSRID(MakePoint(
        X(start_point) + (-X(start_point)+X(EndPoint(NEW.the_geom))) * (NEW.length/ST_Length3D_Spheroid(ST_Transform(NEW.the_geom, 4326), 'SPHEROID["WGS_1984", 6378137.0, 298.257223563]')),
        Y(start_point) + (-Y(start_point)+Y(EndPoint(NEW.the_geom))) * (NEW.length/ST_Length3D_Spheroid(ST_Transform(NEW.the_geom, 4326), 'SPHEROID["WGS_1984", 6378137.0, 298.257223563]'))
    ), 900913);
    track_geom = ST_SetSRID(MakeLine(start_point, end_point), 900913);

    NEW.the_geom = track_geom;
----------------------------------------------------------------------------



IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'INSERT') THEN
--    NEW.dreg=now();
---------------------------------------------------

    INSERT INTO toptrack(
--        "OBJECTID", "SNSHAPE", "SNSYMB", "SYMBANG", 
        "LAB",
--        "KUZ", "TYPETOP", "IDBOOK", "PRSECRET", "CREG", 
        "DREG",
--        "SNTXSYMB", "SHAPE", 
        the_geom)
    VALUES (
--        ?, ?, ?, ?, 
        NEW.kol_name,
--        ?, ?, ?, ?, ?, 
        now(),
--        ?, ?, 
        end_point);



---------------------------------------------------
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
--    NEW.dmod=now();
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'INSERT') THEN

    BEGIN
    SELECT tt.* INTO STRICT end_toptrack FROM toptrack tt
        WHERE tt.the_geom && Expand(EndPoint(NEW.the_geom),30)
        ORDER BY Distance(tt.the_geom,EndPoint(NEW.the_geom))
        LIMIT 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
            WHEN TOO_MANY_ROWS THEN
            NULL;
    END;


UPDATE toptrack
   SET the_geom=EndPoint(NEW.the_geom)
 WHERE "OBJECTID"=end_toptrack."OBJECTID";


    INSERT INTO track(
--"OBJECTID", "SNSHAPE", "SNSYMB", "SNTXSYMB", 
        "LAB",
--"TYPETRACK", 
        "IDBEG", "IDEND",
--"CREG", 
        "DREG",
--"KUZ", "PRSECRET", 
        "DOCLEN", 
--"QCAN", "COMTEXT", shape, "SHAPE_Length", 
        the_geom)
    VALUES (
        NEW.length,
        start_toptrack."OBJECTID", end_toptrack."OBJECTID",
        now(),
        NEW.length,
        Multi(NEW.the_geom));
    DELETE FROM a_add_kanal WHERE a_add_kanal.id=NEW.id;
    RETURN NULL;

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: FUNCTION aaa_add_kanal(); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_add_kanal() IS 'Используется исключительно для процедуры добавления нового колодца и каналов к нему, на определенном расстоянии и направлении, от уже существующего.';


--
-- Name: aaa_add_kanal(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_add_kanal() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_add_kanal() FROM postgres;
GRANT ALL ON FUNCTION aaa_add_kanal() TO postgres;
GRANT ALL ON FUNCTION aaa_add_kanal() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_add_kanal() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

