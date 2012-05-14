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
-- Name: snmpget(text, text, text); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION snmpget(hostname text, community text, oid text) RETURNS text
    LANGUAGE plperlu
    AS $_X$
use strict;

use Net::SNMP;
my $hostname = $_[0];
my $community = $_[1];
my $oid = $_[2];

my ($session, $error) = Net::SNMP->session(
-hostname  => $hostname,
-community => $community,
-port=> 161 
);

if (!defined($session)) {
    return '0 ERROR: '.$error;
}


my $result = $session->get_request(
-varbindlist => [$oid]
);

if (!defined($result)) {
    $session->close;
    return '0'.$session->error;
}

printf("sysUpTime for host '%s' is %s\n",
$session->hostname, $result->{$oid} 
);

$session->close;
    return $result->{$oid};
$_X$;


--
-- Name: snmpget(text, text, text); Type: ACL; Schema: gisetz; Owner: -
--

REVOKE ALL ON FUNCTION snmpget(hostname text, community text, oid text) FROM PUBLIC;
REVOKE ALL ON FUNCTION snmpget(hostname text, community text, oid text) FROM postgres;
GRANT ALL ON FUNCTION snmpget(hostname text, community text, oid text) TO postgres;
GRANT ALL ON FUNCTION snmpget(hostname text, community text, oid text) TO PUBLIC;
GRANT ALL ON FUNCTION snmpget(hostname text, community text, oid text) TO read_roles WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

