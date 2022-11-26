import 'dart:io';

import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/Admin/firebaseServices.dart';
import 'package:bakeryandsweets_shop/screen/Admin/product.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductUpload extends StatefulWidget {
  const ProductUpload({Key? key}) : super(key: key);

  @override
  State<ProductUpload> createState() => _ProductUploadState();
}

class _ProductUploadState extends State<ProductUpload> {
  File? imageupload;
  String? imageLik;

  ImageFormGallery() async {
    XFile? _file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (_file != null) {
        imageupload = File(_file.path);
      }
    });
  }

  ImageFormCamera() async {
    XFile? _file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (_file != null) {
        imageupload = File(_file.path);
      }
    });
  }

  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController deccontroller = TextEditingController();
  TextEditingController subcategorynamecontroller = TextEditingController();
  TextEditingController categoryidcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProductUpload"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text("Upload Product"),
              ),
              imageupload == null
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      width: double.infinity,
                      color: AppColors.Primarygrey,
                      child: InkWell(
                          onTap: () {
                            ImageFormGallery();
                          },
                          child: Center(child: Text("Select Image"))),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      width: double.infinity,
                      child: Image.file(File(imageupload!.path)),
                    ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                controller: namecontroller,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Price",
                ),
                controller: pricecontroller,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "dec",
                ),
                controller: deccontroller,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Category id",
                ),
                controller: categoryidcontroller,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Add SubCategory Id",
                ),
                controller: subcategorynamecontroller,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ParimaryButton(
                title: "Upload",
                color: AppColors.Primarygrey,
                OnPressad: () async {
                  FirebaseStorage _storage = await FirebaseStorage.instance;
                  Reference _reference = await _storage
                      .ref()
                      .child(DateTime.now().microsecondsSinceEpoch.toString());
                  await _reference
                      .putFile((imageupload!))
                      .then((snapshot) async {
                    return imageLik = await snapshot.ref.getDownloadURL();
                  });
                  FirebaseServices.ProductUploadToCategory(
                    namecontroller.text,
                    pricecontroller.text,
                    deccontroller.text,
                    imageLik,
                    categoryidcontroller.text,
                    subcategorynamecontroller.text,
                    context,
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.017,
              ),
              ParimaryButton(
                title: "ProductList",
                color: Colors.brown,
                OnPressad: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Product(
                            id: categoryidcontroller.text,
                            subid: subcategorynamecontroller.text,
                          )));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
