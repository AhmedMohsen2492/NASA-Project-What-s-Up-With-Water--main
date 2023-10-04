import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_combo_box/flutter_combo_box.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'Home.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "SignUpForm" ;

  @override
  SignUp createState() => SignUp();
}

class SignUp extends State<SignUpScreen> {

  TextEditingController First_Name = TextEditingController();
  TextEditingController Last_Name = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController PassWord = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  var database = FirebaseDatabase.instance.ref();
  String userType = "";
  String Gender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.45,
                      child: TextFormField(
                        controller: First_Name,
                        decoration: InputDecoration(
                          label: Align(
                            alignment: Alignment.center,
                            // Align however you like (i.e .centerRight, centerLeft)
                            child: Text("First Name"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Missing First Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.45,
                      child: TextFormField(
                        controller: Last_Name,
                        decoration: InputDecoration(
                          label: Align(
                            alignment: Alignment.center,
                            // Align however you like (i.e .centerRight, centerLeft)
                            child: Text("Last Name"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: PhoneNumber,
                  decoration: InputDecoration(
                    label: Text("Phone Number"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Missing Phone Number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: Email,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Missing Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: _isHidden,
                  controller: PassWord,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Missing Password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: _isHidden,
                  controller: ConfirmPassword,
                  decoration: InputDecoration(
                    label: Text("Confirm Password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (text) {
                    if (text != PassWord.text) {
                      return 'Not The Same Password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: ()  {
                    signUpButton();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: new SizedBox(
                    width: 400,
                    height: 20,
                    child: Text(
                      "Already Have Account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void signUpButton() async{
    if (_formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: Email.text,
          password: PassWord.text,
        );
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("The Password provided is too weak"),
                );
              });
        } else if (e.code == 'email-already-in-use') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("The account already exist for that email!"),
                );
              });
        }
      } catch (e) {
        print(e);
      }

    }
  }


}
