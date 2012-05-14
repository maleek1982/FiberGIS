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
-- Name: toptrack; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE toptrack (
    "OBJECTID" integer NOT NULL,
    "SNSHAPE" integer DEFAULT 0 NOT NULL,
    "SNSYMB" smallint,
    "SYMBANG" double precision,
    "LAB" character varying(50),
    "KUZ" smallint,
    "TYPETOP" smallint,
    "IDBOOK" integer DEFAULT 0 NOT NULL,
    "PRSECRET" smallint,
    "CREG" integer DEFAULT 0 NOT NULL,
    "DREG" timestamp with time zone DEFAULT now(),
    "SNTXSYMB" smallint,
    "SHAPE" bytea,
    the_geom public.geometry,
    the_geom_900913 public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_dims_the_geom_900913 CHECK ((public.st_ndims(the_geom_900913) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_900913 CHECK (((public.geometrytype(the_geom_900913) = 'POINT'::text) OR (the_geom_900913 IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913)),
    CONSTRAINT enforce_srid_the_geom_900913 CHECK ((public.st_srid(the_geom_900913) = 900913))
);


--
-- Name: TABLE toptrack; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE toptrack IS 'Колодцы, приямки, вводы в здания и т.д.';


--
-- Name: toptrack_CREG_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "toptrack_CREG_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: toptrack_CREG_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "toptrack_CREG_seq" OWNED BY toptrack."CREG";


--
-- Name: toptrack_IDBOOK_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "toptrack_IDBOOK_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: toptrack_IDBOOK_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "toptrack_IDBOOK_seq" OWNED BY toptrack."IDBOOK";


--
-- Name: toptrack_OBJECTID_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "toptrack_OBJECTID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: toptrack_OBJECTID_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "toptrack_OBJECTID_seq" OWNED BY toptrack."OBJECTID";


--
-- Name: toptrack_SNSHAPE_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "toptrack_SNSHAPE_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: toptrack_SNSHAPE_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "toptrack_SNSHAPE_seq" OWNED BY toptrack."SNSHAPE";


--
-- Name: OBJECTID; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE toptrack ALTER COLUMN "OBJECTID" SET DEFAULT nextval('"toptrack_OBJECTID_seq"'::regclass);


--
-- Name: toptrack_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY toptrack
    ADD CONSTRAINT toptrack_pkey PRIMARY KEY ("OBJECTID");


--
-- Name: ind_toptrack_900913; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX ind_toptrack_900913 ON toptrack USING gist (the_geom_900913);


--
-- Name: feet_track; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER feet_track
    AFTER UPDATE ON toptrack
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_feet_toptrack();


--
-- Name: TRIGGER feet_track ON toptrack; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TRIGGER feet_track ON toptrack IS 'Перетаскивание колодца должно приводить к изменению геометрий кабельных каналов, привязанных к данному колодцу';


--
-- Name: toptrack; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE toptrack FROM PUBLIC;
REVOKE ALL ON TABLE toptrack FROM postgres;
GRANT ALL ON TABLE toptrack TO postgres;
GRANT SELECT,TRIGGER ON TABLE toptrack TO read_roles WITH GRANT OPTION;


--
-- Name: toptrack_CREG_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "toptrack_CREG_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "toptrack_CREG_seq" FROM postgres;
GRANT ALL ON SEQUENCE "toptrack_CREG_seq" TO postgres;
GRANT SELECT ON SEQUENCE "toptrack_CREG_seq" TO read_roles WITH GRANT OPTION;


--
-- Name: toptrack_IDBOOK_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "toptrack_IDBOOK_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "toptrack_IDBOOK_seq" FROM postgres;
GRANT ALL ON SEQUENCE "toptrack_IDBOOK_seq" TO postgres;
GRANT SELECT ON SEQUENCE "toptrack_IDBOOK_seq" TO read_roles WITH GRANT OPTION;


--
-- Name: toptrack_OBJECTID_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "toptrack_OBJECTID_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "toptrack_OBJECTID_seq" FROM postgres;
GRANT ALL ON SEQUENCE "toptrack_OBJECTID_seq" TO postgres;
GRANT SELECT ON SEQUENCE "toptrack_OBJECTID_seq" TO read_roles WITH GRANT OPTION;


--
-- Name: toptrack_SNSHAPE_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "toptrack_SNSHAPE_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "toptrack_SNSHAPE_seq" FROM postgres;
GRANT ALL ON SEQUENCE "toptrack_SNSHAPE_seq" TO postgres;
GRANT SELECT ON SEQUENCE "toptrack_SNSHAPE_seq" TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

