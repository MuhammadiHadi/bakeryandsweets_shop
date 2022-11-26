import 'package:bakeryandsweets_shop/screen/Admin/adminPage.dart';
import 'package:bakeryandsweets_shop/screen/auth/loginScreen.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/bottomNavigatonScreen.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/welcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _auth = FirebaseAuth.instance;

class AuthServices {
  static Signup(String? Name, String? Email, String? Phone, String? Image,
      String? password, BuildContext context) async {
    try {
      EasyLoading.show(status: "please wait");

      await _auth
          .createUserWithEmailAndPassword(email: Email!, password: password!)
          .then((value) async {
        FirebaseFirestore.instance
            .collection("Bakery_shop_User")
            .doc(_auth.currentUser!.uid)
            .set({
          "uid": _auth.currentUser!.uid,
          "Name": Name,
          "Email": Email,
          "Phone": Phone,
          "Image": Image,
        });

        EasyLoading.dismiss();

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginScreen()));
      }).catchError((e) {
        EasyLoading.showError(e.toString());
      });
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  static Login(String? email, String? password, BuildContext context) async {
    try {
      EasyLoading.show(status: "Please wait");
      await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        EasyLoading.dismiss();
        if (email == "malakhadikhan@gmail.com") {
          return Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AdminPage()));
        }
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => BottomNavigatonScreen()));
      }).catchError((e) {
        EasyLoading.showError(e.toString());
      });
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  static ResetPassword(String? email, BuildContext context) async {
    try {
      EasyLoading.show(status: "pleas wait");
      await _auth.sendPasswordResetEmail(email: email!).then((e) {
        EasyLoading.dismiss();
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginScreen()));
      }).catchError((e) {
        EasyLoading.showError(e.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  static Logout(BuildContext context) async {
    try {
      EasyLoading.show(status: "Please wait");
      _auth.signOut().then((value) async {
        EasyLoading.dismiss();
        return await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => WelcomeScreen()));
      });
    } catch (e) {
      print(e);
    }
  }

  static MyCard(
    String? Name,
    String? Price,
    String? dec,
    String? Image,
    String? Email,
    BuildContext context,
  ) async {
    try {
      EasyLoading.show(status: "please wait");
      await FirebaseFirestore.instance.collection("MyCard").doc().set({
        "Name": Name,
        "Price": Price,
        "dec": dec,
        "Image": Image,
        "Email": _auth.currentUser!.email,
      }).then((value) {
        EasyLoading.dismiss();
        return AlertDialog(
          title: Text("Successful Add "),
        );
      }).catchError((e) {
        EasyLoading.showError(e.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  static CheckOut(
    String? Name,
    String? Price,
    String? dec,
    String? Image,
    String? Email,
    String? username,
    String? phone,
    String? address,
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("CheckOut").doc().set({
        "Name": Name,
        "Price": Price,
        "dec": dec,
        "Image": Image,
        "Email": _auth.currentUser!.email,
        "username": username,
        "phone": phone,
        "address": address,
      }).then((value) {
        return Fluttertoast.showToast(
          msg: "Your Order are Successfully complete",
          timeInSecForIosWeb: 1,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }).catchError((e) {
        EasyLoading.showError(e.toString());
      });
    } catch (e) {
      print(e);
    }
  }
}
