# About
If you use your device camera to take photos for different context like work and family so this app is for you. 
This app allow you to make shortcuts to different save directories, open the camera and all photos you take in this app will be saved in the selected directory, so you can have you work photos organized and will be easier to find for you.

# Features
- Create directory profiles (shortcuts) to easily change where to save next files.
- Mark the directory with an icon.
- Edit existing directory profiles.
- Remove directory profiles (shortcut only).

# Quick start
You need Flutter SDK installed in you pc.

## Signing
First you need to sign the release app, more info [here](https://docs.flutter.dev/deployment/android#signing-the-apphttp:// "here").
or restore `android/app/build.gradle` file to [this version](http://https://github.com/AndreXi/organized_camera/blob/2611a2e3f7004a3cf154004f09e19aac5a8ee914/android/app/build.gradle "this version").

## Build
This will build an .apk file for all android target platforms.
```bash
flutter build apk --release
```

## Install
With an available android device.
```
flutter install
```
