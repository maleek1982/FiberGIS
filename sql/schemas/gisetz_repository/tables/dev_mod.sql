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

SET default_with_oids = false;

--
-- Name: dev_mod; Type: TABLE; Schema: gisetz_repository; Owner: -; Tablespace: 
--

CREATE TABLE dev_mod (
    id integer NOT NULL,
    dev_type_id integer DEFAULT 0 NOT NULL,
    dev_mod_id integer DEFAULT 0 NOT NULL,
    name text,
    compat integer DEFAULT 0 NOT NULL,
    ref_geom_mod integer DEFAULT 0,
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
-- Name: TABLE dev_mod; Type: COMMENT; Schema: gisetz_repository; Owner: -
--

COMMENT ON TABLE dev_mod IS 'таблица дырок под модули на железке, dev_mod_id-идентификатор дырки для модуля, dev_type_id-идентификатор железки, POINT-расположение, POLYGON-контур';


--
-- Name: dev_mod_id_seq; Type: SEQUENCE; Schema: gisetz_repository; Owner: -
--

CREATE SEQUENCE dev_mod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: dev_mod_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz_repository; Owner: -
--

ALTER SEQUENCE dev_mod_id_seq OWNED BY dev_mod.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz_repository; Owner: -
--

ALTER TABLE dev_mod ALTER COLUMN id SET DEFAULT nextval('dev_mod_id_seq'::regclass);


--
-- Name: dev_mod_pkey; Type: CONSTRAINT; Schema: gisetz_repository; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dev_mod
    ADD CONSTRAINT dev_mod_pkey PRIMARY KEY (id);


--
-- Name: aaa_mod; Type: TRIGGER; Schema: gisetz_repository; Owner: -
--

CREATE TRIGGER aaa_mod
    BEFORE INSERT OR DELETE OR UPDATE ON dev_mod
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_mod();


--
-- Name: dev_mod; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON TABLE dev_mod FROM PUBLIC;
REVOKE ALL ON TABLE dev_mod FROM postgres;
GRANT ALL ON TABLE dev_mod TO postgres;
GRANT SELECT,TRIGGER ON TABLE dev_mod TO read_roles WITH GRANT OPTION;


--
-- Name: dev_mod_id_seq; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON SEQUENCE dev_mod_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE dev_mod_id_seq FROM postgres;
GRANT ALL ON SEQUENCE dev_mod_id_seq TO postgres;
GRANT SELECT ON SEQUENCE dev_mod_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

