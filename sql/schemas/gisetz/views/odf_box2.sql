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

--
-- Name: odf_box2; Type: VIEW; Schema: gisetz; Owner: -
--

CREATE VIEW odf_box2 AS
    SELECT vmc.mid, vmc.cabid, vm.m_type, vm.name, vm.descr, vmc.descr AS vmcdescr, vmc.vol_use, vmc.dreg, vmc.dinst FROM v_mufcab vmc, v_mufta vm WHERE (((((vmc.vol_use > 0) AND (vmc.mid = vm.gid)) AND ((vm.m_type = 4) OR (vm.m_type = 9))) AND (NOT (vmc.cabid IN (SELECT v_cab_con.cabid FROM v_cab_con WHERE ((v_cab_con.mid = vmc.mid) AND (v_cab_con.deleted >= 0)))))) AND (NOT (vmc.cabid IN (SELECT v_cab_con.cabid1 FROM v_cab_con WHERE ((v_cab_con.mid1 = vmc.mid) AND (v_cab_con.deleted >= 0)))))) ORDER BY vmc.mid;


--
-- Name: COLUMN odf_box2.mid; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN odf_box2.mid IS 'пара mid & cabid - однозначно указывает на данный, конкретный одф';


--
-- Name: COLUMN odf_box2.cabid; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN odf_box2.cabid IS 'пара mid & cabid - однозначно указывает на данный, конкретный одф';


--
-- Name: COLUMN odf_box2.m_type; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN odf_box2.m_type IS '9 - если очень важная точка, 4 - как правило клиент.';


--
-- Name: COLUMN odf_box2.name; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN odf_box2.name IS 'name from table v_mufta, имя места для сборища одф-ов, например: "Гор,103а"';


--
-- Name: COLUMN odf_box2.descr; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN odf_box2.descr IS 'descr from table ''v_mufta'' т.е. описывает место расположения одф-а, бокса. Например: "Ощадбанк (основная серверная)" или "Укртрансгаз" в основном используется если по данному адресу расположено несколько точек включения.';


--
-- Name: COLUMN odf_box2.vmcdescr; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN odf_box2.vmcdescr IS 'descr from table ''v_mufcab'' т.е. непосредственно название одф-а. Например: "A290 O#2" или "Жил.,73/79 O#5", !должно быть коротким!.';


--
-- Name: COLUMN odf_box2.vol_use; Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON COLUMN odf_box2.vol_use IS 'колличество волокон на одф-е боксе';


--
-- Name: odf_box2; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE odf_box2 FROM PUBLIC;
REVOKE ALL ON TABLE odf_box2 FROM postgres;
GRANT ALL ON TABLE odf_box2 TO postgres;
GRANT SELECT ON TABLE odf_box2 TO read_roles;


--
-- PostgreSQL database dump complete
--

