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
-- Name: aaa_all_con_port_add(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_all_con_port_add(integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    all_devport_addcon_conid alias for $1;
    geo geometry;

BEGIN

BEGIN
INSERT INTO all_con_port(
        id, name, descr, con_type,
        apg_id, apg_id1,
        apg_dev_id, apg_port_id,
        apg_dev_id1, apg_port_id1,
        the_geom)

    SELECT nextval('all_con_port_id_seq'::regclass), 'name', 'descr', 1,
        apg.id, apg1.id,
        apg.dev_id, apg.port_id,
        apg1.dev_id, apg1.port_id,
        setPoint( setPoint( ada.the_geom, (npoints(ada.the_geom)-1), apg1.the_point_geom), 0, apg.the_point_geom)

    FROM all_devport_addcon ada, all_port_geom apg, all_port_geom apg1

    WHERE (ada.conid = all_devport_addcon_conid) and (Distance(apg.the_geom, StartPoint(ada.the_geom))=0) and (Distance(apg1.the_geom, EndPoint(ada.the_geom))=0);
END;
IF FOUND THEN
    DELETE FROM all_devport_addcon WHERE conid=all_devport_addcon_conid;
END IF;

RETURN AsText(geo);
 
END;
$_$;


--
-- Name: aaa_all_con_port_add(integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_all_con_port_add(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_all_con_port_add(integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_all_con_port_add(integer) TO postgres;
GRANT ALL ON FUNCTION aaa_all_con_port_add(integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_all_con_port_add(integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

