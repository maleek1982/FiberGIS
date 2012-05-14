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
-- Name: test_cab_con; Type: VIEW; Schema: gisetz; Owner: -
--

CREATE VIEW test_cab_con AS
    SELECT vcc.oid, vcc.mid, vcc.cabid, vcc.mid1, vcc.cabid1, vcc.name, vcc.typeid, public.makeline(public.translate(public.startpoint(vcc.the_geom), ((- public.x(vms.the_geom)) + public.x(vms.the_geom_new)), ((- public.y(vms.the_geom)) + public.y(vms.the_geom_new))), public.translate(public.endpoint(vcc.the_geom), ((- public.x(vme.the_geom)) + public.x(vme.the_geom_new)), ((- public.y(vme.the_geom)) + public.y(vme.the_geom_new)))) AS the_geom FROM v_cab_con vcc, v_mufta vms, v_mufta vme WHERE ((vcc.mid = vms.gid) AND (vcc.mid1 = vme.gid));


--
-- Name: test_cab_con; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE test_cab_con FROM PUBLIC;
REVOKE ALL ON TABLE test_cab_con FROM postgres;
GRANT ALL ON TABLE test_cab_con TO postgres;
GRANT SELECT,TRIGGER ON TABLE test_cab_con TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

