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
-- Name: notes; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    note_type integer DEFAULT 0 NOT NULL,
    note text,
    file text,
    dreg timestamp with time zone DEFAULT now(),
    dinst timestamp with time zone,
    the_geom public.geometry,
    test001 bytea,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.srid(the_geom) = (-1)))
);


--
-- Name: TABLE notes; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE notes IS 'заметки с файлами на карте';


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: notes; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE notes FROM PUBLIC;
REVOKE ALL ON TABLE notes FROM postgres;
GRANT ALL ON TABLE notes TO postgres;
GRANT SELECT,TRIGGER ON TABLE notes TO read_roles WITH GRANT OPTION;


--
-- Name: notes_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE notes_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE notes_id_seq FROM postgres;
GRANT ALL ON SEQUENCE notes_id_seq TO postgres;
GRANT SELECT ON SEQUENCE notes_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

