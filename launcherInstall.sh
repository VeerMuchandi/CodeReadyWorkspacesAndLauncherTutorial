#!/bin/bash

BASE="https://raw.githubusercontent.com/fabric8-launcher/launcher-openshift-templates/master"
PROPS=$(curl -s $BASE/released.properties)
PARAMS=""

for p in $PROPS; do
    PARAMS="$PARAMS -p $p"
done

echo This script will install the Launcher on OpenShift cluster. Make sure that:
echo 
echo  - You have run oc login previously
echo  - Your GitHub Username is correct [found from git config github.user]: $(git config github.user)
echo  - Your GitHub Token is correct [found from git config github.token]: *REDACTED*
echo 
echo Press ENTER to continue ...
read 

echo Creating launch project ...
oc new-project launch

echo Processing the template and installing ...
oc process --local -f $BASE/openshift/launcher-template.yaml \
    LAUNCHER_KEYCLOAK_URL= \
    LAUNCHER_KEYCLOAK_REALM= \
    LAUNCHER_MISSIONCONTROL_GITHUB_USERNAME=$(git config github.user) \
    LAUNCHER_MISSIONCONTROL_GITHUB_TOKEN=$(git config github.token) \
    LAUNCHER_MISSIONCONTROL_OPENSHIFT_CONSOLE_URL=https://$(oc config current-context| cut -d/ -f2) \
   $PARAMS -o yaml | oc create -f -

echo Enabling Launcher Creator
oc set env dc/launcher-frontend LAUNCHER_CREATOR_ENABLED=true

echo All set! Enjoy!

