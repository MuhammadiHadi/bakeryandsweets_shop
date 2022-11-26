import 'package:bakeryandsweets_shop/screen/auth/authServices.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/MyCard.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/bottomNavigatonScreen.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/topCategory.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Bakery_shop_User")
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text("Wait");
              }

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.23,
                          width: double.infinity,
                          color: AppColors.Primaryblue,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['Image']),
                                      )),
                                ),
                                Text(
                                  snapshot.data!.docs[index]["Name"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data!.docs[index]["Email"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ListTile(
                            leading: Icon(
                              Icons.home,
                              color: AppColors.Primaryblue,
                            ),
                            title: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              BottomNavigatonScreen()));
                                },
                                child: Text(
                                  "Home",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                        Divider(
                          color: AppColors.Primarygrey,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.list,
                            color: AppColors.Primaryblue,
                          ),
                          title: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TopCategory()));
                              },
                              child: Text(
                                "Category",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Divider(
                          color: AppColors.Primarygrey,
                        ),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.cartShopping,
                            color: AppColors.Primaryblue,
                          ),
                          title: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MyCard()));
                              },
                              child: Text(
                                "My Card",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Divider(
                          color: AppColors.Primarygrey,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: AppColors.Primaryblue,
                          ),
                          title: InkWell(
                              onTap: () {
                                AuthServices.Logout(context);
                              },
                              child: Text(
                                "logout",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Divider(
                          color: AppColors.Primarygrey,
                        ),
                      ],
                    );
                  });
            }));
  }
}
