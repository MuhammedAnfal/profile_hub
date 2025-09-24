# User List App

Small Flutter app that fetches users from https://jsonplaceholder.typicode.com/users and displays name + email in a list.

## Features
- Loads users from public API
- Shows loading indicator
- Pull-to-refresh
- Error handling with retry
- Search by name
- Detail screen per user
- animation

## Run locally
1. Install Flutter (stable channel). See https://flutter.dev/docs for instructions.
2. Clone repo:
   git clone <https://github.com/MuhammedAnfal/profile_hub.git>
3. Get packages:
   flutter pub get
4. Run:
   flutter run

## Decisions & assumptions
- State management: Riverpod (for predictable and testable state)
- Simple UI using Material widgets ( RefreshIndicator)
- No persistent storage required (API-only for task scope)
