import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// We dont need a controller for this because this function will be needed only in this class

final commonFBSRepoProvider = Provider(
  (ref) => CommonFBSRepo(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class CommonFBSRepo {
  final FirebaseStorage firebaseStorage;
  CommonFBSRepo({
    required this.firebaseStorage,
  });

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    // Taking help of TaskSnapshot
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
