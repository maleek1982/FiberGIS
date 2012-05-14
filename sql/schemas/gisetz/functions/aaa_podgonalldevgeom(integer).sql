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
-- Name: aaa_podgonalldevgeom(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_podgonalldevgeom(integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    AllDevID alias for $1;
    geo geometry;

BEGIN

    UPDATE all_dev_geom
        SET the_geom = ST_SetSRID(Translate(dt.the_geom, -(X(dt.the_point_geom)-X(adg.the_point_geom)), -(Y(dt.the_point_geom)-Y(adg.the_point_geom)), 0), 900913)
        FROM dev_type dt, all_dev_geom adg
        WHERE
            all_dev_geom.id = AllDevID and adg.id = AllDevID and dt.id=adg.dev_type_id;

    UPDATE all_mod_geom
        SET the_point_geom = ST_SetSRID(Translate(dm.the_point_geom, -(X(dt.the_point_geom)-X(adg.the_point_geom)), -(Y(dt.the_point_geom)-Y(adg.the_point_geom)), 0), 900913),
            the_geom = ST_SetSRID(Translate(dm.the_geom, -(X(dt.the_point_geom)-X(adg.the_point_geom)), -(Y(dt.the_point_geom)-Y(adg.the_point_geom)), 0), 900913)
        FROM dev_mod dm, dev_type dt, all_dev_geom adg
        WHERE
            all_mod_geom.dev_id = AllDevID and adg.id = AllDevID -- tolko dla modulej dannogo ustrojstva, RESULTAT 1 row
            and dt.id = adg.dev_type_id and dm.dev_type_id = adg.dev_type_id -- obrazets berem iz table DT, RESULTAT 1 row
            and all_mod_geom.mod_id = dm.dev_mod_id; -- ID modulja sovpadaet s ID_Obrazca, RESULTAT mnogo row

    UPDATE all_port_geom
        SET the_point_geom = ST_SetSRID(Translate(dp.the_point_geom, -(X(dt.the_point_geom)-X(adg.the_point_geom)), -(Y(dt.the_point_geom)-Y(adg.the_point_geom)), 0), 900913),
            the_geom = ST_SetSRID(Translate(dp.the_geom, -(X(dt.the_point_geom)-X(adg.the_point_geom)), -(Y(dt.the_point_geom)-Y(adg.the_point_geom)), 0), 900913)
        FROM dev_port dp, dev_type dt, all_dev_geom adg
        WHERE
            all_port_geom.dev_id = AllDevID and adg.id = AllDevID -- tolko dla portov dannogo ustrojstva, RESULTAT 1 row
            and dt.id = adg.dev_type_id and dp.dev_type_id = adg.dev_type_id -- obrazets berem iz table PT, RESULTAT 1 row
            and all_port_geom.port_id = dp.dev_port_id; -- ID porta sovpadaet s ID_Obrazca, RESULTAT mnogo row

    UPDATE  all_dev_geom
        SET the_point_geom = amg.the_point_geom
        FROM  all_dev_geom adg, all_mod_geom amg
        WHERE
            amg.dev_id = AllDevID and adg.id = AllDevID and all_dev_geom.id = amg.used_by;


RETURN AsText(geo);

END;
$_$;


--
-- Name: aaa_podgonalldevgeom(integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_podgonalldevgeom(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_podgonalldevgeom(integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_podgonalldevgeom(integer) TO postgres;
GRANT ALL ON FUNCTION aaa_podgonalldevgeom(integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_podgonalldevgeom(integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

