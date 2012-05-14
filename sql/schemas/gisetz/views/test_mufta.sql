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
-- Name: test_mufta; Type: VIEW; Schema: gisetz; Owner: -
--

CREATE VIEW test_mufta AS
    SELECT v_mufta.gid, v_mufta.name, v_mufta.the_geom_new FROM v_mufta;


--
-- Name: update_test_mufta; Type: RULE; Schema: gisetz; Owner: -
--

CREATE RULE update_test_mufta AS ON UPDATE TO test_mufta DO INSTEAD UPDATE v_mufta SET the_geom_new = new.the_geom_new WHERE (v_mufta.gid = new.gid);


--
-- Name: test_mufta; Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON TABLE test_mufta FROM PUBLIC;
REVOKE ALL ON TABLE test_mufta FROM postgres;
GRANT ALL ON TABLE test_mufta TO postgres;
GRANT SELECT,TRIGGER ON TABLE test_mufta TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

