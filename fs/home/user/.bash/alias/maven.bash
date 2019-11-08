#!/bin/bash

#alias mvn='mvn -U'
alias mvntestall='mvn -Dtest.excludes=none'
alias mvntestnone='mvn -Dmaven.test.skip.exec=true'
alias mvndownloadall='mvn dependency:sources dependency:resolve -Dclassifier=javadoc'
#alias mvnrelease='mvn release:clean release:prepare release:perform -Darguments="-Dmaven.test.skip=true"'
#alias mvndeploy='mvn -Dmaven.test.skip=true clean install source:jar javadoc:jar deploy'
#alias mvnsnapshot='mvn clean install source:jar javadoc:jar site:attach-descriptor site:site site:jar'
#alias mvnsnapshotdeploy='mvn clean install source:jar javadoc:jar site:attach-descriptor site:site site:jar site:deploy deploy'
alias mvnsite='mvn site:attach-descriptor site:site site:jar'
#alias mvnsitedeploy='mvn site:deploy'

alias mvn31='~/opt/maven/3.1/bin/mvn'

