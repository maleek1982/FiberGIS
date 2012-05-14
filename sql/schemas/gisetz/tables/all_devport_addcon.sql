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
-- Name: all_devport_addcon; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE all_devport_addcon (
    conid integer NOT NULL,
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: TABLE all_devport_addcon; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE all_devport_addcon IS 'Добавляем патч между портами железок';


--
-- Name: all_devport_addcon_conid_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE all_devport_addcon_conid_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: all_devport_addcon_conid_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE all_devport_addcon_conid_seq OWNED BY all_devport_addcon.conid;


--
-- Name: conid; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE all_devport_addcon ALTER COLUMN conid SET DEFAULT nextval('all_devport_addcon_conid_seq'::regclass);


--
-- Name: all_devport_addcon_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY all_devport_addcon
    ADD CONSTRAINT all_devport_addcon_pkey PRIMARY KEY (conid);


--
-- Name: aaa_all_devport_addcon_; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER aaa_all_devport_addcon_
    AFTER INSERT OR DELETE OR UPDATE ON all_devport_addcon
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_all_devport_addcon();


--
-- Name: all_devport_addcon; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE all_devport_addcon FROM PUBLIC;
REVOKE ALL ON TABLE all_devport_addcon FROM postgres;
GRANT ALL ON TABLE all_devport_addcon TO postgres;
GRANT SELECT,TRIGGER ON TABLE all_devport_addcon TO read_roles WITH GRANT OPTION;


--
-- Name: all_devport_addcon_conid_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE all_devport_addcon_conid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE all_devport_addcon_conid_seq FROM postgres;
GRANT ALL ON SEQUENCE all_devport_addcon_conid_seq TO postgres;
GRANT SELECT ON SEQUENCE all_devport_addcon_conid_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

