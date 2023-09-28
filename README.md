# WhatsApp Clone

### As I am building the app, as per progress, snapshots of different app development stages are present in appropriately named branches.
### A Project TimeStamp Log will be present throughout and can be used to give you a jist of what I did and WHEN I did

## Project Time STAMP LOG

| Day        | Total Time (Min) | Comments                                                                                                                                                                                                      | Session No. |
|------------|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| 18-09-2023 | 83               | Made the basic UI and setup the base design. Can be found in ui_build branch.                                                                                                                                 | 1           |
| 19-09-2023 | 62               | Setup FireBase, Created Landing Screen and designed CustomButton and ErrorScreen (Basic Scaffold)                                                                                                             | 1           |
| 20-09-2023 | 82               | Create Login Screen with Country Picker and setup Named Routes in main.dart and create a router by the name router.dart                                                                                       | 1           |
| 20-09-2023 | 36               | Created AuthRepository(Phone Login), OTP Screen foundation led up, Updated router.dart for OTPScreen to get verificationId as argument. Created utils.dart with Snackbar                                      | 2           |
| 20-09-2023 | 38               | Configured AuthController Provider and AuthRepositoryProvider and modified main.dart. Setup Business login in sendPhoneNumber() using ref.read()                                                              | 3           |
| 20-09-2023 | 85               | Added SHA - 1 fingerprint on firebase console. Created OTP Screen and added OTP business logic and verification WORKS! Added route, modified auth repo and controller.                                        | 4           |
| 21-09-2023 | 105              | Added ImagePicker, Created FBSRepo, wrote a method in AuthRepo, setup firestore methods, created UserModel and UserInfoScreen and created sendingToDB methods.                                                | 1           |
| 22-09-2023 | 168              | Added persistent auth, created github content, added loaders, debugged app, started working on contacts.                                                                                                      | 1           |
| 23-09-2023 | 82               | Added contacts screen, binded and added route, created provider and controller for selecting contacts.                                                                                                        | 1           |
| 26-09-2023 | 35               | Added selectContact() method, onTap() functionality to the contact list, singeChildScroolView on login screen.                                                                                                | 1           |
| 26-09-2023 | 38               | Did some real phone testing, added navigator argument functionality, updated router.dart and added dynamic name generation from contact list                                                                  | 2           |
| 27-09-2023 | 83               | Added online/offline status using streambuilder, modified chat text field on chat screen, created BottomChatField stateful widget and debugged app. <Note> Name broken if chat accessed from main chat screen | 1           |
| 27-09-2023 | 112              | Message sending feature added from backend side along with last seen functionality.                                                                                                                           | 2           |
| 28-09-2023 | 78               | Tediously long process of using stream builders for chat screen and contact page. Not Debugged properly                                                                                                       | 1           |
| 28-09-2023 | 81               | Debugged everything (issue was that contactId was being passed phoneNumber) and got the app working with real time chatting functionality                                                                     | 2           |
| 28-09-2023 | 23               | Added online/offline status using WidgetsBindingObserver. Added cases for didChangeAppLifecycleState, added initState and dispose in MobileScreenLayout.                                                      | 3           |

<br>

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

## Contacts
I need to add flutter_contacts for this to work and then resolve the permission issues by modifying the `plist` and `manifest` files for ios and android.

It is important for the contacts saved to have the country code.

I will add some functionality here asking the user if they want to proceed with default country code but that will come later. Until then, add the country code in contact list.

## On Off Status
I will need to setup a stream for this feature to work which I do so in a function in Auth Repo.

ref.read() is usually used when we need to call a method

I converted the bottom chat textfield to a stateful separate widget because a LOT of things will happen there which will require state to get changed and updating the entire chat screen doesn't make sense for that.

## Sending Messages
users -> sender_id -> receiver_id -> messages -> message_id -> message stored

Use stream builder to display LAST sent message on chat screen

This will be stored in contact chat sub collection

users -> receiver uid -> chats ->current user id -> set data for the receiver (in chat list)

users -> current uid -> chats -> receiver user id -> set data for the sender (in chat list)

Refer to message_enum.dart for info on enhanced enums and extensions

Refer to chat_repository for linking both the streams of sender and user

Now what is happening is that as we send textMessages from either end, the lastMessage get's updated.

## On contact screen
I created a function in the chat repo which returns a stream of list type and then used this stream in stream builder for the mobile chat screen widget.

Testing the live chat functionality took a lot of time to debug as there were small errors which were not easily visible

## How to add auto scrolling?
1. Create a ScrollController

2. Use this snippet in the build function

```dart
SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
```

3. Attach the controller

## Online Offline status
I will decide this if user opens app and reaches home screen or not. For which I will be using WidgetsBindingObserver using with keyword on stateful widget

This method is implemented
```dart
void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }
```
Where cases have to be defined and each case has its method

auth repository needs to get a function to UPDATE

This is how to initialize it
```dart
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
}

@override
void dispose() {
  super.dispose();
  WidgetsBinding.instance.removeObserver(this);
}
```