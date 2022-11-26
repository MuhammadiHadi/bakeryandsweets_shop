import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? Name;
  String? Price;
  String? dec;
  String? Image;

  ProductModel({this.Name, this.Price, this.dec, this.Image});

  factory ProductModel.fromDocument(DocumentSnapshot snapshot) {
    return ProductModel(
      Name: snapshot["Name"],
      Price: snapshot["Price"],
      dec: snapshot["dec"],
      Image: snapshot["Image"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "Name": Name,
      "Price": Price,
      "dec": dec,
      "Image": Image,
    };
  }
}
