# Instagram Clone — Flutter App

A full-stack Instagram-style social media mobile application built with **Flutter**, connected to a **NestJS REST API** backend.

The application supports authentication, post creation, image uploads, likes, profiles, paginated feeds, infinite scrolling, and secure token management.

## 📱 Features

* 🔐 User registration and login
* 🔄 JWT access and refresh-token authentication
* 🔒 Secure token storage
* 🖼️ Image post uploads
* 📰 Paginated home feed
* ♾️ Infinite scrolling
* ❤️ Like and unlike posts
* 👤 User profiles
* 📸 User's uploaded posts
* ⚠️ Structured loading, success, and error states
* 🔁 Automatic token refresh
* 🌐 REST API integration

## 🏗️ Architecture

The application follows an MVVM-style architecture with separate ViewModels, repositories, and API services.


UI
 │
 ▼
ViewModel
 │
 ▼
Repository
 │
 ▼
API Service
 │
 ▼
NestJS REST API


### Architecture Responsibilities

**View**

Responsible for displaying the UI and handling user interactions.

**ViewModel**

Manages screen state, API operations, loading states, errors, and user actions.

**Repository**

Acts as the data layer between ViewModels and API services.

**API Service**

Handles HTTP communication with the backend.

**Secure Storage**

Stores authentication tokens securely on the device.

## 🛠️ Tech Stack

### Mobile

* Flutter
* Dart
* MVVM
* Repository Pattern
* Service Layer

### Backend

* NestJS
* TypeScript
* REST APIs
* JWT Authentication
* Refresh Tokens

### Database

* PostgreSQL
* Prisma ORM

### Media Storage

* Cloudinary

### Deployment

* Render

## 🔐 Authentication

The application uses short-lived access tokens together with refresh tokens.


Login
  ↓
Access + Refresh Tokens
  ↓
Secure Storage
  ↓
API Request
  ↓
Access Token Expired
  ↓
Refresh Endpoint
  ↓
New Access Token
  ↓
Retry Original Request


If the refresh token is invalid or expired, the user must authenticate again.

## 📰 Feed & Pagination

The home feed uses pagination instead of requesting every post at once.

As the user approaches the end of the current list, the application requests the next page from the backend.


Page 1
  ↓
User scrolls
  ↓
Page 2
  ↓
User scrolls
  ↓
Page 3
  ↓

This keeps the initial request smaller and allows the feed to load progressively.

## ❤️ Like System

Users can like and unlike posts.

The backend prevents duplicate likes using the user/post relationship.

The mobile application also updates the UI immediately after a successful interaction and rolls back the local change if the API request fails.

## 🖼️ Image Uploads

Post images are uploaded to the backend and stored using **Cloudinary**.

The backend also uses **SHA-256 image hashing** to detect duplicate images before creating a new post.

If the same image has already been uploaded, the backend returns:



This prevents duplicate uploads even when the same image is renamed.

## ⚠️ Error Handling

API responses are handled through structured application-level exceptions.

The application handles scenarios such as:

* Invalid requests
* Unauthorized requests
* Missing resources
* Duplicate resources
* Server errors
* Rate limiting
* Network failures

These errors are converted into appropriate UI states instead of exposing raw API errors directly to the user.

## 📸 Screenshots

Screenshots will be added here.

### Login

![Login](screenshots/login.png)

### Home Feed

![Home Feed](screenshots/home.png)

### Post Upload

![Post Upload](screenshots/upload.png)

### Profile

![Profile](screenshots/profile.png)

## 🎥 Demo

A short screen recording demonstrating the application flow will be added here.

Example:


Register
   ↓
Login
   ↓
Browse Feed
   ↓
Upload Post
   ↓
Like Post
   ↓
Open Profile
   ↓
View User Posts


## 🔗 Backend

This application communicates with the Instagram NestJS backend.

**Backend Repository:**
https://github.com/Prakash777-code/InstagramBackend-

**Live Backend:**
https://instagrambackend-aeed.onrender.com

## 🚀 Getting Started

### Prerequisites

* Flutter SDK
* Android Studio or VS Code
* Android device/emulator
* Running Instagram backend or configured API endpoint

### Installation

Clone the repository:


git clone https://github.com/Prakash777-code/InstagramApp.git


Navigate to the project:

cd InstagramApp


Install dependencies:


flutter pub get


Run the application:


flutter run


## 📁 Project Structure


lib/
├── models/
├── services/
├── repositories/
├── viewmodels/
├── screens/
├── widgets/
└── helpers/


## 📚 What I Worked On

This project provided hands-on experience with:

* Flutter application development
* MVVM architecture
* Repository and service layers
* JWT authentication
* Refresh-token handling
* Secure token storage
* REST API integration
* Pagination and infinite scrolling
* Image uploads
* Cloudinary integration
* Like relationships
* Duplicate image detection
* API error handling
* Optimistic UI updates
* Backend integration
* Mobile application debugging

## 📄 License

This project is created for learning and portfolio purposes.
