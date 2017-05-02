# Building an Android app from Docker

## Requirements
- Docker

## How to run
```
export APK_OUTPUT_DIR=~/apk-output
docker build . -t fwouts/android-docker-app
docker run -v $APK_OUTPUT_DIR:/apk-output/ fwouts/android-docker-app
# To install (from the host machine):
adb install -r $APK_OUTPUT_DIR/app-debug.apk
```

## What is this?

This is a technical proof-of-concept that:
- builds a Docker image that contains the source code
- builds the APK (Android package) inside Docker
- copies the generated APK to the host machine

## Why?

Because we can. Also:
- no need to set up Android SDK manually (apart from `adb`)
- no need for Gradle scripts
- complete build reproducibility
- complete build isolation
