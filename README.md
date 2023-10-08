# WhatsApp Clone

### As I am building the app, as per progress, snapshots of different app development stages are present in appropriately named branches.
### A Project TimeStamp Log will be present throughout and can be used to give you a jist of what I did and WHEN I did

# Development Errors
- When you are replying to a big message or something like that, render overflow error when keyboard brought up

- Alignment of sender user text

- Status can be too slow to load sometimes
## Project Time STAMP LOG

| Day        | Total Time (Min) | Comments                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | Session No. |
|------------|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| 18-09-2023 | 83               | Made the basic UI and setup the base design. Can be found in ui_build branch.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | 1           |
| 19-09-2023 | 62               | Setup FireBase, Created Landing Screen and designed CustomButton and ErrorScreen (Basic Scaffold)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | 1           |
| 20-09-2023 | 82               | Create Login Screen with Country Picker and setup Named Routes in main.dart and create a router by the name router.dart                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | 1           |
| 20-09-2023 | 36               | Created AuthRepository(Phone Login), OTP Screen foundation led up, Updated router.dart for OTPScreen to get verificationId as argument. Created utils.dart with Snackbar                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | 2           |
| 20-09-2023 | 38               | Configured AuthController Provider and AuthRepositoryProvider and modified main.dart. Setup Business login in sendPhoneNumber() using ref.read()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | 3           |
| 20-09-2023 | 85               | Added SHA - 1 fingerprint on firebase console. Created OTP Screen and added OTP business logic and verification WORKS! Added route, modified auth repo and controller.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | 4           |
| 21-09-2023 | 105              | Added ImagePicker, Created FBSRepo, wrote a method in AuthRepo, setup firestore methods, created UserModel and UserInfoScreen and created sendingToDB methods.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | 1           |
| 22-09-2023 | 168              | Added persistent auth, created github content, added loaders, debugged app, started working on contacts.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | 1           |
| 23-09-2023 | 82               | Added contacts screen, binded and added route, created provider and controller for selecting contacts.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | 1           |
| 26-09-2023 | 35               | Added selectContact() method, onTap() functionality to the contact list, singeChildScroolView on login screen.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | 1           |
| 26-09-2023 | 38               | Did some real phone testing, added navigator argument functionality, updated router.dart and added dynamic name generation from contact list                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | 2           |
| 27-09-2023 | 83               | Added online/offline status using streambuilder, modified chat text field on chat screen, created BottomChatField stateful widget and debugged app. <Note> Name broken if chat accessed from main chat screen                                                                                                                                                                                                                                                                                                                                                                                                                                                          | 1           |
| 27-09-2023 | 112              | Message sending feature added from backend side along with last seen functionality.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 2           |
| 28-09-2023 | 78               | Tediously long process of using stream builders for chat screen and contact page. Not Debugged properly                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | 1           |
| 28-09-2023 | 81               | Debugged everything (issue was that contactId was being passed phoneNumber) and got the app working with real time chatting functionality                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | 2           |
| 28-09-2023 | 23               | Added online/offline status using WidgetsBindingObserver. Added cases for didChangeAppLifecycleState, added initState and dispose in MobileScreenLayout.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | 3           |
| 01-10-2023 | 81               | Added sendFileMessage() in chat repo/controller, linked camera icon with the function in bottom chat field, modified message cards for sender and receiver, created a separate widget, adjusted myMessage card.                                                                                                                                                                                                                                                                                                                                                                                                                                                        | 1           |
| 02-10-2023 | 174              | Added Video Player Widget, converted display message acc to type if else block to switch, added pickVideoGallery global utils function, added emoji keyboard and binded functions to bottom chat field widget, added FocusNode to keep track of keyboards, added GIF SDK version from GIPHY using enough_giphy_flutter, added function in bottom_chat_field and chat repository, formatted input in chat controller for handling gifs, changed dependency in pubspec.yaml for flutter_sound and uuid compatibility, added permission_handler, created dispose for futterSoundRecorder, added logic in sendTextMessage() to handle audio and added openAudio() function | 2           |
| 04-10-2023 | 54               | Added a global common provider messageReplyProvider, created message_reply_preview widget, modified myMessafe, modified chat repo functions for messageReply, modified Message class for messageReply, modified chat_list for messageReply, modified bottom chat field widget slightly to accomodate reply feature                                                                                                                                                                                                                                                                                                                                                     | 1           |
| 04-10-2023 | 83               | Finished reply feature (Changed Firestore structure a bit after debugging), added Seen feature and debugged the app.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 2           |
| 05-10-2023 | 63               | Created statusRepository, status class, tabBarView for status, updated router.dart, created confirmStatusScreen, created statusContactScreen and started work on repository                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | 1           |
| 05-10-2023 | 73               | Finished uploadStatus function in statusRepo, created controller for statusRepo and binded functions, finished confirmStatusScreen and finished first part of statuses, debug issue was in model part where JSON serialization was done incorrectly (human error), built index on firebase, finished status contact screen, finished getStatus() in status repo, added statusScreen, added StoryView and finished Status feature.                                                                                                                                                                                                                                      | 2           |
| 07-10-2023 | 117              | Added createGroupScreen and selectContact widget for the same, created a state notifier for selected contact which can be updated and read globally, created a group model, created group repo, created create Group function, added new logic for selectContact, finished backend work.                                                                                                                                                                                                                                                                                                                                                                               | 1           |
| 08-10-2023 | 123              | Added a stream builder for displaying groups, added functions for the same in chat repo, added isGroupChat check and modified dependencies (files), modified chat repo to get stream of group chat messages, added a ternary expression determining provider for stream of messages based on isGroupChat in chat list, a LOT of modifications to accomodate sending messages to chat repo (all sub functions modified as well), controller functions modified for isGroupChat functionality and debugged the app.                                                                                                                                                      | 1           |
| 08-10-2023 | 55               | Created callModel, installed agora_uikit, did initial setup, created folder structure for call feature, created makeCall function, modified contact_list, added makeCall in mobileChatScreen, created callPickupScreen. Because of technical difficulties and need of a deployed server which would have made the project too complicated, call feature is scrapped. The guide can be found in ms8_fin.                                                                                                                                                                                                                                                                | 2           |

