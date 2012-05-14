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
-- Name: aaa_con_fit(public.geometry); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_con_fit(public.geometry) RETURNS public.geometry
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    the_geom0 alias for $1;        -- geometry
    k integer;
    x1 double precision;
    x2 double precision;
    y1 double precision;
    y2 double precision;
    the_geom geometry;
BEGIN
    the_geom := the_geom0;
    IF npoints(the_geom) > 2 THEN
        x1:=X(PointN(the_geom, 1));
        x2:=X(PointN(the_geom, 2));
        y1:=Y(PointN(the_geom, 1));
        y2:=Y(PointN(the_geom, 2));

        IF (ABS(x1-x2) > ABS(y1-y2)) THEN the_geom := SetPoint(the_geom, 1, MakePoint(x2, y1));
        END IF;
        IF (ABS(x1-x2) < ABS(y1-y2)) THEN the_geom := SetPoint(the_geom, 1, MakePoint(x1, y2));
        END IF;

        x1:=X(PointN(the_geom, npoints(the_geom)-0));
        x2:=X(PointN(the_geom, npoints(the_geom)-1));
        y1:=Y(PointN(the_geom, npoints(the_geom)-0));
        y2:=Y(PointN(the_geom, npoints(the_geom)-1));

        IF (ABS(x1-x2) > ABS(y1-y2)) THEN the_geom := SetPoint(the_geom, npoints(the_geom)-2, MakePoint(x2, y1));
        END IF;
        IF (ABS(x1-x2) < ABS(y1-y2)) THEN the_geom := SetPoint(the_geom, npoints(the_geom)-2, MakePoint(x1, y2));
        END IF;
    END IF;
    IF npoints(the_geom) > 3 THEN
--k=3;
        FOR k IN 3..(npoints(the_geom)-1) LOOP
        x1:=X(PointN(the_geom, k-1));
        x2:=X(PointN(the_geom, k));
        y1:=Y(PointN(the_geom, k-1));
        y2:=Y(PointN(the_geom, k));
        IF (ABS(x1-x2) > ABS(y1-y2)) THEN
            the_geom := SetPoint(the_geom, k-2, MakePoint(x1, (y1+y2)/2));
            the_geom := SetPoint(the_geom, k-1, MakePoint(x2, (y1+y2)/2));
        END IF;
        IF (ABS(x1-x2) < ABS(y1-y2)) THEN
            the_geom := SetPoint(the_geom, k-2, MakePoint((x1+x2)/2, y1));
            the_geom := SetPoint(the_geom, k-1, MakePoint((x1+x2)/2, y2));
        END IF;
        END LOOP;
    END IF;


RETURN the_geom;

END;
$_$;


--
-- Name: FUNCTION aaa_con_fit(public.geometry); Type: COMMENT; Schema: gisetz; Owner: -
--

COMMENT ON FUNCTION aaa_con_fit(public.geometry) IS '
Кажись пытается пытается сделать геометрию типа LINE без наклонных участков,
идем только по Х или У.
';


--
-- Name: aaa_con_fit(public.geometry); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_con_fit(public.geometry) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_con_fit(public.geometry) FROM postgres;
GRANT ALL ON FUNCTION aaa_con_fit(public.geometry) TO postgres;
GRANT ALL ON FUNCTION aaa_con_fit(public.geometry) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_con_fit(public.geometry) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

