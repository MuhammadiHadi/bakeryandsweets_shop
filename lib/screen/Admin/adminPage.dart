import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/Admin/categoryUpload.dart';
import 'package:bakeryandsweets_shop/screen/Admin/productUpload.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AdminPage"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome To Admin Page"),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ParimaryButton(
              title: "CategoryUpload",
              color: AppColors.Primaryblue,
              OnPressad: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CategoryUpload()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ParimaryButton(
              title: "ProductUpload",
              color: AppColors.Primaryblue,
              OnPressad: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProductUpload()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
