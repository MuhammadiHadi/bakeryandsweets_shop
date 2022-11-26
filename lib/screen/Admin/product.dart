import 'package:bakeryandsweets_shop/Model/productModle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final String? id;
  final String? subid;

  Product({this.id, this.subid});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("product"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Bakery_shop")
            .doc(widget.id!)
            .collection(widget.subid!)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                ProductModel productModel =
                    ProductModel.fromDocument(snapshot.data!.docs[index]);
                return Column(
                  children: [
                    Card(
                      color: Colors.blueGrey,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(
                          productModel.Image!,
                          fit: BoxFit.cover,
                        ),
                        title: Text(productModel.Name.toString()),
                        subtitle: Text(productModel.dec.toString()),
                        trailing: Text(productModel.Price.toString()),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
