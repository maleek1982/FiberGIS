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
-- Name: v_mufcabvolc; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_mufcabvolc (
    mid integer NOT NULL,
    cabid integer NOT NULL,
    volid integer NOT NULL,
    vol_type integer DEFAULT 1 NOT NULL,
    the_geom_vol public.geometry,
    CONSTRAINT enforce_dims_the_geom_vol CHECK ((public.ndims(the_geom_vol) = 2)),
    CONSTRAINT enforce_geotype_the_geom_vol CHECK (((public.geometrytype(the_geom_vol) = 'POLYGON'::text) OR (the_geom_vol IS NULL))),
    CONSTRAINT enforce_srid_the_geom_vol CHECK ((public.srid(the_geom_vol) = (-1)))
);


--
-- Name: vmufcabvolc; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX vmufcabvolc ON v_mufcabvolc USING gist (the_geom_vol);


--
-- Name: v_mufcabvolc; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE v_mufcabvolc FROM PUBLIC;
REVOKE ALL ON TABLE v_mufcabvolc FROM postgres;
GRANT ALL ON TABLE v_mufcabvolc TO postgres;
GRANT SELECT,TRIGGER ON TABLE v_mufcabvolc TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

