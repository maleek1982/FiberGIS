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
-- Name: z_all2all; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE z_all2all (
    id integer NOT NULL,
    uu_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    table1 character varying(24),
    table1_uuid uuid NOT NULL,
    table2 character varying(24),
    table2_uuid uuid NOT NULL,
    name character varying(24),
    descr character varying(255),
    con_type integer DEFAULT 1,
    d_install timestamp with time zone DEFAULT now(),
    d_change timestamp with time zone DEFAULT now(),
    p_table character varying(24),
    p_table_type integer DEFAULT 0,
    p_table_uuid uuid NOT NULL,
    deleted integer DEFAULT 0,
    lambda integer DEFAULT 0 NOT NULL,
    length double precision DEFAULT 0,
    attenuation double precision DEFAULT 0
);


--
-- Name: z_all2all_id_seq; Type: SEQUENCE; Schema: gisetz; Owner: -
--

CREATE SEQUENCE z_all2all_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: z_all2all_id_seq; Type: SEQUENCE OWNED BY; Schema: gisetz; Owner: -
--

ALTER SEQUENCE z_all2all_id_seq OWNED BY z_all2all.id;


--
-- Name: id; Type: DEFAULT; Schema: gisetz; Owner: -
--

ALTER TABLE z_all2all ALTER COLUMN id SET DEFAULT nextval('z_all2all_id_seq'::regclass);


--
-- Name: z_all2all_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY z_all2all
    ADD CONSTRAINT z_all2all_pkey PRIMARY KEY (id);


--
-- Name: z_all2all__p_table_uuid; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX z_all2all__p_table_uuid ON z_all2all USING btree (p_table_uuid);


--
-- Name: z_all2all_tab1_uuid_ind; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX z_all2all_tab1_uuid_ind ON z_all2all USING btree (table1_uuid);


--
-- Name: z_all2all; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE z_all2all FROM PUBLIC;
REVOKE ALL ON TABLE z_all2all FROM postgres;
GRANT ALL ON TABLE z_all2all TO postgres;
GRANT SELECT,REFERENCES,TRIGGER ON TABLE z_all2all TO read_roles WITH GRANT OPTION;


--
-- Name: z_all2all_id_seq; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON SEQUENCE z_all2all_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE z_all2all_id_seq FROM postgres;
GRANT ALL ON SEQUENCE z_all2all_id_seq TO postgres;
GRANT SELECT ON SEQUENCE z_all2all_id_seq TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

