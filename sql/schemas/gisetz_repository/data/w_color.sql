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
-- Data for Name: w_color; Type: TABLE DATA; Schema: gisetz_repository; Owner: postgres
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE w_color DISABLE TRIGGER ALL;

INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (1, 'красный', 'червоний', '#FF0000');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (2, 'зеленый', 'зелений', '#008000');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (3, 'синий', 'синій', '#0000FF');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (4, 'желтый', 'жовтий', '#FFD700');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (5, 'белый', 'білий', '#D3D3D3');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (6, 'серый', 'сірий', '#696969');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (7, 'черный', 'чорний', '#000000');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (12, 'бирюзовый', NULL, '#00FFFF');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (11, 'розовый', NULL, '#FF69B4');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (10, 'фиолетовый', NULL, '#8A2BE2');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (9, 'оранжевый', NULL, '#FFA500');
INSERT INTO w_color (colid, name_r, name_u, name_e) VALUES (8, 'коричневый', NULL, '#8B4513');


ALTER TABLE w_color ENABLE TRIGGER ALL;

--
-- PostgreSQL database dump complete
--

