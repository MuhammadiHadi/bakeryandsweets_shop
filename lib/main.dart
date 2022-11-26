import 'package:bakeryandsweets_shop/Provider_class/bottomScreenClass.dart';
import 'package:bakeryandsweets_shop/Provider_class/counterClass.dart';
import 'package:bakeryandsweets_shop/Provider_class/passwordVisibily.dart';
import 'package:bakeryandsweets_shop/screen/dishabord/welcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  runApp(myapp());
}

class myapp extends StatefulWidget {
  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterClass(),
        ),
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilty(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomScreenClass(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[300],
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
