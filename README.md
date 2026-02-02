# Evently – Flutter App

**Evently** is a Flutter-based Todo & Event Management application that allows users to create, manage, and organize events efficiently. The app supports multiple languages and provides a responsive UI with dark and light themes.

## App Flow

1. **Splash Screen:** Shows app logo and initializes app settings.  
2. **Authentication:** Users can sign up, log in, or log out using Firebase Authentication.  
3. **Home Screen:** Displays a list of events created by the user.  
4. **Create Event:** Users can add a new event with title, description, date, time, category, and location (using Google Maps).  
5. **Event Details:** View detailed information about an event.  
6. **Update Event:** Users can edit event information.  
7. **Delete Event:** Users can remove an event.  
8. **User Profile:** Manage profile image (stored via Cloudinary) and personal settings.  
9. **Settings & Preferences:** Manage app settings (dark/light theme, language, etc.) stored locally using Shared Preferences Helper.  

## Features

- **Multi-language Support:** Arabic and English.  
- **Themes:** Dark and light themes.  
- **Responsive UI:** Adaptive layouts using Screen Utils.  
- **Architecture & State Management:** Follows Clean Architecture with MVVM; uses Cubit and Provider for state management.  

## Technologies & Tools

- Flutter  
- Firebase (Authentication & Firestore)  
- Cloudinary (for user images)  
- Google Maps API  
- Provider & Cubit (State Management)  
- MVVM & Clean Architecture  
- Screen Utils (Responsive UI)  
- Shared Preferences  

## Links / Resources

- [Firebase Project](https://console.firebase.google.com/project/evently-2d1c7/overview)  
- [Figma Design](https://www.figma.com/design/YmDiRILnGg2sAoVcll7ZEb/Event-Planning-App?node-id=0-1&t=liNf2Ms2NyM6dMtu-1)
- [Google Maps Flutter Plugin](https://pub.dev/packages/google_maps_flutter)  
