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
-- Name: all_port_geom_hist; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE all_port_geom_hist (
    p_id integer NOT NULL,
    dev_id integer NOT NULL,
    port_id integer NOT NULL,
    name text,
    descr text,
    status integer,
    uu_id uuid,
    dreg timestamp with time zone DEFAULT now(),
    ch_by_ip character varying(256),
    ch_type character varying(256),
    ch_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    ch_by_name character varying(256),
    ch_date timestamp with time zone,
    ch_text text,
    ch_text_dif text
);


--
-- Name: TABLE all_port_geom_hist; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON TABLE all_port_geom_hist IS 'история изменений в таблице all_port_geom, кажись заполняется приложением и не тригерами...';


--
-- Name: COLUMN all_port_geom_hist.status; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN all_port_geom_hist.status IS 'статус порта...';


--
-- Name: all_port_geom_hist_pk; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY all_port_geom_hist
    ADD CONSTRAINT all_port_geom_hist_pk PRIMARY KEY (ch_id);


--
-- PostgreSQL database dump complete
--

