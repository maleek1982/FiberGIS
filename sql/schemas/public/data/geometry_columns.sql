--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Data for Name: geometry_columns; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'canada', 'the_geom', 2, -1, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'alaska', 'the_geom', 2, -1, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'states', 'the_geom', 2, -1, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'q1q1', 'the_geom', 2, -1, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'airports', 'the_geom', 2, -1, 'MULTIPOINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'railroads', 'the_geom', 2, -1, 'MULTILINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'roads', 'the_geom', 2, -1, 'MULTILINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'water', 'the_geom', 2, -1, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'water2', 'the_geom', 2, -1, 'MULTILINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'lendwater', 'the_geom', 2, -1, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 's_serge', 'the_geom', 2, -1, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'c_ns', 'the_geom', 2, -1, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'hist_v_mufta', 'the_geom', 2, -1, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'hist_v_mufta', 'the_geom_new', 2, -1, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'reproject_abc', 'the_geom_a', 2, -1, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'v_cab_con', 'the_geom_new', 2, -1, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'vampire', 'the_geom', 2, -1, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'highlight', 'the_geom', 2, -1, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'label', 'the_geom', 2, -1, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'houseall', 'the_geom_900913', 2, 900913, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'v_cab_con', 'the_geom_900913', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'v_mufta', 'the_geom_900913', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'journal_orders', 'the_geom_900913', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'toptrack', 'the_geom_900913', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'public', 'track', 'the_geom_900913', 2, 900913, 'MULTILINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'proj_line', 'the_geom', 2, -1, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_map', 'streetall', 'the_geom_900913', 2, 900913, 'MULTILINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_crm', 'journal_orders', 'the_geom', 2, -1, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'notes', 'the_geom', 2, -1, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mufcabvolc', 'the_geom_vol', 2, -1, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mufcabvold', 'the_geom_desc', 2, -1, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mufta', 'the_geom_new', 2, -1, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_map', 'houseall', 'the_geom', 2, 900913, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_map', 'polall', 'the_geom', 2, 900913, 'MULTIPOLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_map', 'streetall', 'the_geom', 2, 900913, 'MULTILINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mufta', 'the_geom', 1, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mufcabvol', 'the_geom_desc', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mufcabvol', 'the_geom_vol', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mufcab', 'the_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mufcab', 'the_geom_con', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_muf_con', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_cab_con', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mcv_d1', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mcv_d2', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_mcv_d3', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_muf_addcon', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'track', 'the_geom', 2, 900913, 'MULTILINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'toptrack', 'the_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'a_add_kanal', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_add_hi', 'the_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'v_highlight', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_dev_geom', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_dev_geom', 'the_point_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_mod_geom', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_mod_geom', 'the_point_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_port_geom', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_port_geom', 'the_point_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_con_port', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_st', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'dev_type', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'dev_type', 'the_point_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'dev_mod', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'dev_mod', 'the_point_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'dev_port', 'the_geom', 2, 900913, 'POLYGON');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'dev_port', 'the_point_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'gr', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'gr_1', 'the_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_repository', 'dev_port_con', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz', 'all_devport_addcon', 'the_geom', 2, 900913, 'LINESTRING');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_cable', 'closure', 'the_geom', 2, 900913, 'POINT');
INSERT INTO geometry_columns (f_table_catalog, f_table_schema, f_table_name, f_geometry_column, coord_dimension, srid, type) VALUES ('', 'gisetz_cable', 'cable', 'the_geom', 2, 900913, 'LINESTRING');


--
-- PostgreSQL database dump complete
--

