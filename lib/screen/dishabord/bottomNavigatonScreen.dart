import 'package:badges/badges.dart';
import 'package:bakeryandsweets_shop/Provider_class/bottomScreenClass.dart';
import 'package:bakeryandsweets_shop/Provider_class/counterClass.dart';
import 'package:bakeryandsweets_shop/coustom_widget/drawer.dart';
import 'package:bakeryandsweets_shop/screen/Profile/userProfile.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/MyCard.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/homeScreen.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/topCategory.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavigatonScreen extends StatefulWidget {
  const BottomNavigatonScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigatonScreen> createState() => _BottomNavigatonScreenState();
}

class _BottomNavigatonScreenState extends State<BottomNavigatonScreen> {
  final Screen = [HomeScreen(), TopCategory(), UserProfile(), MyCard()];

  @override
  Widget build(BuildContext context) {
    final bottomScreenClass =
        Provider.of<BottomScreenClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BakeryShop",
        ),
        actions: [
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
        ],
      ),
      drawer: DrawerWidget(),
      body: Screen[bottomScreenClass.currentIndex],
      bottomNavigationBar:
          Consumer<BottomScreenClass>(builder: (context, value, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: value.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              label: "Category",
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: "MyCard",
              icon: Icon(FontAwesomeIcons.cartShopping),
            ),
          ],
          onTap: (index) {
            setState(() {
              bottomScreenClass.setCurrentIndex(index);
            });
          },
        );
      }),
    );
  }
}
