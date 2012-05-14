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
-- Name: v_mcv_d3; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_mcv_d3 (
    mid integer NOT NULL,
    cabid integer NOT NULL,
    volid integer NOT NULL,
    use integer DEFAULT 0 NOT NULL,
    angle integer DEFAULT 0 NOT NULL,
    descr character varying(25600),
    the_geom public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POLYGON'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.st_srid(the_geom) = 900913))
);


--
-- Name: v_mcv_d3_klm; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_mcv_d3_klm ON v_mcv_d3 USING btree (mid, cabid, volid);


--
-- Name: v_mcv_d3_thegeom; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_mcv_d3_thegeom ON v_mcv_d3 USING gist (the_geom);


--
-- PostgreSQL database dump complete
--

