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
-- Name: w_cabtype; Type: TABLE; Schema: gisetz_repository; Owner: -; Tablespace: 
--

CREATE TABLE w_cabtype (
    typeid integer NOT NULL,
    modnum integer NOT NULL,
    volnum integer NOT NULL
);


--
-- Name: w_cabtype; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON TABLE w_cabtype FROM PUBLIC;
REVOKE ALL ON TABLE w_cabtype FROM postgres;
GRANT ALL ON TABLE w_cabtype TO postgres;
GRANT SELECT,TRIGGER ON TABLE w_cabtype TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

