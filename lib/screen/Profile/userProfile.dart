import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/auth/authServices.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Bakery_shop_User")
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        color: Colors.grey,
                        child: Image.network(
                          snapshot.data!.docs[index]['Image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 90, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.16,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data!.docs[index]['Image']),
                                  )),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: AppColors.Primaryblue,
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]["Name"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.edit,
                                  color: AppColors.Primaryblue,
                                ),
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: Icon(
                                  Icons.email,
                                  color: AppColors.Primaryblue,
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]["Email"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.edit,
                                  color: AppColors.Primaryblue,
                                ),
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: Icon(
                                  Icons.phone,
                                  color: AppColors.Primaryblue,
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]["Phone"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(
                                  Icons.edit,
                                  color: AppColors.Primaryblue,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: ParimaryButton(
                                title: "LOGOUT",
                                color: AppColors.Primaryblue,
                                OnPressad: () {
                                  AwesomeDialog(
                                      context: context,
                                      title: "LogOut",
                                      desc: "AreYou want to LogOut",
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        AuthServices.Logout(context);
                                      }).show();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
