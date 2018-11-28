FROM openjdk:8-jdk

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 zipalign
RUN mkdir -p /opt/android
WORKDIR /opt/android
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
RUN unzip android-sdk.zip
RUN pwd && ls
WORKDIR /opt/android/tools/bin
RUN ls
RUN yes | ./sdkmanager --licenses || true
RUN ./sdkmanager "build-tools;26.0.2" "platform-tools" "platforms;android-24"
RUN ./sdkmanager --list
RUN export ANDROID_HOME=/opt/android
RUN export PATH=$PATH:/opt/android/tools/bin:/opt/android/platform-tools:/opt/android/build-tools/bin
RUN wget -P /tmp https://services.gradle.org/distributions/gradle-4.7-bin.zip
RUN mkdir -p /opt/gradle && pwd && unzip -d /opt/gradle /tmp/gradle-4.7-bin.zip
RUN export PATH=$PATH:/opt/gradle/gradle-4.7/bin
RUN npm install -g cordova