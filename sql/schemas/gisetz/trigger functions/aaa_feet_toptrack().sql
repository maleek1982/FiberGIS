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
-- Name: aaa_feet_toptrack(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_feet_toptrack() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    i integer;

BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'INSERT') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN

        UPDATE track
            SET the_geom=aaa_track_geom(track."OBJECTID"), "LAB" = ceil(track."DOCLEN"*10)/10 || '(' || ceil(length(aaa_track_geom(track."OBJECTID"))*0.637*10)/10 || ')'
            FROM toptrack
            WHERE (track."IDBEG" = toptrack."OBJECTID" or track."IDEND" = toptrack."OBJECTID") and toptrack."OBJECTID"=NEW."OBJECTID";

    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: FUNCTION aaa_feet_toptrack(); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_feet_toptrack() IS 'Перетаскивание колодца должно приводить к изменению геометрий кабельных каналов, привязанных к данному колодцу';


--
-- Name: aaa_feet_toptrack(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_feet_toptrack() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_feet_toptrack() FROM postgres;
GRANT ALL ON FUNCTION aaa_feet_toptrack() TO postgres;
GRANT ALL ON FUNCTION aaa_feet_toptrack() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_feet_toptrack() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

