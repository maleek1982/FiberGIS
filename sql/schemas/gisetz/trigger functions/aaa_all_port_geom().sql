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
-- Name: aaa_all_port_geom(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_all_port_geom() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    i integer;
--    mcv_row public.v_mufcabvol%ROWTYPE;
--    mcv1_row public.v_mufcabvol%ROWTYPE;
BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
        -- Помечаем порт как удаленный
        ------UPDATE public.all_con_port SET deleted=-9999 WHERE uu_id=OLD.uu_id;
        -- ЗАКОНЧИЛИ Помечаем порт как удаленный
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT')THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT') THEN
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
        -- подправляем геометрии патчкордов идущих с/на данный порт
        IF ((ST_X(NEW.the_point_geom) <> ST_X(OLD.the_point_geom)) or (ST_Y(NEW.the_point_geom) <> ST_Y(OLD.the_point_geom))) THEN
            UPDATE all_con_port SET the_geom = SetPoint(the_geom, 0, NEW.the_point_geom)
                WHERE apg_id = NEW.id;
            UPDATE all_con_port SET the_geom = SetPoint(the_geom, (npoints(the_geom)-1), NEW.the_point_geom)
                WHERE apg_id1 = NEW.id;
            --UPDATE all_con_port SET the_geom = ST_AddBBOx(ST_DropBBox(the_geom)) WHERE apg_id = NEW.id or apg_id1 = NEW.id;
        END IF;
        -- ЗАКОНЧИЛИ подправляем геометрии патчкордов идущих с/на данный порт
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_all_port_geom(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_all_port_geom() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_all_port_geom() FROM postgres;
GRANT ALL ON FUNCTION aaa_all_port_geom() TO postgres;
GRANT ALL ON FUNCTION aaa_all_port_geom() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_all_port_geom() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

