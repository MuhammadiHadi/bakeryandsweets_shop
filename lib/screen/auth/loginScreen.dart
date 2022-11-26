import 'package:bakeryandsweets_shop/Provider_class/passwordVisibily.dart';
import 'package:bakeryandsweets_shop/coustom_widget/parimaryButton.dart';
import 'package:bakeryandsweets_shop/screen/auth/authServices.dart';
import 'package:bakeryandsweets_shop/screen/auth/resetPasswordScreen.dart';
import 'package:bakeryandsweets_shop/screen/auth/screenSignup.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/bottomNavigatonScreen.dart';
import 'package:bakeryandsweets_shop/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> FormKey = GlobalKey();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  Future<void> singinwthgoogle() async {
    try {
      EasyLoading.show(status: "please wait");
      await _googleSignIn.signIn().then((value) {
        EasyLoading.dismiss();
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => BottomNavigatonScreen()));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordvisibilty =
        Provider.of<PasswordVisibilty>(context, listen: false);
    print("build");
    return Scaffold(
      body: Form(
        key: FormKey,
        child: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Email",
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.Primarywhite,
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: emailcontroller,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Consumer<PasswordVisibilty>(
                        builder: (context, value, child) {
                      return TextField(
                        obscureText: value.is_visible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          isDense: true,
                          filled: true,
                          fillColor: AppColors.Primarywhite,
                          suffixIcon: InkWell(
                            onTap: () {
                              passwordvisibilty.setVisibilty();
                            },
                            child: Icon(
                              value.is_visible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: passwordcontroller,
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ResetPasswordScreen()));
                          },
                          child: Text(
                            "ForgetPassword!",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // password(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ParimaryButton(
                      title: "LOGIN",
                      color: AppColors.PrimaryblueGrey,
                      OnPressad: () {
                        AuthServices.Login(emailcontroller.text,
                            passwordcontroller.text, context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.009,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account"),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.005,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Screen()));
                        },
                        child: Text(
                          "SingUp",
                          style: TextStyle(
                              color: AppColors.Primaryblue, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Divider(
                      color: AppColors.Primaryblue,
                      thickness: 1,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      singinwthgoogle();
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: AppColors.Primarywhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.Primaryblue, width: 0.8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   "Google",
                          //   style: TextStyle(fontSize: 20),
                          // ),
                          Image.asset(
                            "assets/images/google.png",
                            height: MediaQuery.of(context).size.height * 0.028,
                          ),
                          Text(
                            "oogle",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
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
