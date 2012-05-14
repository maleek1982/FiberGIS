@echo Start... INIT DB
@echo off

set CON=--host localhost --port 5432 --username %1
set DB=%2

set PG_INST_PATH=/Program Files/PostgreSQL/8.4/
set PG_SHARE_PATH=%PG_INST_PATH%share/contrib/

PATH=%PATH%;C:%PG_INST_PATH%bin/

set CON_DB=%CON% --dbname=%DB%

@echo Start... Add PostGIS to Database %DB%
psql --host localhost --port 5432 --username postgres --dbname=%DB% < "%PG_SHARE_PATH%postgis-1.5/postgis.sql" > NUL
psql --host localhost --port 5432 --username postgres --dbname=%DB% < "%PG_SHARE_PATH%postgis-1.5/spatial_ref_sys.sql" > NUL
psql --host localhost --port 5432 --username postgres --dbname=%DB% < "%PG_SHARE_PATH%postgis-1.5/postgis_comments.sql" > NUL
echo GRANT SELECT ON TABLE geometry_columns TO public; | psql --host localhost --port 5432 --username postgres --dbname=%DB%
echo CREATE ROLE read_roles NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE; | psql --host localhost --port 5432 --username postgres --dbname=%DB%
echo CREATE ROLE proj NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE; | psql --host localhost --port 5432 --username postgres --dbname=%DB%

@echo Start... Add UUID to Database %DB%
psql --host localhost --port 5432 --username postgres --dbname=%DB% < "%PG_SHARE_PATH%uuid-ossp.sql" > NUL

@echo Start... Add new schemas, languages...
echo CREATE SCHEMA gisetz; | psql %CON_DB%
echo CREATE SCHEMA gisetz_repository; | psql %CON_DB%
echo CREATE SCHEMA gisetz_crm; | psql %CON_DB%
echo CREATE SCHEMA gisetz_map; | psql %CON_DB%
echo COMMENT ON SCHEMA gisetz IS 'storage cables, optical couplings, active equipment, etc.'; | psql %CON_DB%
echo ALTER DATABASE %DB% SET search_path=public, gisetz, gisetz_repository, gisetz_crm, gisetz_map; | psql %CON_DB%

@echo Start... Add new functions to schema gisetz...
psql %CON_DB% < "./schemas/gisetz/functions/aaa_all_con_port_add(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_cab_con(integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_cab_con_point(integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_con_fit(public.geometry).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_listchildren(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_mufcabvol_desc_name(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_podgonalldevgeom(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_podgonalldevportdescr(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_st_name(integer, integer, integer).sql"
rem psql %CON_DB% < "./schemas/gisetz/functions/aaa_st_name_new(integer, integer, integer).sql"
rem psql %CON_DB% < "./schemas/gisetz/functions/aaa_st_name_propagation(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_track_geom(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_update_geom_v_mufcabvol(integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_vol_angle(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_vol_con(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_vol_desc(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_vol_desc_d1(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_vol_fitting(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_vol_point(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_vol_z_geom(public.geometry, integer, integer, integer, real).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_vold_z_geom(public.geometry, integer, integer, integer, real).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_voldesc_geom(public.geometry, integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_volocno_geom(public.geometry, integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_volp_z_geom(public.geometry, integer, integer, integer, real).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaaaaaa(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/dev_name_sufix(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/dev_name_sufix2(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/highlight_line(text, uuid).sql"
psql %CON_DB% < "./schemas/gisetz/functions/init_all2all(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/init_allconport_to_all2all(uuid).sql"
psql %CON_DB% < "./schemas/gisetz/functions/init_alldevgeom_to_all2all(uuid).sql"
psql %CON_DB% < "./schemas/gisetz/functions/init_alldevtomufcab_to_all2all(uuid).sql"
psql %CON_DB% < "./schemas/gisetz/functions/init_vcabcon_to_all2all(uuid).sql"
psql %CON_DB% < "./schemas/gisetz/functions/init_vmufcab_to_all2all(uuid).sql"
psql %CON_DB% < "./schemas/gisetz/functions/init_vmufcon_to_all2all(uuid).sql"
psql %CON_DB% < "./schemas/gisetz/functions/int_to_text(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/lambda_bool(integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/lambda_int(integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/patch_count_by_port_id(integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/snmpget(text, text, text).sql"
psql %CON_DB% < "./schemas/gisetz/functions/snmpgetnext(text, text, text).sql"


@echo Start... Add new trigger functions to schema gisetz...
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_add_kanal().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_all_con_port().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_all_dev_geom().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_all_dev_to_mufcab().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_all_devport_addcon().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_all_port_geom().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_cab_con().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_con_add().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_con_update().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_feet_kanal().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_feet_toptrack().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_muf_update().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_mufcab_update().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_st_podgon().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_v_hi().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_v_hi2().sql"
psql %CON_DB% < "./schemas/gisetz/trigger functions/aaa_v_mufcabvol_restr_afupd().sql"

