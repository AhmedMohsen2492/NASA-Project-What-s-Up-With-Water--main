import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'Login.dart';
import 'Home.dart';
import 'Welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.routeName : (_) => WelcomeScreen() ,
        LoginScreen.routeName : (_) => LoginScreen() ,
        SignUpScreen.routeName : (_) => SignUpScreen(),
        HomeScreen.routeName : (_) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,   // This will widget will be created in next step
    );
  }


}
