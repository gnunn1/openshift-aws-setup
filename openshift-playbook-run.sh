#!/usr/bin/env bash

: ${AWS_ACCESS_KEY_ID?"Need to set AWS_ACCESS_KEY_ID"}
: ${AWS_SECRET_ACCESS_KEY?"Need to set AWS_SECRET_ACCESS_KEY"}

export ANSIBLE_HOST_KEY_CHECKING=False

time ansible-playbook openshift-playbook.yml -i inventory/inventory.cfg "$@"