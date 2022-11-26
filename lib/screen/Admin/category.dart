import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bakeryandsweets_shop/Model/categoryModel.dart';
import 'package:bakeryandsweets_shop/screen/Admin/productDetiles.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController searchcontroller = TextEditingController();
  String search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Category"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("Bakery_shop").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      controller: searchcontroller,
                      onChanged: (String value) {
                        search = value;
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.213,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                CategoryModel data = CategoryModel.fromDocument(
                                    snapshot.data!.docs[index]);

                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Card(
                                    color: AppColors.Primarywhite,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.14,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          ProductDetiles(
                                                            id: data.id!
                                                                .toString(),
                                                            subid: data.subid!
                                                                .toString(),
                                                          )));
                                            },
                                            child: Image.network(
                                              data.Image!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          data.Name.toString(),
                                          style: TextStyle(
                                              color: AppColors.Primaryblack,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: AppColors.Primaryblue,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  btnCancelOnPress: () {},
                                                  btnOkOnPress: () {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "Bakery_shop")
                                                        .doc(snapshot.data!
                                                            .docs[index].id)
                                                        .delete();
                                                  },
                                                  dialogType:
                                                      DialogType.QUESTION,
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
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
