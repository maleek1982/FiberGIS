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
-- Name: all_port_geom; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE all_port_geom (
    id integer NOT NULL,
    dev_id integer NOT NULL,
    port_id integer NOT NULL,
    name text,
    descr text,
    the_point_geom public.geometry,
    the_geom public.geometry,
    status integer DEFAULT 0,
    uu_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_dims_the_point_geom CHECK ((public.ndims(the_point_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_geotype_the_point_geom CHECK (((public.geometrytype(the_point_geom) = 'POINT'::text) OR (the_point_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913)),
    CONSTRAINT enforce_srid_the_point_geom CHECK ((public.st_srid(the_point_geom) = 900913))
);


--
-- Name: TABLE all_port_geom; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE all_port_geom IS 'таблица всех портов на железе, dev_id-идентификатор железки, port_id-идентификатор порта, POINT-расположение, POLYGON-контур';


--
-- Name: COLUMN all_port_geom.status; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN all_port_geom.status IS 'статус порта
0 - неизвестно
-1 - Down
 1 - Up';


--
-- Name: all_port_geom_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE all_port_geom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: all_port_geom_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE all_port_geom_id_seq OWNED BY all_port_geom.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE all_port_geom ALTER COLUMN id SET DEFAULT nextval('all_port_geom_id_seq'::regclass);


--
-- Name: all_port_geom_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY all_port_geom
    ADD CONSTRAINT all_port_geom_pkey PRIMARY KEY (id);


--
-- Name: all_port_uuid_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX all_port_uuid_ind ON all_port_geom USING btree (uu_id);


--
-- Name: port_geom_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX port_geom_ind ON all_port_geom USING gist (the_point_geom);


--
-- Name: port_geom_ind2; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX port_geom_ind2 ON all_port_geom USING gist (the_geom);


--
-- Name: all_port_geom_after; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER all_port_geom_after
    AFTER INSERT OR DELETE OR UPDATE ON all_port_geom
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_all_port_geom();


--
-- Name: all_port_geom_before; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER all_port_geom_before
    BEFORE INSERT OR DELETE OR UPDATE ON all_port_geom
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_all_port_geom();


--
-- Name: all_port_geom; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE all_port_geom FROM PUBLIC;
REVOKE ALL ON TABLE all_port_geom FROM postgres;
GRANT ALL ON TABLE all_port_geom TO postgres;
GRANT SELECT,TRIGGER ON TABLE all_port_geom TO read_roles WITH GRANT OPTION;


--
-- Name: all_port_geom_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE all_port_geom_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE all_port_geom_id_seq FROM postgres;
GRANT ALL ON SEQUENCE all_port_geom_id_seq TO postgres;
GRANT SELECT ON SEQUENCE all_port_geom_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

