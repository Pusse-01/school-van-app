
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_van_app/services/database.dart';
import 'database.dart';

class authService{
  FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseFirestore userdetails = FirebaseFirestore.instance;
  User? _userFromfirebase(User? user){
    return user != null ? user : null;
  }

  Stream<User?> get user {
    return _auth.userChanges().map((User? user) =>
        _userFromfirebase(user!));
    //or can just use .map(_userfromfirebase)
  }


  Future Signin_with_email(String Email, String Password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: Email, password: Password);
      User? user = result.user;
      return _userFromfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerwithEmaildriver(String email, String Password,String name,String license,String NIC,String Phoneno,String address) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: Password);
      User? newuser = result.user;
      databaseService d1= databaseService(uid: newuser!.uid);
      d1.setdriverdata(name, Phoneno, email,license, NIC, address);
      await newuser.updateDisplayName(name);
      return _userFromfirebase(newuser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerwithEmailstudent(String email, String Password,String lastname,String firstname,List<String>classes,String Phoneno,String school) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: Password);
      User? newuser = result.user;
      databaseService d1= databaseService(uid: newuser!.uid);
      d1.setstudentdata(firstname, lastname, Phoneno, email, classes, school);
      await newuser.updateDisplayName(firstname+" "+lastname);
      return _userFromfirebase(newuser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}