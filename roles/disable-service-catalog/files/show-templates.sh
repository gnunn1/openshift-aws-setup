#!/bin/bash
for x in $(oc get templates -n openshift --template='{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'); do
    tags=$(oc export template $x -n openshift | grep hidden)
    if [[ ${tags} =~ "hidden" ]]; then
        tags=`echo $tags | sed -e "s/,hidden//" -e "s/tags: //"`
        oc annotate template $x tags=${tags} --overwrite -n openshift
    fi
done
