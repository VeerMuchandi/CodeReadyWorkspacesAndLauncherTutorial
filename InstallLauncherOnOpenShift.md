## Install Launcher on OpenShift

In this lab, we will be deploying Launcher in single user mode. Eventually an Operator is being created to install launcher in multi-user mode. 

### Prerequisites

* A running OpenShift Cluster
* A workstation with `oc` CLI


### Setup GitHub tokens

Follow the instructions here to add a GitHub Personal Access token
Add a token here [https://github.com/settings/tokens](https://github.com/settings/tokens) 

Instructions: [https://launcher.fabric8.io/docs/minishift-installation.html#creating-a-github-personal-access-token_minishift](https://launcher.fabric8.io/docs/minishift-installation.html#creating-a-github-personal-access-token_minishift) 

### Setup GitHub credentials

Set up GitHub credentils on the workstation from where you are installing

```
git config --global github.user $yourGitHubUsername
git config --global github.token $yourGitHubPersonalAccessToken
```

### Log on to OpenShift

Use `oc login` to log onto your OpenShift cluster

### Install Launcher

Run the following script to install the Launcher. This script will create a project named "Launch" and install launcher based on a template.

**Note :** In the future, this will be replaced by an operator.

```
curl -s https://raw.githubusercontent.com/VeerMuchandi/CodeReadyWorkspacesAndLauncherTutorial/master/launcherInstall.sh | bash
```
and watch for the output as shown below

```
$ curl -s https://raw.githubusercontent.com/VeerMuchandi/CodeReadyWorkspacesAndLauncherTutorial/master/launcherInstall.sh | bash
This script will install the Launcher on OpenShift cluster. Make sure that:

- You have run oc login previously
- Your GitHub Username is correct [found from git config github.user]: VeerMuchandi
- Your GitHub Token is correct [found from git config github.token]: *REDACTED*

Press ENTER to continue ...
Creating launch project ...
Already on project "launch" on server "https://master.311.ocpcloud.com:443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git

to build a new example application in Ruby.
Processing the template and installing ...
configmap "launcher" created
configmap "launcher-clusters" created
deploymentconfig.apps.openshift.io "launcher-backend" created
service "launcher-backend" created
deploymentconfig.apps.openshift.io "launcher-creator-backend" created
service "launcher-creator-backend" created
deploymentconfig.apps.openshift.io "launcher-frontend" created
service "launcher-frontend" created
serviceaccount "configmapcontroller" created
rolebinding.authorization.openshift.io "configmapcontroller" created
deploymentconfig.apps.openshift.io "configmapcontroller" created
route.route.openshift.io "launcher" created
secret "launcher" created
Enabling Launcher Creator
deploymentconfig "launcher-frontend" updated
All set! Enjoy!
```

Wait for a few mins for all the pods to come up.

```
$ oc get po
NAME                               READY     STATUS    RESTARTS   AGE
configmapcontroller-1-7xrrj        1/1       Running   0          2m
launcher-backend-2-26mv2           1/1       Running   0          1m
launcher-creator-backend-2-d5wnr   1/1       Running   0          1m
launcher-frontend-3-bmkmv          1/1       Running   0          2m
```

Check the route for the launcher

```
$ oc get route
NAME       HOST/PORT                               PATH      SERVICES            PORT      TERMINATION   WILDCARD
launcher   launcher-launch.apps.311.ocpcloud.com             launcher-frontend   <all>                   None

```

Test the route to make sure Launcher is running and you see the following screen.

![](./images/1.Launcher.png)
