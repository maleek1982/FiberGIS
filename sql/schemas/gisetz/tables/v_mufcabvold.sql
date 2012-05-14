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
-- Name: v_mufcabvold; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_mufcabvold (
    mid integer NOT NULL,
    cabid integer NOT NULL,
    volid integer NOT NULL,
    name character varying(38),
    descr character varying(256),
    vol_use integer DEFAULT 0,
    vol_angle integer DEFAULT 0,
    st_name character varying(256),
    st_descr character varying(256),
    st_location character varying(256),
    st_length real,
    the_geom_desc public.geometry,
    CONSTRAINT enforce_dims_the_geom_desc CHECK ((public.ndims(the_geom_desc) = 2)),
    CONSTRAINT enforce_geotype_the_geom_desc CHECK (((public.geometrytype(the_geom_desc) = 'POLYGON'::text) OR (the_geom_desc IS NULL))),
    CONSTRAINT enforce_srid_the_geom_desc CHECK ((public.srid(the_geom_desc) = (-1)))
);


--
-- Name: vmufcabvold; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX vmufcabvold ON v_mufcabvold USING gist (the_geom_desc);


--
-- Name: v_mufcabvold; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE v_mufcabvold FROM PUBLIC;
REVOKE ALL ON TABLE v_mufcabvold FROM postgres;
GRANT ALL ON TABLE v_mufcabvold TO postgres;
GRANT SELECT,TRIGGER ON TABLE v_mufcabvold TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

