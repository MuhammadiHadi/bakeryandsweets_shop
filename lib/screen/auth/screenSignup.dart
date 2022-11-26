import 'dart:io';

import 'package:bakeryandsweets_shop/Provider_class/passwordVisibily.dart';
import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/auth/authServices.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Screen extends StatefulWidget {
  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  File? userImage;
  String? Imagelink;
  ImageFormGallery() async {
    XFile? _file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (_file != null) {
        userImage = File(_file.path);
      }
    });
  }

  ImageFormCarmera() async {
    XFile? _file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (_file != null) {
      userImage = File(_file.path);
    }
  }

  TextEditingController fullanamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenocontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordvisibilty =
        Provider.of<PasswordVisibilty>(context, listen: false);
    return Scaffold(
      body: Form(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "SingUp",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  userImage == null
                      ? CircleAvatar(
                          backgroundColor: AppColors.Primarygrey,
                          radius: 70,
                          child: InkWell(
                              onTap: () {
                                ImageFormGallery();
                              },
                              child: Icon(Icons.image)),
                        )
                      : CircleAvatar(
                          radius: 70,
                          child: Image.file(File(userImage!.path)),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Full Name",
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.Primarywhite,
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: fullanamecontroller,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Email",
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.Primarywhite,
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: emailcontroller,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Phone No",
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.Primarywhite,
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: phonenocontroller,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Consumer<PasswordVisibilty>(
                        builder: (context, value, child) {
                      print(" only this widget");
                      return TextField(
                        obscureText: value.is_visible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.Primarywhite,
                          suffixIcon: InkWell(
                            onTap: () {
                              passwordvisibilty.setVisibilty();
                            },
                            child: Icon(
                              value.is_visible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: passwordcontroller,
                      );
                    }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ParimaryButton(
                      title: "SING UP",
                      color: AppColors.PrimaryblueGrey,
                      OnPressad: () async {
                        FirebaseStorage _storage =
                            await FirebaseStorage.instance;

                        Reference _reference = await _storage.ref().child(
                            DateTime.now().millisecondsSinceEpoch.toString());
                        await _reference
                            .putFile((userImage!))
                            .then((snapshot) async {
                          return Imagelink =
                              await snapshot.ref.getDownloadURL();
                        });
                        AuthServices.Signup(
                            fullanamecontroller.text,
                            emailcontroller.text,
                            phonenocontroller.text,
                            Imagelink,
                            passwordcontroller.text,
                            context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
