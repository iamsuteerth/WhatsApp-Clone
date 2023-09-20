# WhatsApp Clone

### As I am building the app, as per progress, snapshots of different app development stages are present in appropriately named branches.
### A Project TimeStamp Log will be present throughout and can be used to give you a jist of what I did and WHEN I did

## Project Time STAMP LOG
| Day        | Total Time (Min) | Comments                                                                                                                                                                 | Session No. |
|------------|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| 18-09-2023 | 83               | Made the basic UI and setup the base design. Can be found in ui_build branch.                                                                                            | 1           |
| 19-09-2023 | 62               | Setup FireBase, Created Landing Screen and designed CustomButton and ErrorScreen (Basic Scaffold)                                                                        | 1           |
| 20-09-2023 | 82               | Create Login Screen with Country Picker and setup Named Routes in main.dart and create a router by the name router.dart                                                  | 1           |
| 20-09-2023 | 36               | Created AuthRepository(Phone Login), OTP Screen foundation led up, Updated router.dart for OTPScreen to get verificationId as argument. Created utils.dart with Snackbar | 2           |
| 20-09-2023 | 38               | Configured AuthController Provider and AuthRepositoryProvider and modified main.dart. Setup Business login in sendPhoneNumber() using ref.read()                         | 3           |
| 20-09-2023 | 85               | Added SHA - 1 fingerprint on firebase console. Created OTP Screen and added OTP business logic and verification WORKS! Added route, modified auth repo and controller.   | 4           |

Features folder will contain features like auth, call, chat, group, contact selecting, status etc.
    Auth will have login screen, OTP screen and user information screen
    Repository will have code to firestore and firebase authentication console (Backend stuff)
    Controller will get data from screens and it will do input formatting and then sending data to repository
Common folder will contain enums, repositories containing API to FireBase, utility files, Providers etc.

We have used Elevated Button styling in lib\common\widgets\custom_button.dart where we did
```dart
    ElevatedButton(
        onPressed: onPressedFunction,
        child: Text(
            text,
            style: const TextStyle(
            color: blackThemeColor,
            ),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: tabColor, minimumSize: Size(double.infinity, height)),
        );
```

in lib\features\auth\screens\login_screen.dart 
We are creating a stateful widget because we will use textInputControllers

# Named Routes 
Since the application can get quite big, we will be using NAMED routes and then we can add our own features too
```dart
// The code is present in router.dart
Navigator.of(context).pushNamed(LoginScreen.routeName);
```

## Pick Country
country_picker

## Setting up Phone Auth
In router.dart, we create
```dart
final verificationId = routeSettings.arguments as String; 
```
UI <- State <- Repository
UI -> Controller -> Repository
Controller -> State

## Dependency Injection
Technique which will make the class. For example, AuthRepository class gets instances from the contructors.

We created an authRepositoryProvider for AuthController

And we placed it on "watch" for the authControllerProvider which we than use in login screen through ref linking the controller and repository and UI as per the graph 

In order to spare people a lot of pain, this is the E.164 phone number example in code
```dart
// String interpolation 
'+${country!.phoneCode}$phoneNumber'
```
### YOU MUST ADD SHA - 1 FINGERPRINT KEY TO FIREBASE CONSOLE