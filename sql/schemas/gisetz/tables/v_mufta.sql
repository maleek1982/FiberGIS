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
-- Name: v_mufta; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_mufta (
    gid integer NOT NULL,
    name character varying(38),
    descr character varying(256),
    m_type smallint,
    dreg timestamp with time zone,
    dinst timestamp with time zone,
    the_geom public.geometry,
    zoom real DEFAULT 1,
    lzoom real DEFAULT 1,
    podgon integer,
    the_geom_new public.geometry,
    the_geom_900913 public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_dims_the_geom_900913 CHECK ((public.st_ndims(the_geom_900913) = 2)),
    CONSTRAINT enforce_dims_the_geom_new CHECK ((public.ndims(the_geom_new) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_900913 CHECK (((public.geometrytype(the_geom_900913) = 'POINT'::text) OR (the_geom_900913 IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_new CHECK (((public.geometrytype(the_geom_new) = 'POINT'::text) OR (the_geom_new IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913)),
    CONSTRAINT enforce_srid_the_geom_900913 CHECK ((public.st_srid(the_geom_900913) = 900913)),
    CONSTRAINT enforce_srid_the_geom_new CHECK ((public.srid(the_geom_new) = (-1)))
);


--
-- Name: v_mufta_gid_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE v_mufta_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: v_mufta_gid_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE v_mufta_gid_seq OWNED BY v_mufta.gid;


--
-- Name: gid; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE v_mufta ALTER COLUMN gid SET DEFAULT nextval('v_mufta_gid_seq'::regclass);


--
-- Name: v_mufta_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_mufta
    ADD CONSTRAINT v_mufta_pkey PRIMARY KEY (gid);


--
-- Name: ind_v_mufta_900913; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX ind_v_mufta_900913 ON v_mufta USING gist (the_geom_900913);


--
-- Name: vmufta; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX vmufta ON v_mufta USING gist (the_geom);


--
-- Name: vmufta_new; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX vmufta_new ON v_mufta USING gist (the_geom_new);


--
-- Name: v_muf_after; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_muf_after
    AFTER INSERT OR UPDATE ON v_mufta
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_muf_update();


--
-- Name: v_muf_befor; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_muf_befor
    BEFORE INSERT OR DELETE OR UPDATE ON v_mufta
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_muf_update();


--
-- Name: v_mufta; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE v_mufta FROM PUBLIC;
REVOKE ALL ON TABLE v_mufta FROM postgres;
GRANT ALL ON TABLE v_mufta TO postgres;
GRANT SELECT ON TABLE v_mufta TO proj;
GRANT SELECT,TRIGGER ON TABLE v_mufta TO read_roles WITH GRANT OPTION;


--
-- Name: v_mufta_gid_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE v_mufta_gid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE v_mufta_gid_seq FROM postgres;
GRANT ALL ON SEQUENCE v_mufta_gid_seq TO postgres;
GRANT SELECT ON SEQUENCE v_mufta_gid_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

