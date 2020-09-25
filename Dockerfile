FROM beevelop/cordova:latest
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget unzip
RUN wget https://services.gradle.org/distributions/gradle-6.4.1-bin.zip -P /tmp \
    && unzip -d /opt/gradle /tmp/gradle-*.zip
ENV GRADLE_HOME=/opt/gradle/gradle-6.4.1 
ENV PATH=${GRADLE_HOME}/bin:${PATH}
RUN buildDeps='software-properties-common'; \
  set -x && \
  apt-get update && apt-get install -y $buildDeps --no-install-recommends && \
  add-apt-repository ppa:openjdk-r/ppa -y && \
  apt-get update -y && \
  apt-get install -y openjdk-8-jdk && \
  java -version && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  apt-get purge -y --auto-remove $buildDeps && \
  apt-get autoremove -y && apt-get clean
RUN apt-get update && apt-get install -y curl

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64