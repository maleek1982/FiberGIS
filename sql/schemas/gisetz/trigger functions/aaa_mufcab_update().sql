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
-- Name: aaa_mufcab_update(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_mufcab_update() RETURNS trigger
    LANGUAGE plpgsql STRICT
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    i integer;
BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT') THEN
    NEW.dreg=now();
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    NEW.mid=OLD.mid;
    NEW.cabid=OLD.cabid;
    NEW.dinst=now();
    IF ((X(NEW.the_geom)-X(OLD.the_geom)<>0) OR (Y(NEW.the_geom)-Y(OLD.the_geom)<>0)) THEN
      NEW.the_geom_con = Translate(OLD.the_geom_con, X(NEW.the_geom)-X(OLD.the_geom), Y(NEW.the_geom)-Y(OLD.the_geom));
    END IF;

    --NEW.the_geom_con=aaa_cab_con(NEW.mid, NEW.cabid);

    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NULL;

    ELSIF (TG_OP = 'INSERT') THEN
    -- INSERT new cable for the Mufta    
    FOR i IN 1..48 LOOP
        IF (i<NEW.vol_use+1) THEN
        INSERT INTO v_mufcabvol(mid, cabid, volid, name, descr, vol_use, vol_type, vol_type_def, 
            dreg, dinst, the_geom_vol, the_geom_desc)
        VALUES (NEW.mid, NEW.cabid, i, 'vol_'||i, '', 0, 1, 1, 
            now(), now(), aaa_vol_con(NEW.mid, NEW.cabid, i), aaa_vol_desc(NEW.mid, NEW.cabid, i));
        ELSIF (i>NEW.vol_use) THEN
        INSERT INTO v_mufcabvol(mid, cabid, volid, name, descr, vol_use, vol_type, vol_type_def, 
            dreg, dinst, the_geom_vol, the_geom_desc)
        VALUES (NEW.mid, NEW.cabid, i, 'vol_'||i, '', 0, 1, 1, 
            now(), now(), NULL, NULL);
        END IF;
    END LOOP;
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
        UPDATE v_mufcabvol 
        SET (the_geom_vol, the_geom_desc)=(aaa_vol_con(NEW.mid, NEW.cabid, volid), aaa_vol_desc(NEW.mid, NEW.cabid, volid)) 
        WHERE mid=NEW.mid
          AND cabid=NEW.cabid
          AND volid < NEW.vol_use+1;

        UPDATE v_mufcabvol 
        SET (the_geom_vol, the_geom_desc)=(NULL, NULL) 
        WHERE mid=NEW.mid
          AND cabid=NEW.cabid
          AND volid > NEW.vol_use;

        UPDATE v_muf_con SET mid=1 WHERE (mid = NEW.mid and cabid = NEW.cabid) or (mid1 = NEW.mid and cabid1 = NEW.cabid);

        IF ((X(NEW.the_geom)-X(OLD.the_geom)<>0) OR (Y(NEW.the_geom)-Y(OLD.the_geom)<>0)) THEN
              UPDATE v_mcv_d1
              SET the_geom = Translate(the_geom, X(NEW.the_geom)-X(OLD.the_geom), Y(NEW.the_geom)-Y(OLD.the_geom))
              WHERE mid = NEW.mid AND cabid = NEW.cabid;
        END IF;

        
    RETURN NEW;

    END IF;

END IF;




--RETURN NEW;

END;
$$;


--
-- Name: aaa_mufcab_update(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_mufcab_update() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_mufcab_update() FROM postgres;
GRANT ALL ON FUNCTION aaa_mufcab_update() TO postgres;
GRANT ALL ON FUNCTION aaa_mufcab_update() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_mufcab_update() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

