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
-- Name: all_mod_geom; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE all_mod_geom (
    id integer NOT NULL,
    dev_id integer NOT NULL,
    mod_id integer NOT NULL,
    name text,
    descr text,
    used_by integer DEFAULT 0 NOT NULL,
    the_point_geom public.geometry,
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_dims_the_point_geom CHECK ((public.ndims(the_point_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_geotype_the_point_geom CHECK (((public.geometrytype(the_point_geom) = 'POINT'::text) OR (the_point_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913)),
    CONSTRAINT enforce_srid_the_point_geom CHECK ((public.st_srid(the_point_geom) = 900913))
);


--
-- Name: TABLE all_mod_geom; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE all_mod_geom IS 'таблица всех дырок для молдулей на железе, dev_id-идентификатор железки, mod_id-идентификатор модуля(дырки), POINT-расположение, POLYGON-контур';


--
-- Name: all_mod_geom_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE all_mod_geom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: all_mod_geom_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE all_mod_geom_id_seq OWNED BY all_mod_geom.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE all_mod_geom ALTER COLUMN id SET DEFAULT nextval('all_mod_geom_id_seq'::regclass);


--
-- Name: all_mod_geom_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY all_mod_geom
    ADD CONSTRAINT all_mod_geom_pkey PRIMARY KEY (id);


--
-- Name: all_mod_geom; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE all_mod_geom FROM PUBLIC;
REVOKE ALL ON TABLE all_mod_geom FROM postgres;
GRANT ALL ON TABLE all_mod_geom TO postgres;
GRANT SELECT,TRIGGER ON TABLE all_mod_geom TO read_roles WITH GRANT OPTION;


--
-- Name: all_mod_geom_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE all_mod_geom_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE all_mod_geom_id_seq FROM postgres;
GRANT ALL ON SEQUENCE all_mod_geom_id_seq TO postgres;
GRANT SELECT ON SEQUENCE all_mod_geom_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

