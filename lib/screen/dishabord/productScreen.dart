import 'package:badges/badges.dart';
import 'package:bakeryandsweets_shop/Model/productModle.dart';
import 'package:bakeryandsweets_shop/Provider_class/counterClass.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/orderScreen.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final String? id;
  final String? subid;

  ProductScreen({this.id, this.subid});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final counterClass = Provider.of<CounterClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("ProductList"), actions: [
        Center(
          child: Badge(
            badgeContent:
                Consumer<CounterClass>(builder: (context, value, child) {
              return Text(
                value.count.toString(),
                style: TextStyle(color: Colors.white),
              );
            }),
            animationDuration: Duration(microseconds: 300),
            child: Icon(
              FontAwesomeIcons.cartShopping,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.06,
        ),
      ]),
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    isDense: true,
                    filled: true,
                    fillColor: AppColors.Primarywhite,
                    suffixIcon: Icon(FontAwesomeIcons.anglesDown),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: searchcontroller,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.21,
                                width: MediaQuery.of(context).size.width * 0.47,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => OrderScreen(
                                                  image: productModel.Image!,
                                                  name: productModel.Name!,
                                                  price: productModel.Price!,
                                                  dec: productModel.dec!,
                                                )));
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: double.infinity,
                                          child: Image.network(
                                            productModel.Image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            productModel.Name.toString(),
                                            style: TextStyle(
                                                color: AppColors.Primaryblack,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
