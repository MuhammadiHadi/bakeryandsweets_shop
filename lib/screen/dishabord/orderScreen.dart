import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart';
import 'package:bakeryandsweets_shop/Provider_class/counterClass.dart';
import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/auth/authServices.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? dec;
  String? Email;

  OrderScreen({
    this.image,
    this.name,
    this.price,
    this.dec,
    this.Email,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    String? newPrice = widget.price.toString();
    final counterClass = Provider.of<CounterClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Buy Product",
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
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(),
              child: Image.network(
                widget.image!,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name!,
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColors.Primaryblue,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(widget.dec!),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "$newPrice",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 25),
                      //   color: Colors.white,
                      //   child:
                      //   Row(
                      //     children: [
                      //       Container(
                      //           height: 40,
                      //           width: 40,
                      //           margin: EdgeInsets.only(left: 8),
                      //           child: InkWell(
                      //             onTap: () {},
                      //             child: Text(
                      //               "-",
                      //               style: TextStyle(
                      //                   color: AppColors.Primaryblue,
                      //                   fontSize: 30,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           )),
                      //       Container(
                      //         height: 40,
                      //         width: 40,
                      //         child: InkWell(
                      //           onTap: () {},
                      //           child: Icon(
                      //             Icons.add,
                      //             color: AppColors.Primaryblue,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: ParimaryButton(
                      title: "Add To Card",
                      color: AppColors.Primaryblue,
                      OnPressad: () {
                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.INFO,
                                btnOkOnPress: () {
                                  counterClass.setCounter();
                                  AuthServices.MyCard(
                                      widget.name!,
                                      widget.price!,
                                      widget.dec!,
                                      widget.image!,
                                      widget.Email,
                                      context);
                                },
                                btnCancelOnPress: () {},
                                title: "Add To Card",
                                desc: "Want To Add To Card This Product")
                            .show();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void increase() {
    count++;
  }

  void decrease() {
    count--;
  }
}
