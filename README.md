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
Safe is an open source mobile platorm to discretely capture incidents with ease, powered by a multithreaded compression engine for sharded databases written in native Swift and Kotlin.
<br/>
<br/>

> NOTE: Safe is under active development, most of the listed features are still experimental and subject to change.

With the press of a button, begin to record your front camera, upload the footage to the cloud real-time, track your exact location, notify your emergency contacts through SMS and Whatsapp, and alert 911 if necessary. Emergency contacts (*and 911*) will receive a video and location livestream of the incident while also getting access to key information such as realtime updates of your battery life.

<p align="center">
  <img src="https://raw.githubusercontent.com/spacedriveapp/.github/main/profile/app.png" alt="Logo">
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

On a more personal note, I {[Mark Music](https://twitter.com/markmusic27)} have been devastated by the news of countless school shootings and instances of police brutality. As a 17-year-old latino, gun violence (through school shootings) and other forms of physical discrimination pose a threat to me, my friends, and my family. **Safe was built no one has to succumb to the status quo.**

# Infrastructure

A VDFS (virtual distributed filesystem) is a filesystem designed to work across a variety of storage layers. With a uniform API to manipulate and access content across many devices, VSFS is not restricted to a single machine. It achieves this by maintaining a virtual index of all storage locations, synchronizing the database between clients in realtime. This implementation also uses [CAS](https://en.wikipedia.org/wiki/Content-addressable_storage) (Content-addressable storage) to uniquely identify files, while keeping record of logical file paths relative to the storage locations.

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

# Developer Guide

Please refer to the [contributing guide](CONTRIBUTING.md) for how to install Spacedrive from sources.

# Architecture

This project is using what I'm calling the **"PRRTT"** stack (Prisma, Rust, React, TypeScript, Tauri).

- Prisma on the front-end? 🤯 Made possible thanks to [prisma-client-rust](https://github.com/brendonovich/prisma-client-rust), developed by [Brendonovich](https://github.com/brendonovich). Gives us access to the powerful migration CLI in development, along with the Prisma syntax for our schema. The application bundles with the Prisma query engine and codegen for a beautiful Rust API. Our lightweight migration runner is custom built for a desktop app context.
- Tauri allows us to create a pure Rust native OS webview, without the overhead of your average Electron app. This brings the bundle size and average memory usage down dramatically. It also contributes to a more native feel, especially on macOS due to Safari's close integration with the OS.
- The core (`sdcore`) is written in pure Rust.

## App Structure & Format

### ❤️ Built in Honor of
