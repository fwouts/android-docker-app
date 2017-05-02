FROM gradle:3.5-jdk8

# Set up the environment for non-root "gradle" user.
USER root
RUN apt-get update &&\
	  apt-get install -y lib32z1 lib32stdc++6 &&\
	  mkdir /opt/android && chown gradle:gradle /opt/android/
USER gradle

# Download the Android SDK tools and accept the license.
ENV ANDROID_HOME /opt/android/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O android-sdk.zip &&\
	  mkdir $ANDROID_HOME &&\
	  unzip android-sdk.zip -d $ANDROID_HOME &&\
	  rm android-sdk.zip &&\
	  mkdir $ANDROID_HOME/licenses &&\
	  echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > $ANDROID_HOME/licenses/android-sdk-license

# Copy the Android app project.
USER root
COPY . /usr/local/android-app/
WORKDIR /usr/local/android-app/
RUN chown gradle:gradle -R /usr/local/android-app/
USER gradle

# Build the app when run.
ENTRYPOINT gradle assembleDebug && cp app/build/outputs/apk/app-debug.apk /apk-output/app-debug.apk
