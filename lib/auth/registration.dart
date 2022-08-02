// ignore_for_file: unnecessary_new, unused_field, prefer_const_constructors, import_of_legacy_library_into_null_safe
import 'package:final_project_app/translations/local-keys.g.dart';
import 'package:flutter/material.dart';
import 'package:final_project_app/log_bloc.navigation_bloc/navigation_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:final_project_app/controller/language_controller.dart';

class RegistrationScreen extends StatefulWidget with NavigationStates {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //create our formkey

  final _formkey = GlobalKey<FormState>();
  final firstnamecontroller = new TextEditingController();
  final secondnamecontroller = new TextEditingController();
  final emailcontroller = new TextEditingController();
  final passwordcontroller = new TextEditingController();
  final confirmpasswordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageController>();
    //firstname field
    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstnamecontroller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        firstnamecontroller.text = value!;
      },
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("please enter First Name field");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter valid Name(min 3 character)");
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.f_name.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //SecondName field
    final secondnameField = TextFormField(
      autofocus: false,
      controller: secondnamecontroller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        secondnamecontroller.text = value!;
      },
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("please enter First Name field");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter valid Name(min 3 character)");
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.l_name.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //email field
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
          hintText: LocaleKeys.input_email.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordcontroller,
      textInputAction: TextInputAction.next,
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
          hintText: LocaleKeys.input_password.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //confirmation field
    final confirmpasswordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: confirmpasswordcontroller,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        confirmpasswordcontroller.text = value!;
      },
      validator: (value) {
        if (confirmpasswordcontroller.text != passwordcontroller.text) {
          return ("password not match ");
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.confirm_password.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //signup button
    final signupbutton = Material(
      elevation: 5,
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () {},
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          LocaleKeys.sinup_link.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () {
            //move to root
            Navigator.of(context).pop();
          },
        ),
      ),
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
                          height: 55,
                        ),
                        firstnameField,
                        SizedBox(
                          height: 20,
                        ),
                        secondnameField,
                        SizedBox(
                          height: 20,
                        ),
                        emailField,
                        SizedBox(
                          height: 20,
                        ),
                        passwordField,
                        SizedBox(
                          height: 20,
                        ),
                        confirmpasswordField,
                        SizedBox(
                          height: 55,
                        ),
                        signupbutton,
                        SizedBox(
                          height: 15,
                        ),
                      ]),
                ),
              )),
        ),
      ),
    );
  }
}
