FROM jenkins/jenkins:lts

USER root
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/plugins.txt

COPY ref/ /usr/share/jenkins/ref/

USER jenkins

