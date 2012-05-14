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
-- Data for Name: w_cabtype; Type: TABLE DATA; Schema: gisetz_repository; Owner: postgres
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE w_cabtype DISABLE TRIGGER ALL;

INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (1, 2, 24);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (2, 2, 16);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (3, 1, 12);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (4, 4, 48);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (5, 4, 12);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (6, 3, 6);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (7, 1, 8);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (8, 4, 16);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (9, 6, 32);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (10, 1, 8);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (11, 6, 48);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (12, 3, 28);
INSERT INTO w_cabtype (typeid, modnum, volnum) VALUES (13, 6, 24);


ALTER TABLE w_cabtype ENABLE TRIGGER ALL;

--
-- PostgreSQL database dump complete
--

