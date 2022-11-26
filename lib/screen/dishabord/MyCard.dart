import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bakeryandsweets_shop/Provider_class/counterClass.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/checkOutScreen.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCard extends StatefulWidget {
  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    final counterClass = Provider.of<CounterClass>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("MyCard")
              .where('Email',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapahot) {
            if (!snapahot.hasData) {
              return Center(
                  child: Text(
                " My Card Is Empty",
                style: TextStyle(color: AppColors.Primaryblue, fontSize: 25),
              ));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapahot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  leading: Image.network(
                                      snapahot.data!.docs[index]['Image']),
                                  title:
                                      Text(snapahot.data!.docs[index]['Name']),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapahot.data!.docs[index]['Price']),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        color: AppColors.Primarygreen,
                                        child: Center(
                                            child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        CheckOutScreen(
                                                          name: snapahot.data!
                                                                  .docs[index]
                                                              ['Name'],
                                                          price: snapahot.data!
                                                                  .docs[index]
                                                              ['Price'],
                                                          image: snapahot.data!
                                                                  .docs[index]
                                                              ['Image'],
                                                          Email: snapahot.data!
                                                                  .docs[index]
                                                              ['Email'],
                                                        )));
                                          },
                                          child: Text(
                                            "CheckOut",
                                            style: TextStyle(
                                              color: AppColors.Primarywhite,
                                            ),
                                          ),
                                        )),
                                      )
                                    ],
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.QUESTION,
                                          title: "Delete!",
                                          desc:
                                              "Are you want to delete this form MyCard",
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            counterClass.decreaseCounder();
                                            FirebaseFirestore.instance
                                                .collection("MyCard")
                                                .doc(snapahot
                                                    .data!.docs[index].id)
                                                .delete();
                                          }).show();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: AppColors.Primaryred,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
