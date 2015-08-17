FROM java:openjdk-7-jdk

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Install Git
RUN apt-get update && apt-get install -y git

# Install Maven
RUN \
  wget -nv http://apache-mirror.rbc.ru/pub/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz && \
  tar -xzf apache-maven-3.3.3-bin.tar.gz -C /usr/local && rm apache-maven-3.3.3-bin.tar.gz && \
  ln -s /usr/local/apache-maven-3.3.3/bin/mvn /usr/local/bin/mvn

# Checkout, Build & Install LocationParser
RUN \
  git clone https://github.com/tartakynov/locationparser.git && \
  cd locationparser && \
  mvn package && \
  cd target && \
  tar -xzf locationparser-*.tar.gz -C /usr/local && \
  ln -s /usr/local/locationparser/bin/run /usr/local/bin/locationparser
RUN rm -rf locationparser

# Add bootstrap script
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

