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
-- Name: highlight; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE highlight (
    id integer NOT NULL,
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = (-1)))
);


--
-- Name: highlight_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE highlight_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: highlight_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE highlight_id_seq OWNED BY highlight.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE highlight ALTER COLUMN id SET DEFAULT nextval('highlight_id_seq'::regclass);


--
-- Name: highlight_pk; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY highlight
    ADD CONSTRAINT highlight_pk PRIMARY KEY (id);


--
-- Name: highlight_thegeom; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX highlight_thegeom ON highlight USING gist (the_geom);


--
-- Name: highlight; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE highlight FROM PUBLIC;
REVOKE ALL ON TABLE highlight FROM postgres;
GRANT ALL ON TABLE highlight TO postgres;
GRANT SELECT,REFERENCES,TRIGGER ON TABLE highlight TO read_roles WITH GRANT OPTION;


--
-- Name: highlight_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE highlight_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE highlight_id_seq FROM postgres;
GRANT ALL ON SEQUENCE highlight_id_seq TO postgres;
GRANT SELECT ON SEQUENCE highlight_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

