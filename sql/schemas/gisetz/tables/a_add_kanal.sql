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
-- Name: a_add_kanal; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE a_add_kanal (
    id integer NOT NULL,
    kol_name character varying(64),
    length real NOT NULL,
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: TABLE a_add_kanal; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE a_add_kanal IS 'Используется исключительно для процедуры добавления нового колодца и каналов к нему, на определенном расстоянии и направлении, от уже существующего';


--
-- Name: a_add_kanal_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE a_add_kanal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: a_add_kanal_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE a_add_kanal_id_seq OWNED BY a_add_kanal.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE a_add_kanal ALTER COLUMN id SET DEFAULT nextval('a_add_kanal_id_seq'::regclass);


--
-- Name: a_add_kanal_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY a_add_kanal
    ADD CONSTRAINT a_add_kanal_pkey PRIMARY KEY (id);


--
-- Name: add_kanal_aft; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER add_kanal_aft
    AFTER INSERT ON a_add_kanal
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_add_kanal();


--
-- Name: add_kanal_bef; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER add_kanal_bef
    BEFORE INSERT ON a_add_kanal
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_add_kanal();


--
-- Name: a_add_kanal; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE a_add_kanal FROM PUBLIC;
REVOKE ALL ON TABLE a_add_kanal FROM postgres;
GRANT ALL ON TABLE a_add_kanal TO postgres;
GRANT SELECT,TRIGGER ON TABLE a_add_kanal TO read_roles WITH GRANT OPTION;


--
-- Name: a_add_kanal_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE a_add_kanal_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE a_add_kanal_id_seq FROM postgres;
GRANT ALL ON SEQUENCE a_add_kanal_id_seq TO postgres;
GRANT SELECT ON SEQUENCE a_add_kanal_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

