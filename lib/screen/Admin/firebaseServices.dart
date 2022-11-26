import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseServices {
  static UploadCategory(String? name, String? image, String? id, String? subid,
      BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection("Bakery_shop").doc(id).set({
        "Name": name,
        "Image": image,
        "id": id,
        "subid": subid,
      }).then((value) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("successful upload"),
            duration: Duration(seconds: 1),
          ),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static ProductUploadToCategory(
    String? Name,
    String? Price,
    String? dec,
    String? Image,
    String id,
    String subid,
    BuildContext context,
  ) async {
    try {
      EasyLoading.show(status: " Please wait");
      var _uploadCategory =
          FirebaseFirestore.instance.collection("Bakery_shop");
      _uploadCategory.doc(id).collection(subid).doc().set({
        "Name": Name,
        "Price": Price,
        "dec": dec,
        "Image": Image,
      }).then((snapshot) {
        return EasyLoading.dismiss();
      });
    } catch (e) {
      print(e);
    }
  }
}
