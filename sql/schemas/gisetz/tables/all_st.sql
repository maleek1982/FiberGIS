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
-- Name: all_st; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE all_st (
    id integer NOT NULL,
    name text,
    descr text,
    podgon integer,
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: TABLE all_st; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE all_st IS 'таблица всех стоек';


--
-- Name: all_st_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE all_st_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: all_st_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE all_st_id_seq OWNED BY all_st.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE all_st ALTER COLUMN id SET DEFAULT nextval('all_st_id_seq'::regclass);


--
-- Name: all_st_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY all_st
    ADD CONSTRAINT all_st_pkey PRIMARY KEY (id);


--
-- Name: all_st_podgon; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER all_st_podgon
    BEFORE INSERT OR DELETE OR UPDATE ON all_st
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_st_podgon();


--
-- Name: all_st; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE all_st FROM PUBLIC;
REVOKE ALL ON TABLE all_st FROM postgres;
GRANT ALL ON TABLE all_st TO postgres;
GRANT SELECT,TRIGGER ON TABLE all_st TO read_roles WITH GRANT OPTION;


--
-- Name: all_st_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE all_st_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE all_st_id_seq FROM postgres;
GRANT ALL ON SEQUENCE all_st_id_seq TO postgres;
GRANT SELECT ON SEQUENCE all_st_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

