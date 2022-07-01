<p align="center">
  <a href="#">
    
  </a>
  <p align="center">
   <img width="125" height="125" src="https://github.com/safedotme/.github/blob/main/profile/logo.png?raw=true" alt="Logo">
  </p>
  <h1 align="center"><b>Safe</b></h1>
  <p align="center">
  A powerful tool for personal and community safety.
    <br />
    <a href="https://joinsafe.me"><strong>joinsafe.me »</strong></a>
    <br />
    <br />
    <b>Available for </b>
    iOS & Android
    <br />
    <i>~ Links will be added once a release is available. ~</i>
  </p>
</p>
Safe is an open source mobile platorm to discretely capture incidents with ease, powered by a multithreaded compression engine (<a href="#infrastructure">SMCE</a>) for sharded databases written in native Swift and Kotlin.
<br/>
<br/>

> NOTE: Safe is under active development, most of the listed features are still in testing and could be altered.

With the press of a button, begin to record your front camera, upload the footage to the cloud real-time, track your exact location, notify your emergency contacts through SMS and Whatsapp, and alert 911 if necessary. Emergency contacts (*and 911*) will receive a video and location livestream of the incident while also getting access to key information such as realtime updates of your battery life.

<p align="center">
  <img src="https://github.com/safedotme/.github/blob/main/profile/banner.png?raw=true" alt="Banner">
  <br />
  <br />
  <a href="https://discord.gg/WZrjydnM">
    <img src="https://img.shields.io/discord/992215371442552913?color=%235865F2&label=Discord" />
  </a>
  <a href="https://twitter.com/safedotme">
    <img src="https://img.shields.io/badge/Twitter-00acee?logo=twitter&logoColor=white" />
  </a>
  <a href="https://github.com/safedotme/safe/blob/main/LICENSE">
  <img src="https://img.shields.io/static/v1?label=Licence&message=GNU%20v3&color=000" />
  </a>
  <img src="https://img.shields.io/static/v1?label=Stage&message=Alpha&color=2BB4AB" />
  <br />
</p>

# Motivation

From the start, Safe was designed for the fragile situations where one's safety is the first, and most critical priority. For students, it acts as a necessary tool for alerting authorities of your wearabouts during a school shooting. For people of color, it's a discrete and all-encompassing documentation tool in the case of a traffic stop. **Broadly, it seeks to expose injustice in any form it may present itself.**

On a more personal note, I {[Mark Music](https://twitter.com/markmusic27)} have been devastated by the news of countless school shootings and instances of police brutality in the US. As a 17-year-old latino, gun violence (through school shootings) and other forms of physical discrimination pose a threat to me, my friends, and my family. **Safe was built no one has to succumb to the status quo.**

# Infrastructure

An SMCE (multithreaded compression engine for sharded databases) is an agorithm designed to take realtime camera footage, cut it into digestable clips, and compress said clips across a variety of threads. These clips (shards) are then distributed across multiple storage layers; making it harder for a possible attacker to obtain a complete file. By processing the footage concurrently, the video is compressed, transcoded, and uploaded as the camera records in realtime. To compose the shards together, a map is stored with and ordered list of the paths to each shard. Concurrency also enables for smartphone CPUs to be used optimally by spawning isolates based on the thread availability. This enables for faster compression times in more powerful smartphones.

> NOTE: The compression engine does not utilize FFMPEG as it is in many ways slow, bloated, and the GNU license can become an obstacle for commercial apps.

The `SMCE` algorithm was inspired by this Stanford [paper](http://cva.stanford.edu/people/milad/accelerator_multithreading.pdf) titled "*Accelerator Multi-Threading*" (2012) by Nic McDonald, Subhasis Das, and Milad Mohammadi.

### **Diagram of Safe's `SMCE` implementation:**



<img src="https://github.com/safedotme/.github/blob/main/profile/diagram.png?raw=true">

# Features

_Note: Links are for highlight purposes only until feature specific documentation is complete._

**Complete:** _(in testing)_

- **[File discovery](#features)** - Scan devices, drives and cloud accounts to build a directory of all files with metadata.
- **[Preview generation](#features)** - Auto generate lower resolution stand-ins for image and video.
- **[Statistics](#features)** - Total capacity, index size, preview media size, free space etc.

**In progress:**

- **[File Explorer](#features)** - Browse online/offline storage locations, view files with metadata, perform basic CRUD.
- **[Realtime synchronization](#features)** - Data index synchronized in realtime between devices, prioritizing peer-to-peer LAN connections (WiFi sync).

**To be developed (MVP):**

- **[Photos](#features)** - Photo and video albums similar to Apple/Google photos.
- **[Search](#features)** - Deep search into your filesystem with a keybind, including offline locations.
- **[Tags](#features)** - Define routines on custom tags to automate workflows, easily tag files individually, in bulk and automatically via rules.
- **[Extensions](#features)** - Build tools on top of Spacedrive, extend functionality and integrate third party services. Extension directory on [spacedrive.com/extensions](#features).

**To be developed (Post-MVP):**

- **[Cloud integration](#features)** - Index & backup to Apple Photos, Google Drive, Dropbox, OneDrive & Mega + easy API for the community to add more.
- **[Encrypted vault(s)](#features)** - Effortlessly manage & encrypt sensitive files, built on top of VeraCrypt. Encrypt individual files or create flexible-size vaults.
- **[Key manager](#features)** - View, mount, dismount and hide keys. Mounted keys automatically unlock respective areas of your filesystem.
- **[Redundancy Goal](#features)** - Ensure a specific amount of copies exist for your important data, discover at-risk files and monitor device/drive health.
- **[Timeline](#features)** - View a linear timeline of content, travel to any time and see media represented visually.
- **[Media encoder](#features)** - Encode video and audio into various formats, use Tags to automate. Built with FFMPEG.
- **[Workers](#features)** - Utilize the compute power of your devices in unison to encode and perform tasks at increased speeds.
- **[Spacedrive Cloud](#features)** - We'll host an always-on cloud device for you, with pay-as-you-go plans for storage.
- **[Self hosted](#features)** - Spacedrive can be deployed as a service, behaving as just another device powering your personal cloud.

# App Structure & Format

The Safe application houses most of its actual code in the `lib` directory. This includes all of the Dart / Flutter code such as screens and utils. The iOS (`ios/Runner`) and Android (`android/app`) folders both house the native components of the compression algorithm. These are connected to the flutter code through a bridge implemented in the `lib` folder.

Anything outside of the `lib`, `ios`, and `android` directory is generic files that come with every program, such as `pubspec.yaml`, `.gitignore`, the `README.md`, etc.

The Safe folder structure can be visualized in the following way:

```
| -lib
|   | -models
|   | -providers
|   | -services
|   | -core
|   | -state
|   | -screens
|   | -utils
|   | -widgets
|   | -main.dart
| -pubspec.yaml
| -.gitignore
| -.firebaserc
| -ios
| -android
| -LICENSE
| -README.md
| -other files
```

# Developer Guide

Please refer to the [contributing guide](CONTRIBUTING.md) for how to install Safe from sources.

# Contributors

|Contributor|Commits| Tags |
|-----|-----|-----|
|**[@markmusic27](https://twitter.com/markmusic27)**|55|Founder|
