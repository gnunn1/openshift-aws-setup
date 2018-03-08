#!/bin/bash -e
# Taken from article here https://www.redpill-linpro.com/sysadvent/2017/12/15/letsencrypt-on-openshift.html
LINEAGE=${1:-/etc/letsencrypt/live/cloudapps.example.com}
PROJECT=${2:-openshift-infra}
ROUTE=${3:-hawkular-metrics}

update_tls() {
  type=${1}
  case ${type} in
    key)
      pem="${2}/privkey.pem"
    ;;
    certificate)
      pem="${2}/cert.pem"
    ;;
    caCertificate)
      pem="${2}/chain.pem"
    ;;
  esac
  oc="oc -n ${3}"
  res="routes/${4}"
  if ! diff -q ${pem} <(${oc} get ${res} --template '{{.spec.tls.'${type}'}}')
  then
    echo "Updating key from ${pem}..."
    ${oc} patch ${res} --patch "{\"spec\":{\"tls\":{\"${type}\":\"$(awk '{printf "%s\\n",$0}' ${pem})\"}}}"
  fi
}

update_tls key ${LINEAGE} ${PROJECT} ${ROUTE}
update_tls certificate ${LINEAGE} ${PROJECT} ${ROUTE}
update_tls caCertificate ${LINEAGE} ${PROJECT} ${ROUTE}

exit 0