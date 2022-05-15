# Flutter Clean Architecture

A new Flutter Enterprize project structure. If you are interested to build Bigger Application then you can use this application structure.

**Screenhots of Application**
| Application Boilerplate or Structure |
| --------------------- |
| ![Application Structure](./screenshots/application_structure.png) |

## Getting Started

This project is a Flutter application building frameworks. This structure to helps you to build a big multi-platform software development process.

First download this project after then you get error from ```features/main_app/providers/news_provider.dart``` this file.

### Why it happen?

Config file is missing. So ***rename*** config file from config folder `config/app_config_sample.dart` to `config/app_config.dart`
![Configuration File Rename](./screenshots/Configuration_file_rename.png)

Here have a news api integrated from `rapidapi.com` apis. So for the first time you need to register on that website. then search ***free news*** api from here and subscribe this api. then goto under ***Header Parameters*** then copy `X-RapidAPI-Key` value and paste this value in `config/app_config.dart` file as a `key` value.

**Find API Key**
![Access Web API Key](./screenshots/Access_Web_API_Key.png)

**Use API Key**
![Use API Key](./screenshots/Use_API_KEY.png)

After all this process you can start your project easily in your emmulators or devices. And this project will be working fine.

### Software Building Architecture

This Project Making for focusing to Develop Bigger project.

- Config
- Core
- Features (Modules)

### Application Screenshots Overview
| Dark Login Screen |  Light Login Screen |
| ------------------- | ----------------- |
|![Dark Login Screen](./screenshots/Screenshot_1.png)|![Light Login Screen](./screenshots/Screenshot_2.png) |

| Light News Screen |  Dark News Screen |
| ------------------- | ----------------- |
| ![Light News Screen](./screenshots/Screenshot_3.png) | ![Dark News Screen](./screenshots/Screenshot_4.png) |

| Light Register Screen |  Dark Register Screen |
| ------------------- | ----------------- |
| ![Light Register Screen](./screenshots/Screenshot_5.png) | ![Dark Register Screen](./screenshots/Screenshot_6.png) |

| Dark Profile Screen |  Light Profile Screen |
| ------------------- | ----------------- |
| ![Dark Profile Screen](./screenshots/Screenshot_7.png) | ![Light Profile Screen](./screenshots/Screenshot_8.png) |

| Light Forget Screen |  Dark Forget Screen |
| ------------------- | ----------------- |
| ![Light Forget Screen](./screenshots/Screenshot_9.png) | ![Dark Register Screen](./screenshots/Screenshot_10.png) |

## If you are Beginner in Flutter then Learning about basic concepts

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
