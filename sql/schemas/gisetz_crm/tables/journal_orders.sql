--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = gisetz_crm, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: journal_orders; Type: TABLE; Schema: gisetz_crm; Owner: -; Tablespace: 
--

CREATE TABLE journal_orders (
    id integer NOT NULL,
    orders_id integer DEFAULT 0,
    name character varying(256),
    the_geom public.geometry,
    clientid integer,
    datein timestamp with time zone,
    company character varying(30),
    contract character varying(20),
    contractadd integer,
    who character varying(30),
    phone character varying(60),
    mail character varying(50),
    city character varying(15),
    address_pref character varying(10),
    chanaddr character varying(50),
    address_num character varying(10),
    address_pref_kv character varying(10),
    address_kv character varying(10),
    speed character varying(10),
    type character varying(10),
    integererface character varying(30),
    numlines character varying(10),
    mail1 character varying(30),
    mail2 character varying(30),
    mail3 character varying(30),
    hosting character varying(30),
    domen character varying(30),
    service character varying(100),
    other integer,
    statusin integer,
    whorec character varying(25),
    supervisor character varying(25),
    daterun timestamp with time zone,
    result text,
    ord_mail text,
    ord_host text,
    parameters text,
    ats character varying(10),
    ns character varying(15),
    pair character varying(10),
    ramka character varying(5),
    place character varying(200),
    module character varying(16),
    port character varying(16),
    concentrator character varying(16),
    onoff integer,
    account integer,
    dateacc timestamp with time zone,
    optica integer,
    odf character varying(15),
    volokno character varying(15),
    delegation integer,
    delegation_date timestamp with time zone,
    client_date timestamp with time zone,
    delegation_manager integer,
    priority character varying(50),
    no_possible integer,
    refuse integer,
    datestart timestamp with time zone,
    updatecol timestamp with time zone,
    updatewho character varying(25),
    planner integer,
    the_geom_900913 public.geometry,
    CONSTRAINT enforce_dims_the_geom CHECK ((public.ndims(the_geom) = 2)),
    CONSTRAINT enforce_dims_the_geom_900913 CHECK ((public.st_ndims(the_geom_900913) = 2)),
    CONSTRAINT enforce_geotype_the_geom CHECK (((public.geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_900913 CHECK (((public.geometrytype(the_geom_900913) = 'POINT'::text) OR (the_geom_900913 IS NULL))),
    CONSTRAINT enforce_srid_the_geom CHECK ((public.srid(the_geom) = (-1))),
    CONSTRAINT enforce_srid_the_geom_900913 CHECK ((public.st_srid(the_geom_900913) = 900913))
);


--
-- Name: journal_orders_id_seq; Type: SEQUENCE; Schema: gisetz_crm; Owner: -
--

CREATE SEQUENCE journal_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: journal_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz_crm; Owner: -
--

ALTER SEQUENCE journal_orders_id_seq OWNED BY journal_orders.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz_crm; Owner: -
--

ALTER TABLE journal_orders ALTER COLUMN id SET DEFAULT nextval('journal_orders_id_seq'::regclass);


--
-- Name: jornal_orders_pkey; Type: CONSTRAINT; Schema: gisetz_crm; Owner: -; Tablespace: 
--

ALTER TABLE ONLY journal_orders
    ADD CONSTRAINT jornal_orders_pkey PRIMARY KEY (id);


--
-- Name: ind_journal_orders_900913; Type: INDEX; Schema: gisetz_crm; Owner: -; Tablespace: 
--

CREATE INDEX ind_journal_orders_900913 ON journal_orders USING gist (the_geom_900913);


--
-- Name: jornal_orders_geo_ind; Type: INDEX; Schema: gisetz_crm; Owner: -; Tablespace: 
--

CREATE INDEX jornal_orders_geo_ind ON journal_orders USING gist (the_geom);


--
-- Name: journal_orders; Type: ACL; Schema: gisetz_crm; Owner: -
--

REVOKE ALL ON TABLE journal_orders FROM PUBLIC;
REVOKE ALL ON TABLE journal_orders FROM postgres;
GRANT ALL ON TABLE journal_orders TO postgres;
GRANT SELECT,TRIGGER ON TABLE journal_orders TO read_roles WITH GRANT OPTION;


--
-- Name: journal_orders_id_seq; Type: ACL; Schema: gisetz_crm; Owner: -
--

REVOKE ALL ON SEQUENCE journal_orders_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE journal_orders_id_seq FROM postgres;
GRANT ALL ON SEQUENCE journal_orders_id_seq TO postgres;
GRANT SELECT ON SEQUENCE journal_orders_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

