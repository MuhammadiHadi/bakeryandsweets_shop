import 'dart:io';

import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/Admin/category.dart';
import 'package:bakeryandsweets_shop/screen/Admin/firebaseServices.dart';
import 'package:bakeryandsweets_shop/screen/Admin/productUpload.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryUpload extends StatefulWidget {
  const CategoryUpload({Key? key}) : super(key: key);

  @override
  State<CategoryUpload> createState() => _CategoryUploadState();
}

class _CategoryUploadState extends State<CategoryUpload> {
  File? categoryImage;

  ImageFormGallery() async {
    XFile? _file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (_file != null) {
        categoryImage = File(_file.path);
      }
    });
  }

  ImageFormCamera() async {
    XFile? _file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (_file != null) {
        categoryImage = File(_file.path);
      }
    });
  }

  TextEditingController categorynamecontroller = TextEditingController();
  TextEditingController subcategorynamecontroller = TextEditingController();
  TextEditingController categoryidcontroller = TextEditingController();
  String? ImageLink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("categoryUpload"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "Upload Product Category",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                categoryImage == null
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.24,
                        width: double.infinity,
                        color: Colors.black12,
                        child: Center(
                            child: InkWell(
                                onTap: () {
                                  ImageFormGallery();
                                },
                                child: Text("Select image"))),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.24,
                        width: double.infinity,
                        child: Image.file(File(categoryImage!.path)),
                      ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Category Name",
                  ),
                  controller: categorynamecontroller,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Category id",
                  ),
                  controller: categoryidcontroller,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "SubCategory id",
                  ),
                  controller: subcategorynamecontroller,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ParimaryButton(
                  title: " Upload",
                  OnPressad: () async {
                    FirebaseStorage _storage = FirebaseStorage.instance;
                    Reference _reference = await _storage.ref().child(
                        DateTime.now().microsecondsSinceEpoch.toString());
                    await _reference
                        .putFile((categoryImage!))
                        .then((snapshot) async {
                      return ImageLink = await snapshot.ref.getDownloadURL();
                    });
                    FirebaseServices.UploadCategory(
                        categorynamecontroller.text,
                        ImageLink,
                        categoryidcontroller.text,
                        subcategorynamecontroller.text,
                        context);
                  },
                  color: AppColors.Primarygrey,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.006,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("Upload this Category Product"),
                ),
                ParimaryButton(
                  title: "Upload Product",
                  color: Colors.brown,
                  OnPressad: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProductUpload()));
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.006,
                ),
                ParimaryButton(
                  title: "show category",
                  color: Colors.brown,
                  OnPressad: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Category()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
