# Flutter Login App with Mock API

This Flutter project demonstrates a basic login system integrated with a mock API built using Node.js. The project covers user authentication, retrieval of user information, and secure token-based communication.

---

## Application Credentials

Here are the predefined users for testing the application:

- **User**:
    - Email: `user@esgi.fr`
    - Password: `userpass`

- **Admin**:
    - Email: `admin@esgi.fr`
    - Password: `adminpass`

---

## Features

- **Login Screen**: Users can log in using their credentials.
- **Profile Screen**: Displays user information after successful login.
- **Password Hashing**: Passwords are hashed using SHA-256 before being sent to the server.
- **Dynamic API Configuration**: Handles different environments (Web, Android, iOS) with dynamic URL selection.
- **JWT Authentication**: Secured communication using JSON Web Tokens.

---

## Application wireframe

Placeholders for images of the application will be added here later to demonstrate the UI and functionality.
![main screen](https://drive.google.com/u/0/drive-viewer/AKGpihY4Ba2Ye97U0eraE_SNReWfEZQnHZqFZEb53-UPaweU2QmhQunLa-c-b_coohtkdr-YhEkVXPCyeddR9YhSTOFTZc0NyR6AmA=s2560)

![main screen](https://drive.google.com/file/d/1gntpt3sY9Gi3rRdB66hRhaiAkBH3WxxN/view)

---

## Explanation of `AuthService` Class

The `AuthService` class is responsible for dynamically configuring the base URL of the API depending on the platform on which the Flutter app is running. This ensures the app works seamlessly across different environments, such as web browsers, Android emulators, and iOS simulators.

### Code
```dart
class AuthService {
  final String _baseUrl;

  AuthService() : _baseUrl = AuthService.getBaseUrl();

  static String getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    } else if (Platform.isIOS) {
      return 'http://localhost:3000';
    } else {
      return 'http://localhost:3000';
    }
  }
}
```

### Explanation

1. **`_baseUrl` Property**:
    - This is a private, final property that stores the base URL for API calls.
    - It is initialized using the `getBaseUrl` static method when an instance of `AuthService` is created.

2. **`getBaseUrl` Method**:
    - This method determines the appropriate base URL depending on the platform:
        - **Web (`kIsWeb`)**: Uses `http://localhost:3000` since it runs in a browser.
        - **Android**: Uses `http://10.0.2.2:3000`, a special address for the host machine accessible from an Android emulator.
        - **iOS**: Uses `http://localhost:3000`, as iOS simulators can directly access the host machine using `localhost`.
        - **Fallback**: Defaults to `http://localhost:3000` for any other platforms.

3. **Special Case for Android Emulator**:
    - The Android emulator cannot directly access `localhost` on the host machine. Instead, `10.0.2.2` is a reserved address that redirects requests to the host's `localhost`.

This setup ensures the app dynamically adjusts to the environment, enabling seamless testing and deployment.
