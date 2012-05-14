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
-- Name: aaa_feet_kanal(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_feet_kanal() RETURNS trigger
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

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

---------------------------------------------------------------------------
    ELSIF (TG_OP = 'INSERT') THEN
        IF (NEW."IDBEG"=0 and NEW."IDEND"=0) THEN
            BEGIN
            SELECT tt.* INTO STRICT start_toptrack FROM toptrack tt
                WHERE tt.the_geom && Expand(StartPoint(NEW.the_geom),3000)
                ORDER BY Distance(tt.the_geom,StartPoint(NEW.the_geom))
                LIMIT 1;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        NULL;
                    WHEN TOO_MANY_ROWS THEN
                        NULL;
            END;
            start_point = start_toptrack.the_geom;
            BEGIN
            SELECT tt.* INTO STRICT end_toptrack FROM toptrack tt
                WHERE tt.the_geom && Expand(EndPoint(NEW.the_geom),3000)
                ORDER BY Distance(tt.the_geom,EndPoint(NEW.the_geom))
                LIMIT 1;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        NULL;
                    WHEN TOO_MANY_ROWS THEN
                        NULL;
            END;
            end_point = end_toptrack.the_geom;
            track_geom = Multi(MakeLine(start_point, end_point));
            NEW.the_geom = track_geom;
            NEW."IDBEG" = start_toptrack."OBJECTID";
            NEW."IDEND" = end_toptrack."OBJECTID";
        END IF;
    RETURN NEW;
----------------------------------------------------------------------------

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'INSERT') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_feet_kanal(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_feet_kanal() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_feet_kanal() FROM postgres;
GRANT ALL ON FUNCTION aaa_feet_kanal() TO postgres;
GRANT ALL ON FUNCTION aaa_feet_kanal() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_feet_kanal() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

