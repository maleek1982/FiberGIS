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
-- Name: v_mufcabvol; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_mufcabvol (
    mid integer NOT NULL,
    cabid integer NOT NULL,
    volid integer NOT NULL,
    name character varying(38),
    descr character varying(256),
    vol_use integer DEFAULT 0,
    vol_type integer DEFAULT 1 NOT NULL,
    vol_type_def integer DEFAULT 1 NOT NULL,
    dreg timestamp with time zone DEFAULT now(),
    dinst timestamp with time zone DEFAULT now(),
    the_geom_vol public.geometry,
    the_geom_desc public.geometry,
    st_name character varying(256),
    st_descr character varying(256),
    st_location character varying(256),
    vol_angle integer DEFAULT 0,
    st_length real,
    ref_length real,
    st_to_ref real,
    uu_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    CONSTRAINT enforce_dims_the_geom_desc CHECK ((public.ndims(the_geom_desc) = 2)),
    CONSTRAINT enforce_dims_the_geom_vol CHECK ((public.ndims(the_geom_vol) = 2)),
    CONSTRAINT enforce_geotype_the_geom_desc CHECK (((public.geometrytype(the_geom_desc) = 'POLYGON'::text) OR (the_geom_desc IS NULL))),
    CONSTRAINT enforce_geotype_the_geom_vol CHECK (((public.geometrytype(the_geom_vol) = 'POLYGON'::text) OR (the_geom_vol IS NULL))),
    CONSTRAINT enforce_srid_the_geom_desc CHECK ((public.st_srid(the_geom_desc) = 900913)),
    CONSTRAINT enforce_srid_the_geom_vol CHECK ((public.st_srid(the_geom_vol) = 900913))
);


--
-- Name: COLUMN v_mufcabvol.mid; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.mid IS 'ID Муфты из таблицы v_mufta, к которой относится волокно';


--
-- Name: COLUMN v_mufcabvol.cabid; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.cabid IS 'ID Кабеля из таблицы v_mufcab, к которому относится волокно';


--
-- Name: COLUMN v_mufcabvol.volid; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.volid IS 'ID волокна';


--
-- Name: COLUMN v_mufcabvol.name; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.name IS 'странно, но по состоянию на 04.04.2008 не используется, вписывается значение типа "vol_14"';


--
-- Name: COLUMN v_mufcabvol.descr; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.descr IS 'описание волокна в кабеле, должно интенсивно использоваться для описания волокна на ODF';


--
-- Name: COLUMN v_mufcabvol.vol_use; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.vol_use IS '[вычисляется, кроме случаев когда кабель не подключен] индикатор использования волокна: -1-не выходит на ODF, 0-свободно, 1-занято, 3-аренда, 10-CWDM, 99-xPON, и т.д.';


--
-- Name: COLUMN v_mufcabvol.vol_type; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.vol_type IS '[вычисляется] определяет цвет волокна см. таблицу w_color';


--
-- Name: COLUMN v_mufcabvol.vol_type_def; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.vol_type_def IS 'не используется, по задумке длжно определять цвет волокна см. таблицу w_color, если не подключен кабель';


--
-- Name: COLUMN v_mufcabvol.dreg; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.dreg IS 'ставим NOW, когда идет INSERT строки в таблицу';


--
-- Name: COLUMN v_mufcabvol.dinst; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.dinst IS 'ставим NOW, когда идет UPDATE строки в таблице';


--
-- Name: COLUMN v_mufcabvol.the_geom_vol; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.the_geom_vol IS '[вычисляется] геометрия треугольника';


--
-- Name: COLUMN v_mufcabvol.the_geom_desc; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.the_geom_desc IS '[вычисляется] геометрия прямоугольника для надписи st_name, или st_descr, или т.д.';


--
-- Name: COLUMN v_mufcabvol.st_name; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.st_name IS '[вычисляется] название волокна на другом конце...';


--
-- Name: COLUMN v_mufcabvol.st_descr; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.st_descr IS '[вычисляется] текстовый вариант для vol_type';


--
-- Name: COLUMN v_mufcabvol.st_location; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.st_location IS '[вычисляется] по задумке, это ближайший к другому концу волокна дом';


--
-- Name: COLUMN v_mufcabvol.vol_angle; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.vol_angle IS '[вычисляется] наклон, в градусах, надписи вставляемой в the_geom_desc';


--
-- Name: COLUMN v_mufcabvol.st_length; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.st_length IS '[вычисляется] вычисляемая длина волокна';


--
-- Name: COLUMN v_mufcabvol.ref_length; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.ref_length IS 'длина волокна измеренная рефлектометром';


--
-- Name: COLUMN v_mufcabvol.st_to_ref; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol.st_to_ref IS '[вычисляется] отношение ref_length к st_length, в идеале jkugjkhg =1';


--
-- Name: v_mufcabvol_pkey; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_mufcabvol
    ADD CONSTRAINT v_mufcabvol_pkey PRIMARY KEY (mid, cabid, volid);


--
-- Name: v_mufcabvol__mcv; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_mufcabvol__mcv ON v_mufcabvol USING btree (mid, cabid, volid);


--
-- Name: v_mufcabvol__uuid; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX v_mufcabvol__uuid ON v_mufcabvol USING btree (uu_id);


--
-- Name: v_mufcabvol__vol_type_def; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_mufcabvol__vol_type_def ON v_mufcabvol USING btree (vol_type_def);


--
-- Name: v_mufcabvol_c; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_mufcabvol_c ON v_mufcabvol USING gist (the_geom_vol);


--
-- Name: v_mufcabvol_d; Type: INDEX; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE INDEX v_mufcabvol_d ON v_mufcabvol USING gist (the_geom_desc);


--
-- Name: v_mufcabvol__afupd; Type: TRIGGER; Schema: gisetz; Owner: -
--

CREATE TRIGGER v_mufcabvol__afupd
    AFTER UPDATE ON v_mufcabvol
    FOR EACH ROW
    EXECUTE PROCEDURE aaa_v_mufcabvol_restr_afupd();


--
-- Name: v_mufcabvol; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE v_mufcabvol FROM PUBLIC;
REVOKE ALL ON TABLE v_mufcabvol FROM postgres;
GRANT ALL ON TABLE v_mufcabvol TO postgres;
GRANT SELECT,UPDATE ON TABLE v_mufcabvol TO proj;
GRANT SELECT,TRIGGER ON TABLE v_mufcabvol TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

