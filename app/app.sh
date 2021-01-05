#!/bin/bash

bail()
{
  echo $1
  exit 1
}

CONFIG="/etc/stunnel/stunnel.conf"

if [ -z "${ACCEPT}" ]; then
  bail "ACCEPT is empty!"
fi

if [ -z "${CONNECT}" ]; then
  bail "CONNECT is empty!"
fi

echo "[server]" >>${CONFIG}
echo "accept = ${ACCEPT}" >>${CONFIG}
echo "connect = ${CONNECT}" >>${CONFIG}

if [ -n "${CERTKEYFILE}" ]; then
  CERTKEYPATH="/crypto/${CERTKEYFILE}"
  if [ ! -r ${CERTKEYPATH} ]; then
    bail "${CERTKEYPATH} is not readable!"
  fi
  echo "cert = ${CERTKEYPATH}" >>${CONFIG}
elif [ -n "${CERTFILE}" ] && [ -n "${KEYFILE}" ]; then
  CERTPATH="/crypto/${CERTFILE}"
  KEYPATH="/crypto/${KEYFILE}"
  if [ ! -r ${CERTPATH} ]; then
    bail "${CERTPATH} is not readable!"
  fi
  if [ ! -r ${KEYPATH} ]; then
    bail "${KEYPATH} is not readable!"
  fi
  echo "cert = ${CERTPATH}" >>${CONFIG}
  echo "key = ${KEYPATH}" >>${CONFIG}
else
  bail "Unknown Configuration!"
fi

if [ "${RUNSTUNNELASROOT}" == "1" ]; then
  sed -e 's/setuid = stunnel4/;setuid = stunnel4/' -i ${CONFIG}
  sed -e 's/setgid = stunnel4/;setgid = stunnel4/' -i ${CONFIG}
else
  chown -R stunnel4.stunnel4 /var/log/stunnel4
fi

exec stunnel4 ${CONFIG}
