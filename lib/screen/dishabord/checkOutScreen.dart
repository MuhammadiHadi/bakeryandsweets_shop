import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/auth/authServices.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? dec;
  String? Email;

  CheckOutScreen({
    this.image,
    this.name,
    this.price,
    this.dec,
    this.Email,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CheckOut"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: Text(
                  "Enter Your Data",
                  style: TextStyle(
                      color: AppColors.Primaryblue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: AppColors.Primaryblack,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    label: Text("Full Name"),
                    prefixIcon: Icon(Icons.person),
                  ),
                  controller: namecontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    label: Text("Phone No"),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  controller: phonecontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    label: Text("Address"),
                    prefixIcon: Icon(Icons.map),
                  ),
                  controller: addresscontroller,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                "Payment",
                style: TextStyle(color: AppColors.Primaryblue, fontSize: 25),
              ),
              Divider(
                color: AppColors.Primaryblack,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset("assets/images/cash.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: ParimaryButton(
                  title: "Process",
                  color: AppColors.Primaryblue,
                  OnPressad: () {
                    AuthServices.CheckOut(
                        widget.name,
                        widget.price,
                        widget.dec,
                        widget.image,
                        widget.Email,
                        namecontroller.text,
                        phonecontroller.text,
                        addresscontroller.text,
                        context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
