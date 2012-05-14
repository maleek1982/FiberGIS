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
-- Name: snmpgetnext(text, text, text); Type: FUNCTION; Schema: gisetz; Owner: -
--

CREATE FUNCTION snmpgetnext(hostname text, community text, oid text) RETURNS text
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
    return 'ERROR: '.$error;
}


my $result = $session->get_next_request(
-varbindlist => [$oid]
);

if (!defined($result)) {
    $session->close;
    return 'ERROR: '.$session->error;
}

#printf("sysUpTime for host '%s' is %s\n", $session->hostname, $result->{$oid} );

$session->close;
    # return $result->{0};
    my @keys = keys(%$result);
    my $key = $keys[0];
#    return "111 " . $result->{$key} . "-->" . $key;
    return "" . $key . "-->" . $result->{$key};
#    if (1+($result->{$key})) {
#    return $result->{$key} . "-->" . $key;
#    } else {
#    return "0x000000000000-->" . $key;
#    }
#    return "-->" . $key;
$_X$;


--
-- PostgreSQL database dump complete
--

