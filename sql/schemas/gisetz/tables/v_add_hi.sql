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
-- Name: v_add_hi; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_add_hi (
    id integer NOT NULL,
    label integer DEFAULT 0 NOT NULL,
    the_geom public.geometry,
    descr text DEFAULT ' '::text,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: v_add_hi_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE v_add_hi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: v_add_hi_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE v_add_hi_id_seq OWNED BY v_add_hi.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE v_add_hi ALTER COLUMN id SET DEFAULT nextval('v_add_hi_id_seq'::regclass);


--
-- Name: v_add_hi_pk; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_add_hi
    ADD CONSTRAINT v_add_hi_pk PRIMARY KEY (id);


--
-- Name: aaa_v_hi; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER aaa_v_hi
    BEFORE INSERT OR DELETE OR UPDATE ON v_add_hi
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_v_hi2();


--
-- PostgreSQL database dump complete
--

