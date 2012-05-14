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
-- Name: v_muf_con; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_muf_con (
    mid integer NOT NULL,
    cabid integer NOT NULL,
    volid integer NOT NULL,
    mid1 integer NOT NULL,
    cabid1 integer NOT NULL,
    volid1 integer NOT NULL,
    name character varying(38),
    descr character varying(256),
    dreg timestamp with time zone DEFAULT now(),
    dinst timestamp with time zone DEFAULT now(),
    the_geom public.geometry,
    proj integer DEFAULT 0,
    uu_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    deleted integer DEFAULT 0 NOT NULL,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'LINESTRING'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: v_muf_con_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_muf_con
    ADD CONSTRAINT v_muf_con_pkey PRIMARY KEY (mid, cabid, volid, mid1, cabid1, volid1);


--
-- Name: v_muf_con__c; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_muf_con__c ON v_muf_con USING btree (cabid);


--
-- Name: v_muf_con__c1; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_muf_con__c1 ON v_muf_con USING btree (cabid1);


--
-- Name: v_muf_con__m; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_muf_con__m ON v_muf_con USING btree (mid);


--
-- Name: v_muf_con__m1; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_muf_con__m1 ON v_muf_con USING btree (mid1);


--
-- Name: v_muf_con__v; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_muf_con__v ON v_muf_con USING btree (volid);


--
-- Name: v_muf_con__v1; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_muf_con__v1 ON v_muf_con USING btree (volid1);


--
-- Name: v_muf_con_uuid_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_muf_con_uuid_ind ON v_muf_con USING btree (uu_id);


--
-- Name: vmufcon; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX vmufcon ON v_muf_con USING gist (the_geom);


--
-- Name: v_muf_con_after; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_muf_con_after
    AFTER INSERT OR DELETE OR UPDATE ON v_muf_con
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_con_update();


--
-- Name: v_muf_con_before; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_muf_con_before
    BEFORE INSERT OR DELETE OR UPDATE ON v_muf_con
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_con_update();


--
-- Name: v_muf_con; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE v_muf_con FROM PUBLIC;
REVOKE ALL ON TABLE v_muf_con FROM postgres;
GRANT ALL ON TABLE v_muf_con TO postgres;
GRANT SELECT ON TABLE v_muf_con TO proj;
GRANT SELECT,TRIGGER ON TABLE v_muf_con TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

