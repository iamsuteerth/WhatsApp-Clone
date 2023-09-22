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
| 21-09-2023 | 105              | Added ImagePicker, Created FBSRepo, wrote a method in AuthRepo, setup firestore methods, created UserModel and UserInfoScreen and created sendingToDB methods.           | 1           |
| 22-09-2023 | 168              | Added persistent auth, created github content, added loaders, debugged app, started working on contacts.                                                                 | 1           |

#
> Features folder will contain features like auth, call, chat, group, contact selecting, status etc.

> Auth will have login screen, OTP screen and user information screen

> Repository will have code to firestore and firebase authentication console (Backend stuff)

> Controller will get data from screens and it will do input formatting and then sending data to repository

> Common folder will contain enums, repositories containing API to FireBase, utility files, Providers etc.

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

## ImagePicker
I created a separate firebase storage repository file in commons folder because it will be used for pretty much everything the user sends.

## Why this Repository and Controller approach

`Simply put, the app is quite complex, and if I have to add features later on, even I need to understand what I've done haha. This readme servers that purpose and also make my life as the developer easier.`

> I added a ProvideRef in the auth controller constructor because the saveUserDataToFirebase() funciton will be used in a widget which returns a widget ref.

> The main takeaway is that the repository contains the main "repository" with our intended functions and has a global provider which is linked to the controller as these are all having global scope.

> We are performing the watch function in auth controller provider where we create a provider for the controller which can be used in the app globally.

> These repository functions are called through the controller.

## Persisting State

AuthController is not used, instead a FutureProvider is used to access as it gives easier options instead of using a future builder and then handling the errors.

`In main.dart`
```dart
ref.watch(userDataAuthProvider).when(data: data, error: error, loading: loading),
```
This function is only available when we use a FutureProvider instead of a Provider.