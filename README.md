# Evently – Flutter App

**Evently** is a Flutter-based Todo & Event Management application that allows users to create, manage, and organize events efficiently. The app supports multiple languages and provides a responsive UI with dark and light themes.

---

## Table of Contents

1. [App Flow](#app-flow)  
2. [Features](#features)  
3. [Technologies & Tools](#technologies--tools)  
4. [Map & Location Features](#map--location-features)  
5. [Project Links & Resources](#project-links--resources)  

---

## App Flow

1. **Splash Screen:** Shows the app logo and initializes app settings.  
2. **Authentication:** Users can sign up, log in, or log out using Firebase Authentication.  
3. **Home Screen:** Displays a list of events created by the user.  
4. **Create Event:** Users can add a new event with title, description, date, time, category, and location (using Google Maps).  
5. **Event Details:** View detailed information about an event.  
6. **Update Event:** Users can edit event information.  
7. **Delete Event:** Users can remove an event.  
8. **User Profile:** Manage profile image (stored via Cloudinary) and personal settings.  
9. **Settings & Preferences:** Manage app settings (dark/light theme, language, etc.) stored locally using Shared Preferences Helper.  

---

## Features

- **Multi-language Support:** Arabic and English.  
- **Themes:** Dark and light themes.  
- **Responsive UI:** Adaptive layouts using Screen Utils.  
- **Event Management:** Create, update, delete, and view events.  
- **Location Picker:** Search and select event locations on a map.  
- **Architecture & State Management:** Follows Clean Architecture with MVVM; uses Cubit and Provider for state management.  
- **Cloud Storage:** Profile images stored via Cloudinary using Dio.  
- **Notifications:** Optional event notifications.

---

## Map & Location Features

Evently provides an enhanced location experience through an interactive map screen:

- **Search for Places:** Users can search for any place using the **OpenStreetMap Nominatim API**.  
- **API Requests with Dio:** Place search suggestions are retrieved using the powerful **Dio HTTP client**.  
- **Select Event Location:** The chosen place is saved as the event’s location and displayed on Google Maps with a marker.  
- **Smooth User Experience:** Search results appear in a dropdown card for easy selection.  

---

## Technologies & Tools

- Flutter  
- Firebase (Authentication & Firestore)  
- Cloudinary (Profile Image Upload using Dio)  
- Google Maps API  
- OpenStreetMap Nominatim API (Place Search using Dio)  
- Dio Package (Networking & API Requests)  
- Provider & Cubit (State Management)  
- MVVM & Clean Architecture  
- Screen Utils (Responsive UI)  
- Shared Preferences  

---

## Project Links & Resources

- [Firebase Project](https://console.firebase.google.com/project/evently-2d1c7/overview)  
- [Figma Design](https://www.figma.com/design/YmDiRILnGg2sAoVcll7ZEb/Event-Planning-App?node-id=0-1&t=liNf2Ms2NyM6dMtu-1)  
- [Google Maps Flutter Plugin](https://pub.dev/packages/google_maps_flutter)  

---

## Notes

- Evently uses **Clean Architecture** to separate UI, business logic, and data layers.  
- All state is managed using **Cubit** and **Provider** for reactive UI updates.  
- Both **Cloudinary uploads** and **OpenStreetMap place search** are implemented using **Dio** for efficient networking.  
- OpenStreetMap Nominatim API allows location search without needing Google Places API keys.  

---
