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
-- Name: aaa_podgonalldevportdescr(integer); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION aaa_podgonalldevportdescr(integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
    AllDevID alias for $1;
    get_type character varying;
    descr_oid character varying;
    geo geometry;
    other text;

BEGIN

BEGIN
SELECT dt.get_port_descr_type, dt.descr_oid INTO STRICT get_type, descr_oid 
    FROM all_dev_geom adg, dev_type dt 
    WHERE adg.id = AllDevID 
        and adg.dev_type_id = dt.id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN NULL;
        WHEN TOO_MANY_ROWS THEN NULL;
END;
IF FOUND THEN
    IF (get_type = 'snmp') THEN
    UPDATE all_port_geom
        SET descr = gisetz.snmpget(adg.ip, adg.get_community, dp.descr_oid)
        FROM all_dev_geom adg, all_port_geom apg, dev_port dp
        WHERE adg.id = AllDevID and apg.dev_id = AllDevID and dp.dev_type_id = adg.dev_type_id and dp.dev_port_id = apg.port_id 
            and all_port_geom.id = apg.id;
    UPDATE all_port_geom
        SET status = cast(gisetz.snmpget(adg.ip, adg.get_community, dp.status_oid) as integer)
        FROM all_dev_geom adg, all_port_geom apg, dev_port dp
        WHERE adg.id = AllDevID and apg.dev_id = AllDevID and dp.dev_type_id = adg.dev_type_id and dp.dev_port_id = apg.port_id 
            and all_port_geom.id = apg.id and dp.status_oid IS NOT NULL;
    UPDATE all_dev_geom
        SET descr = gisetz.snmpget(ip, get_community, descr_oid)
        WHERE id = AllDevID;
-- get_type = 'odf_gis'
    ELSIF (get_type = 'odf_gis') THEN
    --    UPDATE all_port_geom
    --        SET descr = vmcv1.st_name
    --        FROM v_mufcabvol vmcv, v_mufcabvol vmcv1, all_dev_geom adg, all_dev_to_mufcab adtmc, v_muf_con vmc
    --        WHERE adg.id = AllDevID and dev_id = AllDevID and adtmc.all_dev_id = AllDevID
    --            and vmcv.mid = adtmc.mid and vmcv.cabid = adtmc.cabid
    --            and vmcv.volid = port_id and
    --            vmc.mid = adtmc.mid and vmc.cabid = adtmc.cabid and vmc.volid = port_id
    --            and vmcv1.mid = vmc.mid1 and vmcv1.cabid = vmc.cabid1 and vmcv1.volid = vmc.volid1;
    --    UPDATE all_port_geom
    --        SET descr = vmcv1.st_name
    --        FROM v_mufcabvol vmcv, v_mufcabvol vmcv1, all_dev_geom adg, all_dev_to_mufcab adtmc, v_muf_con vmc
    --        WHERE adg.id = AllDevID and dev_id = AllDevID and adtmc.all_dev_id = AllDevID
    --            and vmcv.mid = adtmc.mid and vmcv.cabid = adtmc.cabid
    --            and vmcv.volid = port_id and
    --            vmc.mid1 = adtmc.mid and vmc.cabid1 = adtmc.cabid and vmc.volid1 = port_id
    --            and vmcv1.mid = vmc.mid and vmcv1.cabid = vmc.cabid and vmcv1.volid = vmc.volid;
    UPDATE all_dev_geom
        SET descr = vmc.descr 
        FROM all_dev_to_mufcab adtmc, v_mufcab vmc
        WHERE all_dev_geom.id = AllDevID and adtmc.all_dev_id = AllDevID
            and vmc.mid = adtmc.mid and vmc.cabid = adtmc.cabid and adtmc.deleted >= 0;
    UPDATE all_port_geom
        SET descr = vmcv.descr
        FROM v_mufcabvol vmcv, 
        all_dev_geom adg, 
        all_dev_to_mufcab adtmc
        WHERE adg.id = AllDevID and dev_id = AllDevID and adtmc.all_dev_id = AllDevID
            and vmcv.mid = adtmc.mid and vmcv.cabid = adtmc.cabid
            and vmcv.volid = port_id and adtmc.deleted >= 0
    ;
    UPDATE all_port_geom
        SET status = 1
        FROM v_mufcabvol vmcv, 
        all_dev_geom adg, 
        all_dev_to_mufcab adtmc
        WHERE adg.id = AllDevID and dev_id = AllDevID and adtmc.all_dev_id = AllDevID
            and vmcv.mid = adtmc.mid and vmcv.cabid = adtmc.cabid
            and vmcv.volid = port_id
            and 0 < vmcv.vol_use and adtmc.deleted >= 0
    ;
    UPDATE all_port_geom
        SET status = 0
        FROM v_mufcabvol vmcv, 
        all_dev_geom adg, 
        all_dev_to_mufcab adtmc
        WHERE adg.id = AllDevID and dev_id = AllDevID and adtmc.all_dev_id = AllDevID
            and vmcv.mid = adtmc.mid and vmcv.cabid = adtmc.cabid
            and vmcv.volid = port_id
            and 0 >= vmcv.vol_use and adtmc.deleted >= 0
    ;
-- get_type = 'patch'
    ELSIF (get_type = 'patch') THEN
    UPDATE all_port_geom SET name = '', descr = '' WHERE dev_id = AllDevID;
    UPDATE all_port_geom 
        SET name = apg.name, descr = apg.descr, status = apg.status
        FROM all_con_port acp, all_port_geom apg
        WHERE all_port_geom.dev_id = AllDevID
            and acp.apg_dev_id = AllDevID and acp.apg_id = all_port_geom.id
            and apg.id = acp.apg_id1 and acp.con_type=99 and deleted >=0;
    UPDATE all_port_geom 
        SET name = apg.name, descr = apg.descr, status = apg.status 
        FROM all_con_port acp, all_port_geom apg
        WHERE all_port_geom.dev_id = AllDevID
            and acp.apg_dev_id1 = AllDevID and acp.apg_id1 = all_port_geom.id
            and apg.id = acp.apg_id and acp.con_type=99 and deleted >=0;
    ELSIF (get_type = 'cwdm') THEN
        --заполняем gisetz.z_all2all внутренними связями
        SELECT gisetz.init_alldevgeom_to_all2all(uu_id) INTO other FROM all_dev_geom
        WHERE  id = AllDevID;
        --закончили заполняем gisetz.z_all2all внутренними связями
    END IF;
END IF;

RETURN AsText(geo);
 
END;
$_$;


--
-- Name: aaa_podgonalldevportdescr(integer); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION aaa_podgonalldevportdescr(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION aaa_podgonalldevportdescr(integer) FROM postgres;
GRANT ALL ON FUNCTION aaa_podgonalldevportdescr(integer) TO postgres;
GRANT ALL ON FUNCTION aaa_podgonalldevportdescr(integer) TO PUBLIC;
GRANT ALL ON FUNCTION aaa_podgonalldevportdescr(integer) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