@echo Start... Add new tables to schema gisetz...
psql %CON_DB% < "./schemas/gisetz/tables/a_add_kanal.sql"
psql %CON_DB% < "./schemas/gisetz/tables/all_con_port.sql"
psql %CON_DB% < "./schemas/gisetz/tables/all_dev_geom.sql"
psql %CON_DB% < "./schemas/gisetz/tables/all_dev_to_mufcab.sql"
psql %CON_DB% < "./schemas/gisetz/tables/all_devport_addcon.sql"
psql %CON_DB% < "./schemas/gisetz/tables/all_mod_geom.sql"
psql %CON_DB% < "./schemas/gisetz/tables/all_port_geom.sql"
psql %CON_DB% < "./schemas/gisetz/tables/all_port_geom_hist.sql"
psql %CON_DB% < "./schemas/gisetz/tables/all_st.sql"
psql %CON_DB% < "./schemas/gisetz/tables/highlight.sql"
psql %CON_DB% < "./schemas/gisetz/tables/label.sql"
psql %CON_DB% < "./schemas/gisetz/tables/mc_to_atsodf.sql"
psql %CON_DB% < "./schemas/gisetz/tables/notes.sql"
psql %CON_DB% < "./schemas/gisetz/tables/toptrack.sql"
psql %CON_DB% < "./schemas/gisetz/tables/track.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_add_hi.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_cab_con.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_highlight.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mcv_d1.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mcv_d2.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mcv_d3.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_muf_addcon.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_muf_con.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mufcab.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mufcabvol.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mufcabvol_hist.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mufcabvolc.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mufcabvold.sql"
psql %CON_DB% < "./schemas/gisetz/tables/v_mufta.sql"
psql %CON_DB% < "./schemas/gisetz/tables/z_all2all.sql"

psql %CON_DB% < "./schemas/gisetz/functions/aaa_st_name_new(integer, integer, integer).sql"
psql %CON_DB% < "./schemas/gisetz/functions/aaa_st_name_propagation(integer, integer, integer).sql"


@echo Start... Add new views to schema gisetz...

@echo Start... Add new functions to schema gisetz_repository...

@echo Start... Add new trigger functions to schema gisetz_repository...
psql %CON_DB% < "./schemas/gisetz_repository/trigger functions/aaa_mod().sql"
psql %CON_DB% < "./schemas/gisetz_repository/trigger functions/aaa_port().sql"
psql %CON_DB% < "./schemas/gisetz_repository/trigger functions/aaa_type().sql"

@echo Start... Add new tables to schema gisetz_repository...
psql %CON_DB% < "./schemas/gisetz_repository/tables/dev_mod.sql"
psql %CON_DB% < "./schemas/gisetz_repository/tables/dev_port.sql"
psql %CON_DB% < "./schemas/gisetz_repository/tables/dev_port_con.sql"
psql %CON_DB% < "./schemas/gisetz_repository/tables/dev_type.sql"
psql %CON_DB% < "./schemas/gisetz_repository/tables/gr.sql"
psql %CON_DB% < "./schemas/gisetz_repository/tables/s_volnagr.sql"
psql %CON_DB% < "./schemas/gisetz_repository/tables/w_cabcolor.sql"
psql %CON_DB% < "./schemas/gisetz_repository/tables/w_cabtype.sql"
psql %CON_DB% < "./schemas/gisetz_repository/tables/w_color.sql"

@echo Start... Add new tables to schema gisetz_crm...
psql %CON_DB% < "./schemas/gisetz_crm/tables/journal_orders.sql"

@echo Start... Add data to tables...
psql --host localhost --port 5432 --username postgres --dbname=%DB% < "./schemas/public/data/geometry_columns.sql"

psql %CON_DB% < "./schemas/gisetz_repository/data/dev_mod.sql"
psql %CON_DB% < "./schemas/gisetz_repository/data/dev_port.sql"
psql %CON_DB% < "./schemas/gisetz_repository/data/dev_port_con.sql"
psql %CON_DB% < "./schemas/gisetz_repository/data/dev_type.sql"
psql %CON_DB% < "./schemas/gisetz_repository/data/gr.sql"
psql %CON_DB% < "./schemas/gisetz_repository/data/s_volnagr.sql"
psql %CON_DB% < "./schemas/gisetz_repository/data/w_cabcolor.sql"
psql %CON_DB% < "./schemas/gisetz_repository/data/w_cabtype.sql"
psql %CON_DB% < "./schemas/gisetz_repository/data/w_color.sql"

rem PAUSE