## Working Set of dependencies
```yaml
environment:
  sdk: '>=3.1.2 <4.0.0'
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  firebase_core: ^2.16.0
  firebase_auth: ^4.10.0
  cloud_firestore: ^4.9.2
  firebase_storage: ^11.2.7
  country_picker: ^2.0.21
  flutter_riverpod: ^2.4.0
  image_picker: ^1.0.4
  flutter_contacts: ^1.1.7+1
  uuid: ^3.0.1
  intl: ^0.18.1
  cached_network_image: ^3.3.0
  cached_video_player: ^2.0.4
  emoji_picker_flutter: ^1.6.1
  enough_giphy_flutter: ^0.4.1
  flutter_sound: ^9.2.13
  permission_handler: ^9.2.0
  path_provider: ^2.1.1
  audioplayers: ^5.1.0
  swipe_to: ^1.0.2
  story_view: ^0.15.0
```

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
## Sending Files (Images and all)
Create a function for the same in chat repository

Added cached_network_image and cached_video_player dependency to cache the network images and videos so they don't download every time user opens the page.

Functions are created accordingly.

### Video Player Widget
This file has the cached video player widget present along with ability to play and pause the video. A controller is also present for the same.

### Display Msg Acc to Type
Stands for `Display message according to type` and has a switch case block similar to router file to return the correct widget corresponding to the message enum type.

## Bottom Chat Field Emoji
I'm using emoji_picker dependency for this. And there are 2 class of functions with show/hide options for each keyboard and emoji keyboard.

FocusNode keeps track of whether or not we need to show the keyboard or not

## GIFs
> Create a developer account on GIPHY

> Register an app for the key

Now the general trend of this project is to store the file in storage and retrieve it's url from firebase firestore.

I created a separate sendGIF function similar to sendFileMessage in chat repo for additional functionality followed by standard controller procedure followed by creating the function in intended widget.

#### Note : Input formatting in controller widgets
```
https://giphy.com/gifs/hoppip-art-television-ukyykyDcWZbIQ
should be formatted as
https://i.giphy.com/media/ukyykyDcWZbIQ/200.gif
```
In code, it can be done like this but there are other options too.
```dart
String temp = '';
  var i = gifUrl.length - 1;
  while (gifUrl[i] != '-') {
    temp = temp + gifUrl[i];
    i--;
  }
  temp = String.fromCharCodes(temp.codeUnits.reversed);
  String actualUrl = 'https://i.giphy.com/media/$temp/200.gif';
```

