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
-- Name: v_mufcab; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_mufcab (
    mid integer NOT NULL,
    cabid integer NOT NULL,
    name character varying(38),
    descr character varying(256),
    cab_use integer DEFAULT 0,
    cab_type integer DEFAULT 1 NOT NULL,
    cab_type_def integer DEFAULT 1 NOT NULL,
    zoom real DEFAULT 1,
    rot integer DEFAULT 1,
    flip integer DEFAULT 1,
    dreg timestamp with time zone DEFAULT now(),
    dinst timestamp with time zone DEFAULT now(),
    the_geom public.geometry,
    vol_use integer DEFAULT 0,
    the_geom_con public.geometry,
    uu_id uuid DEFAULT public.uuid_generate_v4(),
    CONSTRAINT check_flip_v_mufcab CHECK (((flip = (-1)) OR (flip = 1))),
    CONSTRAINT check_rot_v_mufcab CHECK (((((rot = 0) OR (rot = 1)) OR (rot = 2)) OR (rot = 3))),
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_dims_the_geom_con CHECK ((public.ndims(the_geom_con) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_con CHECK (((public.geometrytype(the_geom_con) = 'POLYGON'::text) OR (the_geom_con IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913)),
    CONSTRAINT enforce_srid_the_geom_con CHECK ((public.st_srid(the_geom_con) = 900913))
);


--
-- Name: v_mufcab_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_mufcab
    ADD CONSTRAINT v_mufcab_pkey PRIMARY KEY (mid, cabid);


--
-- Name: v_mufcab__mc; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_mufcab__mc ON v_mufcab USING btree (mid, cabid);


--
-- Name: v_mufcab_con; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_mufcab_con ON v_mufcab USING gist (the_geom_con);


--
-- Name: vmufcab; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX vmufcab ON v_mufcab USING gist (the_geom);


--
-- Name: tmv_vmufcab_to_zall2all_dt; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER tmv_vmufcab_to_zall2all_dt
    AFTER DELETE ON v_mufcab
    FOR EACH ROW
    EXECUTE PROCEDURE tmv_vmufcab_to_zall2all_dt();


--
-- Name: tmv_vmufcab_to_zall2all_it; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER tmv_vmufcab_to_zall2all_it
    AFTER INSERT ON v_mufcab
    FOR EACH ROW
    EXECUTE PROCEDURE tmv_vmufcab_to_zall2all_it();


--
-- Name: tmv_vmufcab_to_zall2all_ut; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER tmv_vmufcab_to_zall2all_ut
    AFTER UPDATE ON v_mufcab
    FOR EACH ROW
    EXECUTE PROCEDURE tmv_vmufcab_to_zall2all_ut();


--
-- Name: v_mufcab_after; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_mufcab_after
    AFTER INSERT OR UPDATE ON v_mufcab
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_mufcab_update();


--
-- Name: v_mufcab_befor; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_mufcab_befor
    BEFORE INSERT OR DELETE OR UPDATE ON v_mufcab
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_mufcab_update();


--
-- Name: v_mufcab; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE v_mufcab FROM PUBLIC;
REVOKE ALL ON TABLE v_mufcab FROM postgres;
GRANT ALL ON TABLE v_mufcab TO postgres;
GRANT SELECT ON TABLE v_mufcab TO proj;
GRANT SELECT,TRIGGER ON TABLE v_mufcab TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

