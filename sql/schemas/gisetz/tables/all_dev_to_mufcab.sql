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
-- Name: all_dev_to_mufcab; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE all_dev_to_mufcab (
    id integer NOT NULL,
    all_dev_id integer NOT NULL,
    mid integer NOT NULL,
    cabid integer NOT NULL,
    name text,
    descr text,
    uu_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    deleted integer DEFAULT 0 NOT NULL
);


--
-- Name: TABLE all_dev_to_mufcab; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE all_dev_to_mufcab IS 'таблица привязок all_dev_geom к v_mufcab по id -> mid и cabid';


--
-- Name: all_dev_to_mufcab_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE all_dev_to_mufcab_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: all_dev_to_mufcab_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE all_dev_to_mufcab_id_seq OWNED BY all_dev_to_mufcab.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE all_dev_to_mufcab ALTER COLUMN id SET DEFAULT nextval('all_dev_to_mufcab_id_seq'::regclass);


--
-- Name: all_dev_to_mufcab_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY all_dev_to_mufcab
    ADD CONSTRAINT all_dev_to_mufcab_pkey PRIMARY KEY (id);


--
-- Name: all_dev_to_mufcab_after; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER all_dev_to_mufcab_after
    AFTER INSERT OR DELETE OR UPDATE ON all_dev_to_mufcab
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_all_dev_to_mufcab();


--
-- Name: all_dev_to_mufcab_before; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER all_dev_to_mufcab_before
    BEFORE INSERT OR DELETE OR UPDATE ON all_dev_to_mufcab
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_all_dev_to_mufcab();


--
-- Name: all_dev_to_mufcab; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE all_dev_to_mufcab FROM PUBLIC;
REVOKE ALL ON TABLE all_dev_to_mufcab FROM postgres;
GRANT ALL ON TABLE all_dev_to_mufcab TO postgres;
GRANT SELECT,TRIGGER ON TABLE all_dev_to_mufcab TO read_roles WITH GRANT OPTION;


--
-- Name: all_dev_to_mufcab_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE all_dev_to_mufcab_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE all_dev_to_mufcab_id_seq FROM postgres;
GRANT ALL ON SEQUENCE all_dev_to_mufcab_id_seq TO postgres;
GRANT SELECT ON SEQUENCE all_dev_to_mufcab_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

