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
-- Name: test_muf_con; Type: VIEW; Schema: gisetz; Owner: -
--

CREATE VIEW test_muf_con AS
    SELECT vmc.oid, public.translate(vmc.the_geom, (public.x(vm.the_geom_new) - public.x(vm.the_geom)), (public.y(vm.the_geom_new) - public.y(vm.the_geom))) AS the_geom FROM v_muf_con vmc, v_mufta vm WHERE (vmc.mid = vm.gid);


--
-- Name: test_muf_con; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE test_muf_con FROM PUBLIC;
REVOKE ALL ON TABLE test_muf_con FROM postgres;
GRANT ALL ON TABLE test_muf_con TO postgres;
GRANT SELECT,TRIGGER ON TABLE test_muf_con TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

