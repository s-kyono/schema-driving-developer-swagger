# Base Images Node v22
FROM node:22-slim

RUN apt-get update && apt-get upgrade && \
  apt-get install -y \
  lsb-release \
  locales \
  tzdata \
  wget \
  curl \
  unzip && \
  rm -fr /var/lib/apt/lists/* && \
  apt-get clean && rm -fr /var/lib/apt/lists/*

# Settin location
RUN locale-gen ja_JP.UTF-8

ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
ENV GRADLE_VERSION=8.3

# OpenJDK21
RUN wget https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz && \
  mkdir /usr/local/jdk-21 && \
  tar -xvf openjdk-21.0.2_linux-x64_bin.tar.gz -C /usr/local/jdk-21 --strip-components=1 && \
  ln -s /usr/local/jdk-21/bin/java /usr/bin/java && \
  ln -s /usr/local/jdk-21/bin/javac /usr/bin/javac && \
  ln -s /usr/local/jdk-21/bin/jshell /usr/bin/jshell && \
  rm openjdk-21.0.2_linux-x64_bin.tar.gz

RUN export JAVA_HOME=/usr/local/jdk-21 && export PATH=$JAVA_HOME/bin:$PATH

# Gradle Install
RUN curl -sL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
  unzip gradle.zip && \
  mv gradle-${GRADLE_VERSION} /opt/gradle && \
  rm gradle.zip

# Gradle Path
ENV PATH=/opt/gradle/bin:$PATH

# イメージ情報を表示
RUN gradle -v

RUN npm install -g  @stoplight/prism-cli @openapitools/openapi-generator-cli

# 作業ディレクトリ設定
WORKDIR /workspace

# コンテナが起動したときにPrismモックサーバを起動
CMD ["prism", "mock", "/workspace/open-api.yml", "-h", "0.0.0.0"]
