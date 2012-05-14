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
-- Name: s_volnagr; Type: TABLE; Schema: gisetz_repository; Owner: -; Tablespace: 
--

CREATE TABLE s_volnagr (
    id integer NOT NULL,
    colid integer DEFAULT 0,
    shifr character(5) DEFAULT ' '::bpchar,
    name character(30) DEFAULT ' '::bpchar
);


--
-- Name: s_volnagr_id_seq; Type: SEQUENCE; Schema: gisetz_repository; Owner: -
--

CREATE SEQUENCE s_volnagr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: s_volnagr_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz_repository; Owner: -
--

ALTER SEQUENCE s_volnagr_id_seq OWNED BY s_volnagr.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz_repository; Owner: -
--

ALTER TABLE s_volnagr ALTER COLUMN id SET DEFAULT nextval('s_volnagr_id_seq'::regclass);


--
-- Name: s_volnagr_id; Type: CONSTRAINT; Schema: gisetz_repository; Owner: -; Tablespace: 
--

ALTER TABLE ONLY s_volnagr
    ADD CONSTRAINT s_volnagr_id PRIMARY KEY (id);


--
-- Name: s_volnagr; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON TABLE s_volnagr FROM PUBLIC;
REVOKE ALL ON TABLE s_volnagr FROM postgres;
GRANT ALL ON TABLE s_volnagr TO postgres;
GRANT SELECT ON TABLE s_volnagr TO proj;
GRANT SELECT,TRIGGER ON TABLE s_volnagr TO read_roles WITH GRANT OPTION;


--
-- Name: s_volnagr_id_seq; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON SEQUENCE s_volnagr_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE s_volnagr_id_seq FROM postgres;
GRANT ALL ON SEQUENCE s_volnagr_id_seq TO postgres;
GRANT SELECT ON SEQUENCE s_volnagr_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