## Audio
IOS needs plist update with `NSAppleMusicUsageDescription`

Also for flutter_sound to work uuid 3.0.1 is needed

And for permission_handler to work with `agura` (which I'll use later), version 9.2.0 is needed.

Need to setup inside pod_installer for IOS

Added path_provider

A lot of setup had to be done for the audio file message type which can be found in the `bottom_chat_field.dart` file.

Using a StatefulBuilder to get stateful widget capability in Display_Msg... which is a StatelessWidget.

## Replying to Messages
`message_reply_provider` will help to reply to messages and will contain the reply to any message you want.

A state provider is used instead of a normal provider because the state of the provider can be updated whenever the provider is used.

It can be null (the initial state). The message reply will get updated when we reply to a message (as we slide it)

A message reply preview widget is created as some dialogue box of some sort needs to be brought up on top of the bottom chat field in case a message is being replied to.

The preview bar will have be a container with the message and a desc. of who the user is replying to.

swipe_to is used to detect the swipes required for replying to messages.

We are reading the value from messageReplyProvider (with every swipe we update it) and then we are passing the fresh values.

New functions were not created, existing ones were replied to handle the replied functionality.

`...` cascade operator allows us to pass multiple widgets in cases like this
```dart
if (isReplying) ...[
  Text(
    userName,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  const SizedBox(
    height: 3,
  ),
  Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: backgroundColor.withOpacity(0.4),
      borderRadius: BorderRadius.circular(7),
    ),
    child: DisplayMessageAccordingToType(
      message: repliedText,
      type: repliedMessageType,
    ),
  ),
  const SizedBox(
    height: 8,
  ),
],
```

## Seen Feature
If the receiver id is current id, then seen message should be hit.

A simple update function does this for us.

In chat list, if the message is not seen and receiver id is auth instance user id, then setChatMessage to seen (this will only work for new messages which are not seen)

## Status feature
First step is to add a tabBarView with children as the tabs and a controller for the same

Add a tickerProvider in the mix in while creating the class as `with ...`

Refer to comments in status repostiory for detailed explanation.

story_view is used to get that story like UI.

## Create Groups
When using a popupmenu item, it uses pop() to dismiss the pop up box, so it is important to wrap the widget with a future

Not much explanation is there as a lot of code is re used and logic is re implemented

createGroup in the group repo

select Contact reused from the provider

How to efficiently handle selecting contacts and updating state accordingly

```dart
void selectContact(Contact contact, String phoneNumber) {
  if (selectedContactsIndex.contains(phoneNumber)) {
    selectedContactsIndex.removeWhere((element) => element == phoneNumber);
    setState(() {
      ref.read(selectedGroupContact.notifier).update((state) {
        state.removeWhere((element) => element == contact);
        state = [...state];
        return state;
      });
    });
  } else {
    selectedContactsIndex.add(phoneNumber);
    setState(() {
      ref.read(selectedGroupContact.notifier).update((state) {
        state.add(contact);
        state = [...state];
        return state;
      });
    });
  }
}
```
I reuse the chat list by passing in an isGroupChat variable where I change the receiver user id as groupId when it is a group

Similar changes for the group name and picture

And collection change for getting the stream of messages in the chat repo

A lot of changes made for sending messages in groups in bottom chat field and chat repo and controller

How to store messages for groups <br>
`groups -> group id -> chat -> message`

## Calling
Dependencies
```dart
flutter pub add agora_uikit // Check dependencies section to have a WORKING SET
1. Create agora account
2. Create a project in Test mode
3. Enable Primary Certificate
4. Create a config file with token, appId and certificate
5. Follow docs
```

Stream builders will be used a lot in this calling part

In call collection with document of caller id and this has to be done for both users

CallPickupScreen will have a streamBuilder which will continously listen to the sub collections with "our" uid which will show a screen to accept or reject the call

The scaffold in CallPickupScreen is to control `do we need to show this`. If the stream builder doesn;t have our uid, then the widget needs to return scaffold

The call part is made in `go` lang which has to be deployed, any developer wanting to implement this can use the 