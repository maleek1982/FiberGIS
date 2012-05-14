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
-- Name: odf_vol; Type: VIEW; Schema: gisetz; Owner: -
--

CREATE VIEW odf_vol AS
    SELECT mcv1.st_name AS st_name_rem, mcv.mid, mcv.cabid, mcv.volid, mcv.name, mcv.descr, mcv.vol_use, mcv.vol_type, mcv.vol_type_def, mcv.dreg, mcv.dinst, mcv.the_geom_vol, mcv.the_geom_desc, mcv.st_name, mcv.st_descr, mcv.st_location, mcv.vol_angle, mcv.st_length, mcv.ref_length, mcv.st_to_ref FROM v_mufcabvol mcv, v_mufcabvol mcv1 WHERE ((((((mcv.mid = 62) AND (mcv.cabid = 1)) AND (mcv.mid = mcv1.mid)) AND (mcv.the_geom_desc IS NOT NULL)) AND (mcv1.the_geom_desc IS NOT NULL)) AND (EXISTS (SELECT mcon.mid, mcon.cabid, mcon.volid, mcon.mid1, mcon.cabid1, mcon.volid1, mcon.name, mcon.descr, mcon.dreg, mcon.dinst, mcon.the_geom, mcon.proj FROM v_muf_con mcon WHERE (((((((mcon.mid = mcv.mid) AND (mcon.mid1 = mcv.mid)) AND (mcon.cabid = mcv.cabid)) AND (mcon.volid = mcv.volid)) AND (mcon.cabid1 = mcv1.cabid)) AND (mcon.volid1 = mcv1.volid)) OR ((((((mcon.mid = mcv.mid) AND (mcon.mid1 = mcv.mid)) AND (mcon.cabid1 = mcv.cabid)) AND (mcon.volid1 = mcv.volid)) AND (mcon.cabid = mcv1.cabid)) AND (mcon.volid = mcv1.volid)))))) ORDER BY mcv.volid LIMIT 100;


--
-- Name: odf_vol; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE odf_vol FROM PUBLIC;
REVOKE ALL ON TABLE odf_vol FROM postgres;
GRANT ALL ON TABLE odf_vol TO postgres;
GRANT SELECT,TRIGGER ON TABLE odf_vol TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

