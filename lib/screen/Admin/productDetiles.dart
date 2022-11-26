import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bakeryandsweets_shop/Model/productModle.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetiles extends StatefulWidget {
  final String? id;
  final String? subid;

  ProductDetiles({this.id, this.subid});

  @override
  State<ProductDetiles> createState() => _ProductDetilesState();
}

class _ProductDetilesState extends State<ProductDetiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
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
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    isDense: true,
                    suffixIcon: Icon(FontAwesomeIcons.anglesDown),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        ProductModel productModel = ProductModel.fromDocument(
                            snapshot.data!.docs[index]);
                        return Column(
                          children: [
                            Container(
                              height: 180,
                              width: 150,
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 110,
                                      width: double.infinity,
                                      child: Image.network(
                                        productModel.Image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.004,
                                    ),
                                    Text(
                                      "Name:  " + productModel.Name.toString(),
                                      style: TextStyle(
                                          color: AppColors.Primarygreen),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.003,
                                    ),
                                    Text("Rs: " + productModel.Price.toString(),
                                        style: TextStyle(
                                            color: AppColors.Primaryblue)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.edit),
                                        InkWell(
                                          onTap: () {
                                            AwesomeDialog(
                                              context: context,
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () {
                                                FirebaseFirestore.instance
                                                    .collection("Bakery_shop")
                                                    .doc(widget.id!)
                                                    .collection(widget.subid!)
                                                    .doc(snapshot
                                                        .data!.docs[index].id)
                                                    .delete();
                                              },
                                              dialogType: DialogType.QUESTION,
                                              title: "Delete ",
                                              desc:
                                                  "Are You Want To Delete this category",
                                            ).show();
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: AppColors.Primaryred,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
