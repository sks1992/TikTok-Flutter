import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/add_video_screen.dart';

import 'controller/auth_controller.dart';

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//constants for firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

//for authController
var authController = AuthController.instance;

//list of widgets for bottomNavigationBar
const pages = [
  Center(child: Text("Home")),
  Center(child: Text("Search")),
  AddVideoScreen(),
  Center(child: Text("Message")),
  Center(child: Text("Profile")),
];
