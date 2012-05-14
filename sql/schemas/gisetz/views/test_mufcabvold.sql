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
-- Name: test_mufcabvold; Type: VIEW; Schema: gisetz; Owner: -
--

CREATE VIEW test_mufcabvold AS
    SELECT vmcv.oid, vmcv.vol_use, vmcv.st_name, vmcv.st_length, vmcv.vol_angle, public.translate(vmcv.the_geom_desc, (public.x(vm.the_geom_new) - public.x(vm.the_geom)), (public.y(vm.the_geom_new) - public.y(vm.the_geom))) AS the_geom FROM v_mufcabvol vmcv, v_mufta vm WHERE ((vmcv.mid = vm.gid) AND (NOT (vmcv.the_geom_desc IS NULL)));


--
-- Name: test_mufcabvold; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE test_mufcabvold FROM PUBLIC;
REVOKE ALL ON TABLE test_mufcabvold FROM postgres;
GRANT ALL ON TABLE test_mufcabvold TO postgres;
GRANT SELECT,TRIGGER ON TABLE test_mufcabvold TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

