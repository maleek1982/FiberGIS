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
-- Name: mc_to_atsodf; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE mc_to_atsodf (
    mid integer DEFAULT 0 NOT NULL,
    cabid integer DEFAULT 0 NOT NULL,
    ats character varying(10),
    odf character varying(15),
    descr character varying(256)
);


--
-- PostgreSQL database dump complete
--

