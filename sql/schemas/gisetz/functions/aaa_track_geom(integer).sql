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
-- Name: aaa_track_geom(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_track_geom(integer) RETURNS public.geometry
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    track_id alias for $1;
    start_toptrack toptrack%ROWTYPE;
    end_toptrack toptrack%ROWTYPE;
    start_point geometry;
    end_point geometry;
    track_geom geometry;
BEGIN

        BEGIN
        SELECT tt.* INTO STRICT start_toptrack FROM toptrack tt, track t
            WHERE t."OBJECTID" = track_id
                AND t."IDBEG" = tt."OBJECTID";
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    NULL;
                WHEN TOO_MANY_ROWS THEN
                    NULL;
        END;
        start_point = start_toptrack.the_geom;
        BEGIN
        SELECT tt.* INTO STRICT end_toptrack FROM toptrack tt, track t
            WHERE t."OBJECTID" = track_id
                AND t."IDEND" = tt."OBJECTID";
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    NULL;
                WHEN TOO_MANY_ROWS THEN
                    NULL;
        END;
        end_point = end_toptrack.the_geom;

track_geom = Multi(MakeLine(start_point, end_point));

RETURN track_geom;
 
END;
$_$;


--
-- Name: FUNCTION aaa_track_geom(integer); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_track_geom(integer) IS '
Возвращает геометрию track по OBJECTID.
';


--
-- Name: aaa_track_geom(integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_track_geom(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_track_geom(integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_track_geom(integer) TO postgres;
GRANT ALL ON FUNCTION aaa_track_geom(integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_track_geom(integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

