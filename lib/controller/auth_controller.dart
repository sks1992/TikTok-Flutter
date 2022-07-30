import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/model/user.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?> pickedImages;

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
        //collection('users') =>Gets a CollectionReference for the specified Firestore path.
        //doc() =>Returns a DocumentReference with the provided path.
        //set(user.toJson()=>Sets data on the document, overwriting any existing data. If the document does not yet exist, it will be create
        await fireStore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());

        //**///
      } else {
        Get.snackbar("Error Creating Account", "Please fill all the fields");
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

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar("Profile Picture",
          "You have Successfully select your profile picture ");
    }

    pickedImages = Rx<File?>(File(pickedImage!.path));
  }
}
