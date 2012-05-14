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
-- Name: w_color; Type: TABLE; Schema: gisetz_repository; Owner: -; Tablespace: 
--

CREATE TABLE w_color (
    colid integer NOT NULL,
    name_r character varying(256),
    name_u character varying(256),
    name_e character varying(256)
);


--
-- Name: w_color; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON TABLE w_color FROM PUBLIC;
REVOKE ALL ON TABLE w_color FROM postgres;
GRANT ALL ON TABLE w_color TO postgres;
GRANT SELECT ON TABLE w_color TO proj;
GRANT SELECT,TRIGGER ON TABLE w_color TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

