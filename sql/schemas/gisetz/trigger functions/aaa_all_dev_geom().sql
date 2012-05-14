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
-- Name: aaa_all_dev_geom(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_all_dev_geom() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    i integer;
    geo geometry;
    p_geo geometry;
BEGIN
-- NEW id, dev_type_id, name, descr, the_point_geom, the_geom, mod_to_dev, mod_id
IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT') THEN
    SELECT amg.the_point_geom, amg.dev_id, amg.mod_id
        INTO p_geo, NEW.mod_to_dev, NEW.mod_id
        FROM all_mod_geom amg
        WHERE (NEW.the_point_geom && amg.the_geom) and (amg.used_by=0);
    IF p_geo IS NULL THEN
        NEW.mod_to_dev=0;
        NEW.mod_id=0;
    ELSE NEW.the_point_geom = p_geo;
        UPDATE all_mod_geom SET used_by=NEW.id WHERE dev_id=NEW.mod_to_dev and mod_id=NEW.mod_id;
    END IF;
    --NEW.the_point_geom = SnapToGrid(NEW.the_point_geom, 1);
    SELECT Translate(dt.the_geom, -(X(dt.the_point_geom)-X(NEW.the_point_geom)), -(Y(dt.the_point_geom)-Y(NEW.the_point_geom)), 0), dt.id||' - '||dt.name
        INTO NEW.the_geom, NEW.name FROM dev_type dt
        WHERE dt.id = NEW.dev_type_id;

    INSERT INTO all_port_geom(id, dev_id, port_id, name, descr, the_point_geom, the_geom)
        SELECT nextval('all_port_geom_id_seq'::regclass), NEW.id, dp.dev_port_id, dp.name, dp.name,
            Translate(dp.the_point_geom, -(X(dt.the_point_geom)-X(NEW.the_point_geom)), -(Y(dt.the_point_geom)-Y(NEW.the_point_geom)), 0),
            Translate(dp.the_geom, -(X(dt.the_point_geom)-X(NEW.the_point_geom)), -(Y(dt.the_point_geom)-Y(NEW.the_point_geom)), 0)
        FROM dev_port dp, dev_type dt        --id, dev_type_id, dev_port_id, ref_geom_port, name, the_point_geom, the_geom
        WHERE (dp.dev_type_id = NEW.dev_type_id) and (dt.id = NEW.dev_type_id);

    INSERT INTO all_mod_geom(id, dev_id, mod_id, name, descr, the_point_geom, the_geom)
        SELECT nextval('all_mod_geom_id_seq'::regclass), NEW.id, dm.dev_mod_id, dm.name, dm.name,
            Translate(dm.the_point_geom, -(X(dt.the_point_geom)-X(NEW.the_point_geom)), -(Y(dt.the_point_geom)-Y(NEW.the_point_geom)), 0),
            Translate(dm.the_geom, -(X(dt.the_point_geom)-X(NEW.the_point_geom)), -(Y(dt.the_point_geom)-Y(NEW.the_point_geom)), 0)
        FROM dev_mod dm, dev_type dt
        WHERE (dm.dev_type_id = NEW.dev_type_id) and (dt.id = NEW.dev_type_id);
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    --NEW.the_point_geom = SnapToGrid(NEW.the_point_geom, 1);
    IF (NEW.podgon = 1) THEN
        NEW.podgon=0;
        PERFORM aaa_PodgonAllDevPortDescr(NEW.id);
    END IF;
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'INSERT') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    IF ((ST_X(NEW.the_point_geom) <> ST_X(OLD.the_point_geom)) or (ST_Y(NEW.the_point_geom) <> ST_Y(OLD.the_point_geom))) THEN PERFORM aaa_podgonalldevgeom(NEW.id); END IF;
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_all_dev_geom(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_all_dev_geom() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_all_dev_geom() FROM postgres;
GRANT ALL ON FUNCTION aaa_all_dev_geom() TO postgres;
GRANT ALL ON FUNCTION aaa_all_dev_geom() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_all_dev_geom() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

