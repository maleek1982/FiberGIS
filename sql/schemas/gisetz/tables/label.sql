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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: label; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE label (
    id integer NOT NULL,
    label_type text DEFAULT 'dev'::text NOT NULL,
    label text,
    angle integer DEFAULT 0 NOT NULL,
    the_geom public.geometry,
    size integer DEFAULT 4 NOT NULL,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = (-1)))
);


--
-- Name: label_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: label_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE label_id_seq OWNED BY label.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE label ALTER COLUMN id SET DEFAULT nextval('label_id_seq'::regclass);


--
-- Name: label_pk; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY label
    ADD CONSTRAINT label_pk PRIMARY KEY (id);


--
-- Name: label; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE label FROM PUBLIC;
REVOKE ALL ON TABLE label FROM postgres;
GRANT ALL ON TABLE label TO postgres;
GRANT SELECT,REFERENCES,TRIGGER ON TABLE label TO read_roles WITH GRANT OPTION;


--
-- Name: label_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE label_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE label_id_seq FROM postgres;
GRANT ALL ON SEQUENCE label_id_seq TO postgres;
GRANT SELECT ON SEQUENCE label_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

