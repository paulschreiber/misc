#!/bin/bash
#
# Script to add DKIM config

function usage {
  echo "Usage: sudo $0 DOMAIN [SELECTOR]";
}

if [ -z "$1" ]
then
  usage
  exit 1;
fi

if [ -z "$2" ]
then
  SELECTOR="mail"
else
  SELECTOR=$2;
fi

DOMAIN=$1;

echo "Updating opendkim config..."
echo "$DOMAIN" >> /etc/opendkim/TrustedHosts
# the ":selector" in this line is what the DNS record keys off of
echo "$SELECTOR._domainkey.$DOMAIN $DOMAIN:$SELECTOR:/etc/opendkim/keys/$DOMAIN/$SELECTOR.private" >> /etc/opendkim/KeyTable
echo "$DOMAIN $SELECTOR._domainkey.$DOMAIN" >> /etc/opendkim/SigningTable

echo "Generating keys..."
mkdir "/etc/opendkim/keys/$DOMAIN" || exit
cd "/etc/opendkim/keys/$DOMAIN" || exit
opendkim-genkey -s "$SELECTOR" -d "$DOMAIN"
chown "opendkim:opendkim $SELECTOR.private"

echo "Now create a DNS record $SELECTOR._domainkey.$DOMAIN with this data:"
cat "/etc/opendkim/keys/$DOMAIN/$SELECTOR.txt"

echo "Restarting postfix..."
service postfix restart

echo "Restarting opendkim..."
service opendkim restart

