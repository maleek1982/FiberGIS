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
-- Name: aaa_muf_update(); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_muf_update() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO gisetz_repository, gisetz_map, gisetz_crm, gisetz, public
    AS $$
DECLARE
    i integer;
    mc_row RECORD;
    mcv_row RECORD;
    backward_d0 RECORD;
BEGIN

IF (TG_WHEN = 'BEFORE') THEN

    IF (TG_OP = 'DELETE') THEN
    DELETE FROM v_muf_con WHERE mid = OLD.gid or mid1 = OLD.gid;
    DELETE FROM v_mufcab WHERE mid = OLD.gid;
    DELETE FROM v_mufcabvol WHERE mid = OLD.gid;
    RETURN OLD;

    ELSIF (TG_OP = 'INSERT') THEN
    NEW.dreg=now();
    RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
    NEW.dinst=now();
        IF ((X(NEW.the_geom)-X(OLD.the_geom)<>0) OR (Y(NEW.the_geom)-Y(OLD.the_geom)<>0)) THEN
            UPDATE v_muf_con
            SET the_geom = Translate(the_geom, X(NEW.the_geom)-X(OLD.the_geom), Y(NEW.the_geom)-Y(OLD.the_geom))
            WHERE mid=NEW.gid OR mid1=NEW.gid;
        END IF;

----------------------------
IF (NEW.podgon=1) THEN
NEW.podgon=0;

    DELETE FROM v_mcv_d1 WHERE mid = NEW.gid;
    
    <<each_mc>>
    FOR mc_row IN SELECT * FROM v_mufcab WHERE ((v_mufcab.mid = NEW.gid) and (v_mufcab.vol_use >0)) LOOP
        <<each_mcv>>
        FOR mcv_row IN SELECT * FROM v_mufcabvol WHERE ((v_mufcabvol.mid = mc_row.mid) and (v_mufcabvol.cabid = mc_row.cabid) and NOT(v_mufcabvol.the_geom_desc IS NULL)) LOOP
            backward_d0 = get_inform_vmufcabvol_backward_d0(mcv_row.mid, mcv_row.cabid, mcv_row.volid);
            UPDATE v_mufcabvol 
                SET vol_angle = 90 * mc_row.rot,
                st_name = backward_d0.far_end_name,
                vol_type = backward_d0.near_end_vol_type,
                vol_use = backward_d0.far_end_voluse
                WHERE mcv_row.mid = mid AND mcv_row.cabid = cabid AND mcv_row.volid = volid;
            INSERT INTO v_mcv_d1(mid, cabid, volid, angle, descr, use, the_geom)
                VALUES (mcv_row.mid, mcv_row.cabid, mcv_row.volid, 90 * mc_row.rot,
                 backward_d0.far_end_descr,
                 backward_d0.far_end_voluse,
                 ST_SetSRID(Translate(Scale(RotateZ(Translate(Scale(GeometryFromText('POLYGON((-5 0.95,-2.05 0.95,-2.05 -0.95,-5 -0.95,-5 0.95))'), mc_row.flip, 1, 1), 0, mcv_row.volid*(-2), 0), mc_row.rot*(pi()/2)), 0.005,0.005,1.0), X(mc_row.the_geom), Y(mc_row.the_geom)), 900913)
                );
        END LOOP each_mcv;
    END LOOP each_mc;

UPDATE v_muf_con
    SET the_geom = aaa_con_fit(SetPoint(SetPoint(the_geom, 0, aaa_vol_point(mid, cabid, volid)), (npoints(the_geom)-1), aaa_vol_point(mid1, cabid1, volid1)))
    WHERE mid=NEW.gid;
UPDATE v_mufcab
    SET the_geom_con = aaa_cab_con(mid, cabid)
    WHERE mid=NEW.gid;
UPDATE v_muf_con
    SET the_geom=Translate(the_geom,0,0)
    WHERE mid=NEW.gid;

UPDATE v_cab_con
    SET the_geom = SetPoint(v_cab_con.the_geom, 0, aaa_cab_con_point(v_cab_con.mid, v_cab_con.cabid)) 
    WHERE v_cab_con.mid=NEW.gid;

UPDATE v_cab_con
    SET the_geom = SetPoint(v_cab_con.the_geom, (npoints(v_cab_con.the_geom)-1), aaa_cab_con_point(v_cab_con.mid1, v_cab_con.cabid1))
    WHERE v_cab_con.mid1=NEW.gid;

UPDATE v_cab_con
    SET the_geom=Translate(the_geom,0,0)
    WHERE mid=NEW.gid;


