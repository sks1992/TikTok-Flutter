import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/model/user.dart' as model;

class AuthController extends GetxController {
  void registerUser(
    String username,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save user to auth and firebase
        UserCredential credential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String userDownloadUrl = await _uploadUserProfileImageToFirebase(image);

        model.User user = model.User(
          name: username,
          userProfileImage: userDownloadUrl,
          email: email,
          uid: credential.user!.uid,
        );

        //**///
      }
    } catch (e) {
      Get.snackbar("Error Creating Account", e.toString());
    }
  }

  Future<String> _uploadUserProfileImageToFirebase(File image) async {
    /*Reference=>Represents a reference to a Google Cloud Storage object.
    Developers can upload, download, and delete objects, as well as
     get/set object metadata.*/
    Reference reference = firebaseStorage
        .ref()
        .child('userProfilePic')
        .child(firebaseAuth.currentUser!.uid);
//Upload a File from the filesystem. The file must exist.
    UploadTask uploadTask = reference.putFile(image);
//A TaskSnapshot is returned as the result or on-going process of a Task
    TaskSnapshot taskSnapshot = await uploadTask;

    String userDownloadUrl = await taskSnapshot.ref.getDownloadURL();
    return userDownloadUrl;
  }
}
