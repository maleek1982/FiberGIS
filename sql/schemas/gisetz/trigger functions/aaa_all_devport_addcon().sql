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
-- Name: aaa_all_devport_addcon(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_all_devport_addcon() RETURNS trigger
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
    PERFORM aaa_all_con_port_add(NEW.conid);
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    IF (NOT(NEW.the_geom = OLD.the_geom)) THEN PERFORM aaa_all_con_port_add(NEW.conid); END IF;
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_all_devport_addcon(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_all_devport_addcon() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_all_devport_addcon() FROM postgres;
GRANT ALL ON FUNCTION aaa_all_devport_addcon() TO postgres;
GRANT ALL ON FUNCTION aaa_all_devport_addcon() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_all_devport_addcon() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

