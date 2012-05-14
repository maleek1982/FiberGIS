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

SET default_with_oids = true;

--
-- Name: v_muf_addcon; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_muf_addcon (
    conid integer NOT NULL,
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: v_muf_addcon_conid_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE v_muf_addcon_conid_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: v_muf_addcon_conid_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE v_muf_addcon_conid_seq OWNED BY v_muf_addcon.conid;


--
-- Name: conid; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE v_muf_addcon ALTER COLUMN conid SET DEFAULT nextval('v_muf_addcon_conid_seq'::regclass);


--
-- Name: v_muf_addcon_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_muf_addcon
    ADD CONSTRAINT v_muf_addcon_pkey PRIMARY KEY (conid);


--
-- Name: v_muf_addcon_after; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_muf_addcon_after
    AFTER INSERT OR DELETE OR UPDATE ON v_muf_addcon
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_con_add();


--
-- Name: v_muf_addcon_before; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_muf_addcon_before
    BEFORE INSERT OR DELETE OR UPDATE ON v_muf_addcon
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_con_add();


--
-- Name: v_muf_addcon; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE v_muf_addcon FROM PUBLIC;
REVOKE ALL ON TABLE v_muf_addcon FROM postgres;
GRANT ALL ON TABLE v_muf_addcon TO postgres;
GRANT SELECT,TRIGGER ON TABLE v_muf_addcon TO read_roles WITH GRANT OPTION;


--
-- Name: v_muf_addcon_conid_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE v_muf_addcon_conid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE v_muf_addcon_conid_seq FROM postgres;
GRANT ALL ON SEQUENCE v_muf_addcon_conid_seq TO postgres;
GRANT SELECT ON SEQUENCE v_muf_addcon_conid_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

