# WhatsApp Clone
Hi, this project is a an attempt of replicating the famous app WhatsApp. Before diving into the features and what is covered in this project, a small explanation is given below to the project structure.

# Key Features
- **Firebase phone authetication preceded by landing screen**
- **User Profile with profile pictures**
- **Search contacts to chat with**
- **Send text messages in real time**
- **Send images, videos, GIFs from GIPHY and Audio in real time**
- **Reply to messages which have a different structure!**
- **Create Groups!**
- **Participate in group chats!**
- **See if the user is online or not!**
- **Message seen status!**
- **See status updates of your contacts on the app!**
- **Post statuses which will be visible in form of stories!**

## Tech Stack Used
- **Flutter**
- **Dart**
- **Riverpod**
- **Firebase**
- **Giphy API**

### Checkout README_DETAILS for more details about the project!

## What is the README_DETAILS file?
- The README_DETAILS file is my journal in a way which has explanation for all the features I've implemented. Answers to questions like `Why implement this xyz feature this way?` can be found here.

- It contains a `TimeStamp Log` which has details about every development day. It gives a sense of timeframe one can expect while developing a project of this complexity.

- Working set of dependencies which don't collide are present so you don't have to worry about dependency mismatch.

- After this, mini guides are there in the order in which the features were implemented. This is in accordance with the branching structure which I will explain in the section below.

## Branch Structure 
#### You can essentially start the development cycle from any milestone as each has a working set of project code you can directly implement

The branches are made in the following format 

- ms = milestone

| Branch Name               | Significance                                                                                                                                                             |
|---------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ui_build                  | This branch was created with the purpose of showcasing responsive UI. It only contains placebo chats and its only for UI design which acts as a starter for next branch. |
| ms1_auth_done             | This branch was created when FirebaseAuthentication was successfully implemented and users could login using their phone numbers.                                        |
| ms2_paas                  | This branch was created when Persistent Authentication was established.                                                                                                  |
| ms3_contact_on_off_status | This branch was created when the feature to select contacts was created.                                                                                                 |
| ms4_sendmsg_onoff_status  | This branch was created when the feature to SEND text messages was added.                                                                                                |
| ms5_misc_msg_type         | This branch was created when the features to send audio, video, images and GIFs was added.                                                                               |
| ms6_reply_seen_status     | This branch was created when the feature to reply to text messages was added along with a blue tick indicator to inidicate whether the message is seen                   |
| ms7_groups                | This branch was created when the group chat functionality was added with the ability to create groups                                                                    |
| ms8_fin                   | Final touchups and basic build of the app complete                                                                                                                       |

## What Next?
- After ms8, I will be fixing the `Development_Errors` which are bugs about which I'm already aware of.
- After debugging these, I will add new features to the app over time
> For Example:
>> - Breaking chat into day breaks
>> - Remove Members from groups
>> - Add Members into groups
>> - Leave groups
- Their branches will be named with prefix `dev`
- `Main branch will always contain the latest build`

## Development Errors
- When you are replying to a big message or something like that, render overflow error when keyboard brought up

- Alignment of sender user text

- Status can be too slow to load sometimes

## Features which won't be implemented
The group is in a FFA (Free For All) state as anyone can add anyone. A lot of backend work will be required to create group admins and give them special powers. 

The only way to "delete" a group is to leave it or get kicked after which you won't be able to join it unless a group member adds you again.

Audio message cancellation

Messages are permanently stored so there is no way to delete messages. 

### Note:
This app is not a product but just my ability to showcase my skills as a competent app developer