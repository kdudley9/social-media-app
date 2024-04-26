# MINGL

## Overview
This is a simple social media app created using Flutter and Firebase. It allows users to register an account, create posts, edit their profile, and view a feed of posts from other users.

## Tech Stack
- **Flutter**: A UI software development kit used for developing cross platform applications. For this project, we have used Flutter to create an Android app.
- **Firebase**: An app development platform provided by Google. It offers a wide range of services, including authentication, real-time database (Firestore), and cloud storage, hosting, and more.
- **FlutterFire**: The official set of Flutter plugins for Firebase. It provides easy-to-use APIs for integrating Firebase services into Flutter apps. We use FlutterFire plugins to connect the Flutter app to Firebase services like Authentication, Firestore, and Cloud Storage. 

## Features
- User Authentication: Users can sign up with email and password, log in to their accounts, and reset their passwords if needed.
- Profile Management: Users can edit their profile details including username, bio, and profile photo.
- Feed: Users can view a feed of posts from other users, sorted by timestamp.

## Getting Started
To run this app locally, follow these steps:
1. Clone this repository to your local machine.
2. Run `flutter pub get` to install the dependencies
3. Configure Firebase for your project by running `flutterfire configure` in your project directory.
4. Run the app using `flutter run`

## Directory Structure
- `lib`: Contains the Dart code for the app.
  - `components`: Contains reusable UI widgets.
  - `exception_handlers`: Contains exception handlers for registration.
  - `pages`: Contains the UI screens of the app.
  - `providers`: Contains providers for profile updates.
  - `services`: Contains classes for interacting with the Firebase services.
  - `shared_assets`: Contains images and themes that are shared throughout the application.
