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
-- Name: track; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE track (
    "OBJECTID" integer NOT NULL,
    "SNSHAPE" integer DEFAULT 0 NOT NULL,
    "SNSYMB" smallint,
    "SNTXSYMB" smallint,
    "LAB" character varying(100),
    "TYPETRACK" smallint,
    "IDBEG" integer DEFAULT 0 NOT NULL,
    "IDEND" integer DEFAULT 0 NOT NULL,
    "CREG" integer DEFAULT 0 NOT NULL,
    "DREG" timestamp with time zone DEFAULT now(),
    "KUZ" smallint,
    "PRSECRET" smallint,
    "DOCLEN" double precision,
    "QCAN" character varying(20),
    "COMTEXT" character varying(200),
    shape bytea,
    "SHAPE_Length" double precision,
    the_geom public.geometry,
    the_geom_900913 public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_dims_the_geom_900913 CHECK ((public.st_ndims(the_geom_900913) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'MULTILINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_900913 CHECK (((public.geometrytype(the_geom_900913) = 'MULTILINESTRING'::text) OR (the_geom_900913 IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913)),
    CONSTRAINT enforce_srid_the_geom_900913 CHECK ((public.st_srid(the_geom_900913) = 900913))
);


--
-- Name: TABLE track; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE track IS 'Кабельные каналы между колодцами, вводами в здания и т.д.';


--
-- Name: track_CREG_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "track_CREG_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: track_CREG_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "track_CREG_seq" OWNED BY track."CREG";


--
-- Name: track_IDBEG_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "track_IDBEG_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: track_IDBEG_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "track_IDBEG_seq" OWNED BY track."IDBEG";


--
-- Name: track_IDEND_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "track_IDEND_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: track_IDEND_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "track_IDEND_seq" OWNED BY track."IDEND";


--
-- Name: track_OBJECTID_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "track_OBJECTID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: track_OBJECTID_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "track_OBJECTID_seq" OWNED BY track."OBJECTID";


--
-- Name: track_SNSHAPE_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE "track_SNSHAPE_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: track_SNSHAPE_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE "track_SNSHAPE_seq" OWNED BY track."SNSHAPE";


--
-- Name: OBJECTID; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE track ALTER COLUMN "OBJECTID" SET DEFAULT nextval('"track_OBJECTID_seq"'::regclass);


--
-- Name: track_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY track
    ADD CONSTRAINT track_pkey PRIMARY KEY ("OBJECTID");


--
-- Name: ind_track_900913; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX ind_track_900913 ON track USING gist (the_geom_900913);


--
-- Name: aaa_track_bef; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER aaa_track_bef
    BEFORE INSERT OR DELETE OR UPDATE ON track
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_feet_kanal();


--
-- Name: track; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE track FROM PUBLIC;
REVOKE ALL ON TABLE track FROM postgres;
GRANT ALL ON TABLE track TO postgres;
GRANT SELECT,TRIGGER ON TABLE track TO read_roles WITH GRANT OPTION;


--
-- Name: track_CREG_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "track_CREG_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "track_CREG_seq" FROM postgres;
GRANT ALL ON SEQUENCE "track_CREG_seq" TO postgres;
GRANT SELECT ON SEQUENCE "track_CREG_seq" TO read_roles WITH GRANT OPTION;


--
-- Name: track_IDBEG_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "track_IDBEG_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "track_IDBEG_seq" FROM postgres;
GRANT ALL ON SEQUENCE "track_IDBEG_seq" TO postgres;
GRANT SELECT ON SEQUENCE "track_IDBEG_seq" TO read_roles WITH GRANT OPTION;


--
-- Name: track_IDEND_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "track_IDEND_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "track_IDEND_seq" FROM postgres;
GRANT ALL ON SEQUENCE "track_IDEND_seq" TO postgres;
GRANT SELECT ON SEQUENCE "track_IDEND_seq" TO read_roles WITH GRANT OPTION;


--
-- Name: track_OBJECTID_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "track_OBJECTID_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "track_OBJECTID_seq" FROM postgres;
GRANT ALL ON SEQUENCE "track_OBJECTID_seq" TO postgres;
GRANT SELECT ON SEQUENCE "track_OBJECTID_seq" TO read_roles WITH GRANT OPTION;


--
-- Name: track_SNSHAPE_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE "track_SNSHAPE_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "track_SNSHAPE_seq" FROM postgres;
GRANT ALL ON SEQUENCE "track_SNSHAPE_seq" TO postgres;
GRANT SELECT ON SEQUENCE "track_SNSHAPE_seq" TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

