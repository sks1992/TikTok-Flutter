import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String userProfileImage;
  String email;
  String uid;

  User({
    required this.name,
    required this.userProfileImage,
    required this.email,
    required this.uid,
  });

  //it transfer our user data to a map for upload
  Map<String, dynamic> toJson() => {
        'name': name,
        'userProfileImage': userProfileImage,
        'email': email,
        'uid': uid
      };
//A DocumentSnapshot contains data read from a document in your FirebaseFirestore database.
// The data can be extracted with the data property or by using subscript syntax to access a specific field
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['name'],
        userProfileImage: snapshot['userProfileImage'],
        email: snapshot['email'],
        uid: snapshot['uid']);
  }
}
