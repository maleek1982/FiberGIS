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
-- Name: dev_port_con; Type: TABLE; Schema: gisetz_repository; Owner: -; Tablespace: 
--

CREATE TABLE dev_port_con (
    id integer NOT NULL,
    dev_type_id integer DEFAULT 0 NOT NULL,
    dev_port_id integer DEFAULT 0 NOT NULL,
    dev_port_id1 integer DEFAULT 0 NOT NULL,
    lambda integer DEFAULT 0 NOT NULL,
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.st_ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: dev_port_con_id_seq; Type: SEQUENCE; Schema: gisetz_repository; Owner: -
--

CREATE SEQUENCE dev_port_con_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: dev_port_con_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz_repository; Owner: -
--

ALTER SEQUENCE dev_port_con_id_seq OWNED BY dev_port_con.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz_repository; Owner: -
--

ALTER TABLE dev_port_con ALTER COLUMN id SET DEFAULT nextval('dev_port_con_id_seq'::regclass);


--
-- Name: dev_port_con_pk; Type: CONSTRAINT; Schema: gisetz_repository; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dev_port_con
    ADD CONSTRAINT dev_port_con_pk PRIMARY KEY (id);


--
-- Name: dev_port_con; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON TABLE dev_port_con FROM PUBLIC;
REVOKE ALL ON TABLE dev_port_con FROM postgres;
GRANT ALL ON TABLE dev_port_con TO postgres;
GRANT SELECT,REFERENCES,TRIGGER ON TABLE dev_port_con TO read_roles WITH GRANT OPTION;


--
-- Name: dev_port_con_id_seq; Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON SEQUENCE dev_port_con_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE dev_port_con_id_seq FROM postgres;
GRANT ALL ON SEQUENCE dev_port_con_id_seq TO postgres;
GRANT SELECT ON SEQUENCE dev_port_con_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

