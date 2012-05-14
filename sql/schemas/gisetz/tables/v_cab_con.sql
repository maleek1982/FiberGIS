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
-- Name: v_cab_con; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_cab_con (
    mid integer NOT NULL,
    cabid integer NOT NULL,
    mid1 integer NOT NULL,
    cabid1 integer NOT NULL,
    name character varying(38),
    descr character varying(256),
    dreg timestamp with time zone DEFAULT now(),
    dinst timestamp with time zone DEFAULT now(),
    the_geom public.geometry,
    typeid integer DEFAULT 1,
    the_geom_new public.geometry,
    uu_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    the_geom_900913 public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_dims_the_geom_900913 CHECK ((public.st_ndims(the_geom_900913) = 2)),
    CONSTRAINT enforce_dims_the_geom_new CHECK ((public.ndims(the_geom_new) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_900913 CHECK (((public.geometrytype(the_geom_900913) = 'LINESTRING'::text) OR (the_geom_900913 IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_new CHECK (((public.geometrytype(the_geom_new) = 'LINESTRING'::text) OR (the_geom_new IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913)),
    CONSTRAINT enforce_srid_the_geom_900913 CHECK ((public.st_srid(the_geom_900913) = 900913)),
    CONSTRAINT enforce_srid_the_geom_new CHECK ((public.srid(the_geom_new) = (-1)))
);


--
-- Name: v_cab_con_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_cab_con
    ADD CONSTRAINT v_cab_con_pkey PRIMARY KEY (mid, cabid, mid1, cabid1);


--
-- Name: ind_v_cab_con_900913; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX ind_v_cab_con_900913 ON v_cab_con USING gist (the_geom_900913);


--
-- Name: v_cab_con__mc; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_cab_con__mc ON v_cab_con USING btree (mid, cabid);


--
-- Name: v_cab_con__mc1; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_cab_con__mc1 ON v_cab_con USING btree (mid1, cabid1);


--
-- Name: v_cab_con_uuid_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_cab_con_uuid_ind ON v_cab_con USING btree (uu_id);


--
-- Name: vcabcon; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX vcabcon ON v_cab_con USING gist (the_geom);


--
-- Name: vcabcon_new; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX vcabcon_new ON v_cab_con USING gist (the_geom_new);


--
-- Name: tmv_vcabcon_to_zall2all_dt; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER tmv_vcabcon_to_zall2all_dt
    AFTER DELETE ON v_cab_con
    FOR EACH ROW
    EXECUTE PROCEDURE tmv_vcabcon_to_zall2all_dt();


--
-- Name: tmv_vcabcon_to_zall2all_it; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER tmv_vcabcon_to_zall2all_it
    AFTER INSERT ON v_cab_con
    FOR EACH ROW
    EXECUTE PROCEDURE tmv_vcabcon_to_zall2all_it();


--
-- Name: tmv_vcabcon_to_zall2all_ut; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER tmv_vcabcon_to_zall2all_ut
    AFTER UPDATE ON v_cab_con
    FOR EACH ROW
    EXECUTE PROCEDURE tmv_vcabcon_to_zall2all_ut();


--
-- Name: v_cab_con; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE v_cab_con FROM PUBLIC;
REVOKE ALL ON TABLE v_cab_con FROM postgres;
GRANT ALL ON TABLE v_cab_con TO postgres;
GRANT SELECT ON TABLE v_cab_con TO proj;
GRANT SELECT,TRIGGER ON TABLE v_cab_con TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

