// ignore_for_file: unnecessary_new, unused_local_variable, unused_field, prefer_const_constructors

import 'package:final_project_app/controller/language_controller.dart';
import 'package:final_project_app/sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:final_project_app/auth/registration.dart';
import 'package:final_project_app/log_bloc.navigation_bloc/navigation_bloc.dart';
import 'package:final_project_app/translations/local-keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget with NavigationStates {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//form key
  final _formkey = GlobalKey<FormState>();

//editing controller

  final TextEditingController emailcontroller = new TextEditingController();

  final TextEditingController passwordcontroller = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageController>();
    //email field
    context.watch<LanguageController>();
    final emailField = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        emailcontroller.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("please enter email field");
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.log_email_hint.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordcontroller,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("please enter password field");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter valid password (min 6 character)");
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.log_password_hint.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //button field
    final loginbutton = Material(
        elevation: 5,
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailcontroller.text, passwordcontroller.text);
          },
          child: Text(
            LocaleKeys.login_button.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/logo.JPEG",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        emailField,
                        SizedBox(
                          height: 25,
                        ),
                        passwordField,
                        SizedBox(
                          height: 35,
                        ),
                        loginbutton,
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(LocaleKeys.ask_account.tr()),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()));
                              },
                              child: Text(
                                LocaleKeys.sinup_link.tr(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              )),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login successfuly"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SideBarLayout())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
