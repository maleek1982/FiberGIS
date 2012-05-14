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

SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: gr; Type: TABLE; Schema: gisetz_repository; Owner: -; Tablespace: 
--

CREATE TABLE gr (
    line_type integer DEFAULT 0,
    name text,
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: TABLE gr; Type: COMMENT; Schema: gisetz_repository; Owner: -
--

COMMENT ON TABLE gr IS 'Сетка для рисования Железок';


--
-- Name: gr; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON TABLE gr FROM PUBLIC;
REVOKE ALL ON TABLE gr FROM postgres;
GRANT ALL ON TABLE gr TO postgres;
GRANT SELECT,TRIGGER ON TABLE gr TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

