#!/bin/bash
#use "su - postgres" befor start

echo Start... INIT DB
DB=gis_2013
PG_SHARE_PATH="/usr/share/postgresql/8.4/contrib"

echo Start... Drop Database - $DB
dropdb $DB

echo Start... Create Database - $DB
createdb -E UNICODE -T template0 $DB

echo Start... Add new schemas, languages, postgis, uuid... on DB - $DB
createlang plpgsql $DB
createlang plperlu $DB
createlang plpythonu $DB

psql -d $DB -f $PG_SHARE_PATH/postgis-1.5/postgis.sql
psql -d $DB -f $PG_SHARE_PATH/postgis-1.5/spatial_ref_sys.sql
psql -d $DB -f $PG_SHARE_PATH/postgis_comments.sql
psql -d $DB -f $PG_SHARE_PATH/uuid-ossp.sql

echo "GRANT SELECT ON TABLE geometry_columns TO public;" | psql -d $DB
echo "CREATE ROLE read_roles NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;" | psql -d $DB
echo "CREATE ROLE proj NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;" | psql -d $DB

echo "CREATE SCHEMA gisetz;" | psql -d $DB
echo "CREATE SCHEMA gisetz_repository;" | psql -d $DB
echo "CREATE SCHEMA gisetz_crm;" | psql -d $DB
echo "CREATE SCHEMA gisetz_map;" | psql -d $DB
echo "ALTER DATABASE $DB SET search_path=public, gisetz, gisetz_repository, gisetz_crm, gisetz_map;" | psql -d $DB


echo Start... Add new functions to schema gisetz...
psql -d $DB -f "./schemas/gisetz/functions/aaa_all_con_port_add(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_cab_con(integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_cab_con_point(integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_con_fit(public.geometry).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_listchildren(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_mufcabvol_desc_name(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_podgonalldevgeom(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_podgonalldevportdescr(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_st_name(integer, integer, integer).sql"
# psql -d $DB -f "./schemas/gisetz/functions/aaa_st_name_new(integer, integer, integer).sql"
# psql -d $DB -f "./schemas/gisetz/functions/aaa_st_name_propagation(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_track_geom(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_update_geom_v_mufcabvol(integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_vol_angle(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_vol_con(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_vol_desc(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_vol_desc_d1(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_vol_fitting(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_vol_point(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_vol_z_geom(public.geometry, integer, integer, integer, real).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_vold_z_geom(public.geometry, integer, integer, integer, real).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_voldesc_geom(public.geometry, integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_volocno_geom(public.geometry, integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_volp_z_geom(public.geometry, integer, integer, integer, real).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaaaaaa(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/dev_name_sufix(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/dev_name_sufix2(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/get_inform_vmufcabvol_backward_d0(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/get_inform_vmufcabvol_forward_d0(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/highlight_line(text, uuid).sql"
psql -d $DB -f "./schemas/gisetz/functions/init_all2all(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/init_allconport_to_all2all(uuid).sql"
psql -d $DB -f "./schemas/gisetz/functions/init_alldevgeom_to_all2all(uuid).sql"
psql -d $DB -f "./schemas/gisetz/functions/init_alldevtomufcab_to_all2all(uuid).sql"
psql -d $DB -f "./schemas/gisetz/functions/init_vcabcon_to_all2all(uuid).sql"
psql -d $DB -f "./schemas/gisetz/functions/init_vmufcab_to_all2all(uuid).sql"
psql -d $DB -f "./schemas/gisetz/functions/init_vmufcon_to_all2all(uuid).sql"
psql -d $DB -f "./schemas/gisetz/functions/int_to_text(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/lambda_bool(integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/lambda_int(integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/patch_count_by_port_id(integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/snmpget(text, text, text).sql"
psql -d $DB -f "./schemas/gisetz/functions/snmpgetnext(text, text, text).sql"


echo Start... Add new trigger functions to schema gisetz...
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_add_kanal().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_all_con_port().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_all_dev_geom().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_all_dev_to_mufcab().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_all_devport_addcon().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_all_port_geom().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_cab_con().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_con_add().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_con_update().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_feet_kanal().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_feet_toptrack().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_muf_update().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_mufcab_update().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_st_podgon().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_v_hi().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_v_hi2().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/aaa_v_mufcabvol_restr_afupd().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/tmv_vcabcon_to_zall2all_dt().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/tmv_vcabcon_to_zall2all_it().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/tmv_vcabcon_to_zall2all_ut().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/tmv_vmufcab_to_zall2all_dt().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/tmv_vmufcab_to_zall2all_it().sql"
psql -d $DB -f "./schemas/gisetz/trigger functions/tmv_vmufcab_to_zall2all_ut().sql"

