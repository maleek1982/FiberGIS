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
-- Name: v_mufcabvol_hist; Type: TABLE; Schema: gisetz; Owner: -; Tablespace: 
--

CREATE TABLE v_mufcabvol_hist (
    mid integer NOT NULL,
    cabid integer NOT NULL,
    volid integer NOT NULL,
    name character varying(38),
    descr character varying(256),
    vol_use integer,
    vol_type integer,
    vol_type_def integer,
    dreg timestamp with time zone,
    dinst timestamp with time zone,
    st_name character varying(256),
    st_descr character varying(256),
    st_location character varying(256),
    vol_angle integer,
    st_length real,
    ref_length real,
    st_to_ref real,
    uu_id uuid,
    ch_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    ch_by_ip character varying(256),
    ch_by_name character varying(256),
    ch_type character varying(256),
    ch_date timestamp with time zone,
    ch_text text,
    ch_text_dif text
);


--
-- Name: COLUMN v_mufcabvol_hist.mid; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.mid IS 'ID Муфты из таблицы v_mufta, к которой относится волокно';


--
-- Name: COLUMN v_mufcabvol_hist.cabid; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.cabid IS 'ID Кабеля из таблицы v_mufcab, к которому относится волокно';


--
-- Name: COLUMN v_mufcabvol_hist.volid; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.volid IS 'ID волокна';


--
-- Name: COLUMN v_mufcabvol_hist.name; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.name IS 'странно, но по состоянию на 04.04.2008 не используется, вписывается значение типа "vol_14"';


--
-- Name: COLUMN v_mufcabvol_hist.descr; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.descr IS 'описание волокна в кабеле, должно интенсивно использоваться для описания волокна на ODF';


--
-- Name: COLUMN v_mufcabvol_hist.vol_use; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.vol_use IS '[вычисляется, кроме случаев когда кабель не подключен] индикатор использования волокна: -1-не выходит на ODF, 0-свободно, 1-занято, 3-аренда, 10-CWDM, 99-xPON, и т.д.';


--
-- Name: COLUMN v_mufcabvol_hist.vol_type; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.vol_type IS '[вычисляется] определяет цвет волокна см. таблицу w_color';


--
-- Name: COLUMN v_mufcabvol_hist.vol_type_def; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.vol_type_def IS 'не используется, по задумке длжно определять цвет волокна см. таблицу w_color, если не подключен кабель';


--
-- Name: COLUMN v_mufcabvol_hist.dreg; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.dreg IS 'ставим NOW, когда идет INSERT строки в таблицу';


--
-- Name: COLUMN v_mufcabvol_hist.dinst; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.dinst IS 'ставим NOW, когда идет UPDATE строки в таблице';


--
-- Name: COLUMN v_mufcabvol_hist.st_name; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.st_name IS '[вычисляется] название волокна на другом конце...';


--
-- Name: COLUMN v_mufcabvol_hist.st_descr; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.st_descr IS '[вычисляется] текстовый вариант для vol_type';


--
-- Name: COLUMN v_mufcabvol_hist.st_location; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.st_location IS '[вычисляется] по задумке, это ближайший к другому концу волокна дом';


--
-- Name: COLUMN v_mufcabvol_hist.vol_angle; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.vol_angle IS '[вычисляется] наклон, в градусах, надписи вставляемой в the_geom_desc';


--
-- Name: COLUMN v_mufcabvol_hist.st_length; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.st_length IS '[вычисляется] вычисляемая длина волокна';


--
-- Name: COLUMN v_mufcabvol_hist.ref_length; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.ref_length IS 'длина волокна измеренная рефлектометром';


--
-- Name: COLUMN v_mufcabvol_hist.st_to_ref; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN v_mufcabvol_hist.st_to_ref IS '[вычисляется] отношение ref_length к st_length, в идеале jkugjkhg =1';


--
-- Name: v_mufcabvol_hist_pk; Type: CONSTRAINT; Schema: gisetz; Owner: -; Tablespace: 
--

ALTER TABLE ONLY v_mufcabvol_hist
    ADD CONSTRAINT v_mufcabvol_hist_pk PRIMARY KEY (ch_id);


--
-- PostgreSQL database dump complete
--

