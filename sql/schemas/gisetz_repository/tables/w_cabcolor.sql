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
-- Name: w_cabcolor; Type: TABLE; Schema: gisetz_repository; Owner: -; Tablespace: 
--

CREATE TABLE w_cabcolor (
    typeid integer NOT NULL,
    volid integer NOT NULL,
    mod_colid integer NOT NULL,
    vol_colid integer NOT NULL
);


--
-- Name: w_cabcolor; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON TABLE w_cabcolor FROM PUBLIC;
REVOKE ALL ON TABLE w_cabcolor FROM postgres;
GRANT ALL ON TABLE w_cabcolor TO postgres;
GRANT SELECT ON TABLE w_cabcolor TO proj;
GRANT SELECT,TRIGGER ON TABLE w_cabcolor TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

