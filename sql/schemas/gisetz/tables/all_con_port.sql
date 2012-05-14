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
-- Name: all_con_port; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE all_con_port (
    id integer NOT NULL,
    name text,
    descr text,
    con_type integer,
    apg_id integer NOT NULL,
    apg_id1 integer NOT NULL,
    apg_dev_id integer NOT NULL,
    apg_port_id integer NOT NULL,
    apg_dev_id1 integer NOT NULL,
    apg_port_id1 integer NOT NULL,
    the_geom public.geometry,
    uu_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    proj integer DEFAULT 0 NOT NULL,
    lambda integer DEFAULT 0 NOT NULL,
    dreg timestamp with time zone DEFAULT now(),
    dinst timestamp with time zone DEFAULT now(),
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: TABLE all_con_port; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE all_con_port IS 'Патч между портами железок';


--
-- Name: all_con_port_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE all_con_port_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: all_con_port_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE all_con_port_id_seq OWNED BY all_con_port.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE all_con_port ALTER COLUMN id SET DEFAULT nextval('all_con_port_id_seq'::regclass);


--
-- Name: all_con_port_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY all_con_port
    ADD CONSTRAINT all_con_port_pkey PRIMARY KEY (id);


--
-- Name: all_con_port_uuid_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX all_con_port_uuid_ind ON all_con_port USING btree (uu_id);


--
-- Name: test_apg1_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX test_apg1_ind ON all_con_port USING btree (apg_id1);


--
-- Name: test_apg1_type_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX test_apg1_type_ind ON all_con_port USING btree (apg_id1, con_type);


--
-- Name: test_apg_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX test_apg_ind ON all_con_port USING btree (apg_id);


--
-- Name: test_apg_type_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX test_apg_type_ind ON all_con_port USING btree (apg_id, con_type);


--
-- Name: all_con_port_after; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER all_con_port_after
    AFTER INSERT OR DELETE OR UPDATE ON all_con_port
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_all_con_port();


--
-- Name: all_con_port_before; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER all_con_port_before
    BEFORE INSERT OR DELETE OR UPDATE ON all_con_port
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_all_con_port();


--
-- Name: all_con_port; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE all_con_port FROM PUBLIC;
REVOKE ALL ON TABLE all_con_port FROM postgres;
GRANT ALL ON TABLE all_con_port TO postgres;
GRANT SELECT,TRIGGER ON TABLE all_con_port TO read_roles WITH GRANT OPTION;


--
-- Name: all_con_port_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE all_con_port_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE all_con_port_id_seq FROM postgres;
GRANT ALL ON SEQUENCE all_con_port_id_seq TO postgres;
GRANT SELECT ON SEQUENCE all_con_port_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

