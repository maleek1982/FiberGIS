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
-- Name: s_volnagr_id_seq; Type: SEQUENCE SET; Schema: gisetz_repository; Owner: postgres
--

SELECT pg_catalog.setval('s_volnagr_id_seq', 1, false);


--
-- Data for Name: s_volnagr; Type: TABLE DATA; Schema: gisetz_repository; Owner: postgres
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE s_volnagr DISABLE TRIGGER ALL;

INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (-1, 5, 'NoODF', 'не выходит на ODF             ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (0, 6, 'Своб ', 'свободно                      ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (10, 1, 'CWDM ', 'CWDM                          ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (99, 4, 'xPON ', 'xPON                          ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (2, 2, '100Mb', 'FastEthernet                  ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (4, 3, 'E1+Et', 'E1+FastEthernet               ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (3, 12, 'Арнда', 'аренда волокна                ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (1, 9, 'Занят', 'занято                        ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (5, 10, 'SDH  ', 'SDH                           ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (6, 8, '1G   ', '1 Gig                         ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (7, 11, '10G  ', '10G                           ');
INSERT INTO s_volnagr (id, colid, shifr, name) VALUES (11, 7, 'Пркл ', 'проключение волокна           ');


ALTER TABLE s_volnagr ENABLE TRIGGER ALL;

--
-- PostgreSQL database dump complete
--

