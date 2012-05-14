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
-- Name: v_highlight; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_highlight (
    id integer NOT NULL,
    the_geom public.geometry,
    label integer DEFAULT 0 NOT NULL,
    added_by_ip text,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: v_highlight_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE v_highlight_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: v_highlight_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE v_highlight_id_seq OWNED BY v_highlight.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE v_highlight ALTER COLUMN id SET DEFAULT nextval('v_highlight_id_seq'::regclass);


--
-- Name: v_highlight_pk; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_highlight
    ADD CONSTRAINT v_highlight_pk PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