echo Start... Add new tables to schema gisetz...
psql -d $DB -f "./schemas/gisetz/tables/a_add_kanal.sql"
psql -d $DB -f "./schemas/gisetz/tables/all_con_port.sql"
psql -d $DB -f "./schemas/gisetz/tables/all_dev_geom.sql"
psql -d $DB -f "./schemas/gisetz/tables/all_dev_to_mufcab.sql"
psql -d $DB -f "./schemas/gisetz/tables/all_devport_addcon.sql"
psql -d $DB -f "./schemas/gisetz/tables/all_mod_geom.sql"
psql -d $DB -f "./schemas/gisetz/tables/all_port_geom.sql"
psql -d $DB -f "./schemas/gisetz/tables/all_port_geom_hist.sql"
psql -d $DB -f "./schemas/gisetz/tables/all_st.sql"
psql -d $DB -f "./schemas/gisetz/tables/highlight.sql"
psql -d $DB -f "./schemas/gisetz/tables/label.sql"
psql -d $DB -f "./schemas/gisetz/tables/mc_to_atsodf.sql"
psql -d $DB -f "./schemas/gisetz/tables/notes.sql"
psql -d $DB -f "./schemas/gisetz/tables/toptrack.sql"
psql -d $DB -f "./schemas/gisetz/tables/track.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_add_hi.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_cab_con.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_highlight.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mcv_d1.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mcv_d2.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mcv_d3.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_muf_addcon.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_muf_con.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mufcab.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mufcabvol.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mufcabvol_hist.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mufcabvolc.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mufcabvold.sql"
psql -d $DB -f "./schemas/gisetz/tables/v_mufta.sql"
psql -d $DB -f "./schemas/gisetz/tables/z_all2all.sql"

psql -d $DB -f "./schemas/gisetz/functions/aaa_st_name_new(integer, integer, integer).sql"
psql -d $DB -f "./schemas/gisetz/functions/aaa_st_name_propagation(integer, integer, integer).sql"


echo Start... Add new views to schema gisetz...
psql -d $DB -f "./schemas/gisetz/views/odf_box2.sql"
psql -d $DB -f "./schemas/gisetz/views/odf_vol.sql"

echo Start... Add new functions to schema gisetz_repository...

echo Start... Add new trigger functions to schema gisetz_repository...
psql -d $DB -f "./schemas/gisetz_repository/trigger functions/aaa_mod().sql"
psql -d $DB -f "./schemas/gisetz_repository/trigger functions/aaa_port().sql"
psql -d $DB -f "./schemas/gisetz_repository/trigger functions/aaa_type().sql"

echo Start... Add new tables to schema gisetz_repository...
psql -d $DB -f "./schemas/gisetz_repository/tables/dev_mod.sql"
psql -d $DB -f "./schemas/gisetz_repository/tables/dev_port.sql"
psql -d $DB -f "./schemas/gisetz_repository/tables/dev_port_con.sql"
psql -d $DB -f "./schemas/gisetz_repository/tables/dev_type.sql"
psql -d $DB -f "./schemas/gisetz_repository/tables/gr.sql"
psql -d $DB -f "./schemas/gisetz_repository/tables/s_volnagr.sql"
psql -d $DB -f "./schemas/gisetz_repository/tables/w_cabcolor.sql"
psql -d $DB -f "./schemas/gisetz_repository/tables/w_cabtype.sql"
psql -d $DB -f "./schemas/gisetz_repository/tables/w_color.sql"

echo Start... Add new tables to schema gisetz_crm...
psql -d $DB -f "./schemas/gisetz_crm/tables/journal_orders.sql"

echo Start... Add data to tables...
psql -d $DB -f "./schemas/public/data/geometry_columns.sql"

psql -d $DB -f "./schemas/gisetz_repository/data/dev_mod.sql"
psql -d $DB -f "./schemas/gisetz_repository/data/dev_port.sql"
psql -d $DB -f "./schemas/gisetz_repository/data/dev_port_con.sql"
psql -d $DB -f "./schemas/gisetz_repository/data/dev_type.sql"
psql -d $DB -f "./schemas/gisetz_repository/data/gr.sql"
psql -d $DB -f "./schemas/gisetz_repository/data/s_volnagr.sql"
psql -d $DB -f "./schemas/gisetz_repository/data/w_cabcolor.sql"
psql -d $DB -f "./schemas/gisetz_repository/data/w_cabtype.sql"
psql -d $DB -f "./schemas/gisetz_repository/data/w_color.sql"

echo "it is ALL"