END IF;
----------------------------
IF (NEW.podgon=2) THEN
NEW.podgon=0;
UPDATE v_muf_con
    SET proj=0
    WHERE mid=NEW.gid and proj=1;

DELETE FROM v_muf_con 
    WHERE mid=NEW.gid and proj=-1;


END IF;
----------------------------
    RETURN NEW;

    END IF;

ELSIF (TG_WHEN = 'AFTER') THEN 

    IF (TG_OP = 'DELETE') THEN
    RETURN NULL;

    ELSIF (TG_OP = 'INSERT') THEN
-- INSERT new cable for the Mufta -----------------------------------------------------------------------------
    FOR i IN 1..8 LOOP
        IF (i=1) THEN
        INSERT INTO v_mufcab(mid, cabid, name, descr, cab_use, cab_type, cab_type_def, zoom, 
            rot, flip, dreg, dinst, the_geom, vol_use)
        VALUES (NEW.gid, i, 'm'||NEW.gid||'cab'||i, '',0, 1, 1, 30, 
            0, 1, now(), now(), Translate(NEW.the_geom, -20 * 0.0025, -10 * 0.0025), 24);
        ELSIF (i=2) THEN
        INSERT INTO v_mufcab(mid, cabid, name, descr, cab_use, cab_type, cab_type_def, zoom, 
            rot, flip, dreg, dinst, the_geom, vol_use)
        VALUES (NEW.gid, i, 'm'||NEW.gid||'cab'||i, '',0, 1, 1, 30, 
            0, -1, now(), now(), Translate(NEW.the_geom,20 * 0.0025, -10 * 0.0025), 24);
        ELSIF (i>2) THEN
        INSERT INTO v_mufcab(mid, cabid, name, descr, cab_use, cab_type, cab_type_def, zoom, 
            rot, flip, dreg, dinst, the_geom, vol_use)
        VALUES (NEW.gid, i, 'm'||NEW.gid||'cab'||i, '',0, 1, 1, 30, 
            0, 1, now(), now(), Translate(NEW.the_geom, 7 * i * 0.0025, 10 * 0.0025), 0);
        END IF;
    END LOOP;
    --------------------------------------------------------------------------------------------------------
    FOR i IN 1..24 LOOP
        INSERT INTO v_muf_con(mid, cabid, volid, mid1, cabid1, volid1, name, descr, dreg, dinst, the_geom)
        VALUES (NEW.gid, 1, i, NEW.gid, 2, i, '','',
        now(), now(), NULL);
    END LOOP;
    --------------------------------------------------------------------------------------------------------
    RETURN NEW;
----------------------------------------------------------------------------------------------------------------
    ELSIF (TG_OP = 'UPDATE') THEN
    IF ((X(NEW.the_geom)-X(OLD.the_geom)<>0) OR (Y(NEW.the_geom)-Y(OLD.the_geom)<>0)) THEN
        UPDATE v_mufcab
            SET the_geom = Translate(the_geom, X(NEW.the_geom)-X(OLD.the_geom), Y(NEW.the_geom)-Y(OLD.the_geom))
            WHERE mid=NEW.gid;

        UPDATE v_cab_con
            SET the_geom = SetPoint(v_cab_con.the_geom, 0, aaa_cab_con_point(v_cab_con.mid, v_cab_con.cabid)) 
            WHERE v_cab_con.mid=NEW.gid;

        UPDATE v_cab_con
            SET the_geom = SetPoint(v_cab_con.the_geom, (npoints(v_cab_con.the_geom)-1), aaa_cab_con_point(v_cab_con.mid1, v_cab_con.cabid1))
            WHERE v_cab_con.mid1=NEW.gid;

        UPDATE v_cab_con
            SET the_geom=Translate(the_geom,0,0)
            WHERE mid=NEW.gid;

--    UPDATE v_cab_con
--    SET the_geom = SetPoint(v_cab_con.the_geom, 0, aaa_cab_con_point(v_cab_con.mid, v_cab_con.cabid))
--    WHERE v_cab_con.mid=NEW.gid;

    END IF;

----------------------------------------------------------------------------------------------------------------
    RETURN NEW;

    END IF;

END IF;

END;
$$;


--
-- Name: aaa_muf_update(); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_muf_update() FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_muf_update() FROM postgres;
GRANT ALL ON FUNCTION aaa_muf_update() TO postgres;
GRANT ALL ON FUNCTION aaa_muf_update() TO PUBLIC;
GRANT ALL ON FUNCTION aaa_muf_update() TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

