# Flutter Clean Architecture

A new Flutter Enterprize project structure. If you are interested to build Bigger Application then you can use this application structure.

## Getting Started

This project is a Flutter application building frameworks. This structure to helps you to build a big multi-platform software development process.

First download this project after then you get error from ```features/main_app/providers/news_provider.dart``` this file.

**Screenhots of Application**
| Dark Login Screen |  Light Login Screen |
| ------------------- | ----------------- |
|![Dark Login Screen](./screenshots/Screenshot_1.png)|![Light Login Screen](./screenshots/Screenshot_2.png) |

| Light News Screen |  Dark News Screen |
| ------------------- | ----------------- |
| ![Light News Screen](./screenshots/Screenshot_3.png) | ![Dark News Screen](./screenshots/Screenshot_4.png) |
| --------------- | ------------------- |

### Why it happen?

Config file is missing. So ***rename*** config file from config folder `config/app_config_sample.dart` to `config/app_config.dart`

Here have a news api integrated from `rapidapi.com` apis. So for the first time you need to register on that website. then search ***free news*** api from here and subscribe this api. then goto under ***Header Parameters*** then copy `X-RapidAPI-Key` value and paste this value in `config/app_config.dart` file as a `key` value.

After all this process you can start your project easily in your emmulators or devices. And this project will be working fine.

### Software Building Architecture

This Project Making for focusing to Develop Bigger project.

- Config
- Core
- Features (Modules)

## If you are Beginner in Flutter then Learning about basic concepts

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
