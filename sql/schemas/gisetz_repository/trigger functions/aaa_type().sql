--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = gisetz_repository, pg_catalog;

--
-- Name: aaa_type(); Type: FUNCTION; Schema: gisetz_repository; Owner: -
--

CREATE FUNCTION aaa_type() RETURNS trigger
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
    /* Подгон геометрии */
    NEW.the_point_geom = SnapToGrid(NEW.the_point_geom, 1);
        IF NEW.the_geom IS NULL THEN
        NEW.the_geom = GeomFromText(AsText(BOX2D(expand(NEW.the_point_geom, 30))));
        END IF;
    /* Конец Подгон геометрии */
    IF (NEW.name = '') or (NEW.name IS NULL) THEN
    NEW.name = NEW.id;
    END IF;


    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    NEW.the_point_geom = SnapToGrid(NEW.the_point_geom, 1);
    NEW.the_geom = SnapToGrid(NEW.the_geom, 1);
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
-- Name: aaa_type(); Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON FUNCTION aaa_type() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_type() FROM postgres;
GRANT ALL ON FUNCTION aaa_type() TO postgres;
GRANT ALL ON FUNCTION aaa_type() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_type() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

