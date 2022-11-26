import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? Name;
  String? Email;
  String? Phone;
  String? Image;

  UserModel({this.Name, this.Email, this.Phone, this.Image});

  factory UserModel.fromDocument(DocumentSnapshot snapshot) {
    return UserModel(
      Name: snapshot["Name"],
      Email: snapshot["Email"],
      Phone: snapshot["Phone"],
      Image: snapshot["Image"],
    );
  }

  Map<String, dynamic> toMop() {
    return {
      "Name": Name,
      "Email": Email,
      "Phone": Phone,
      "Image": Image,
    };
  }
}
