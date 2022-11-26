import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? Image;
  String? Name;
  String? id;
  String? subid;

  CategoryModel({this.Name, this.Image, this.id, this.subid});

  factory CategoryModel.fromDocument(DocumentSnapshot snapshot) {
    return CategoryModel(
      Image: snapshot["Image"],
      Name: snapshot["Name"],
      id: snapshot["id"],
      subid: snapshot["subid"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "Image": Image,
      "Name": Name,
      "id": id,
      "subid": subid,
    };
  }
}
