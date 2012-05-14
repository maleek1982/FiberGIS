--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = gisetz_repository, pg_catalog;

--
-- Name: aaa_port(); Type: FUNCTION; Schema: gisetz_repository; Owner: -
--

CREATE FUNCTION aaa_port() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    i integer;
    geo geometry;
    p_geo geometry;
BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT') THEN
    /* Подгон геометрии */
    NEW.the_point_geom = SnapToGrid(NEW.the_point_geom, 1);
        IF NEW.the_geom IS NULL THEN
        NEW.the_geom = GeomFromText(AsText(BOX2D(expand(NEW.the_point_geom, 3))));
        END IF;
    /* Конец Подгон геометрии */
    /* Вычисляем dev_type_id & dev_port_id если пытаются вставить 0 & 0 */
    IF NEW.dev_type_id = 0 THEN
    SELECT dt.id INTO NEW.dev_type_id FROM dev_type dt
        WHERE NEW.the_point_geom && dt.the_geom;
    END IF;
    --
    IF NEW.dev_port_id = 0 THEN
    SELECT dp.dev_port_id + 1 INTO NEW.dev_port_id FROM dev_port dp
        WHERE dp.dev_type_id = NEW.dev_type_id
        ORDER BY dp.dev_port_id DESC
        LIMIT 1;
    END IF;
    --
    IF (NEW.name = '') or (NEW.name IS NULL) THEN
    NEW.name = NEW.dev_port_id;
    END IF;
    --
    IF NEW.ref_geom_port > 0 THEN
    SELECT dp.the_geom, dp.the_point_geom INTO geo, p_geo FROM dev_port dp
        WHERE dp.dev_type_id = NEW.dev_type_id and dp.dev_port_id=NEW.ref_geom_port;
    NEW.the_geom = Translate(geo,-(X(p_geo)-X(NEW.the_point_geom)),-(Y(p_geo)-Y(NEW.the_point_geom)),0);
    END IF;


    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    NEW.the_point_geom = SnapToGrid(NEW.the_point_geom, 1);
    NEW.the_geom = SnapToGrid(NEW.the_geom, 1);
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'INSERT') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_port(); Type: ACL; Schema: gisetz_repository; Owner: -
--

REVOKE ALL ON FUNCTION aaa_port() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_port() FROM postgres;
GRANT ALL ON FUNCTION aaa_port() TO postgres;
GRANT ALL ON FUNCTION aaa_port() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_port() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

