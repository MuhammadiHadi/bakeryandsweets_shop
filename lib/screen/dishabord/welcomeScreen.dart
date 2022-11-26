import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/auth/loginScreen.dart';
import 'package:bakeryandsweets_shop/screen/auth/screenSignup.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Image.asset("assets/images/bakeryimage.png"),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 30),
                    child: Text("Welcome!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        )),
                  ),
                  ParimaryButton(
                    title: "LOG_IN",
                    color: Colors.blueGrey,
                    OnPressad: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  ParimaryButton(
                    title: "SIGN_IN",
                    color: Colors.blueGrey,
                    OnPressad: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Screen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
