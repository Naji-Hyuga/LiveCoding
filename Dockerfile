FROM python:3.12-alpine3.19

RUN apk add --no-cache \
      bash curl wget unzip tzdata \
      chromium chromium-chromedriver \
      openjdk17-jre

ENV ALLURE_VERSION=2.29.0
RUN wget -q "https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.zip" \
 && unzip "allure-commandline-${ALLURE_VERSION}.zip" -d /opt \
 && ln -sf "/opt/allure-${ALLURE_VERSION}/bin/allure" /usr/local/bin/allure \
 && rm -f "allure-commandline-${ALLURE_VERSION}.zip"

WORKDIR /usr/workspace

COPY ./requirements.txt /usr/workspace/
RUN pip3 install --no-cache-dir -r requirements.txt

RUN python --version && java -version && allure --version