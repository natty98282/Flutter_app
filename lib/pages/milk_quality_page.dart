import 'package:final_project_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:final_project_app/pages/milk_prediction.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../generated/locale_keys.g.dart';
import 'dart:math';

class MyOrdersPage extends StatefulWidget with NavigationStates {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final _formkey = GlobalKey<FormState>();
  final conductivitycotroller = new TextEditingController();
  final phcontroller = new TextEditingController();
  final lightabsorptioncontroller = new TextEditingController();
  final value1controller = new TextEditingController();
  final value2controller = new TextEditingController();

  var predValue = "";
  @override
  void initState() {
    super.initState();
    predValue = "click predict button";
  }

  Future<void> predData() async {
    final interpreter = await Interpreter.fromAsset('Quality.tflite');
    var input = [
      double.parse(conductivitycotroller.text),
      double.parse(phcontroller.text),
      double.parse(lightabsorptioncontroller.text),
      double.parse(value1controller.text),
      double.parse(value2controller.text),
    ];
    // ignore: deprecated_member_use
    var output = List<int>.filled(1 * 2, 0).reshape([1, 2]);

    interpreter.run(input, output);
    for (var i = 0; i < output.length; i++) {
      List currentElement = output[i];
      print(currentElement);
      print(currentElement.length);
      var largestGeekValue = currentElement[0];
      print(largestGeekValue);
      for (var j = 0; j < currentElement.length; j++) {
        if (currentElement[j] > largestGeekValue) {
          largestGeekValue = currentElement[j];
          print(largestGeekValue);
          int prediction = j;
          if (prediction == 0) {
            String out = "Bad";
            print(out);
            print(output);
            setState(() {
              predValue = out;
            });
          } else {
            String out = "Good";
            print(out);
            print(output);
            setState(() {
              predValue = out;
            });
          }
        } else {
          String out = "Bad";
          print(out);
          print(output);
          setState(() {
            predValue = out;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final coductivityfield = TextFormField(
      autofocus: false,
      controller: conductivitycotroller,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        conductivitycotroller.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp('0-9');
        if (value!.isEmpty) {
          return ("this field is requered");
        }

        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.input),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.milk_snf_value.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //SecondName field
    final phfield = TextFormField(
      autofocus: false,
      controller: phcontroller,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        phcontroller.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp('0-9');
        if (value!.isEmpty) {
          return ("this field is requered");
        }

        return null;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.input),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.milk_gas_value.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //email field
    final lightfield = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      controller: lightabsorptioncontroller,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        lightabsorptioncontroller.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp('0-9');
        if (value!.isEmpty) {
          return ("this field is requered");
        }

        return null;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.input),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.milk_light_value.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //password field
    final value1field = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      controller: value1controller,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        value1controller.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp('0-9');
        if (value!.isEmpty) {
          return ("this field is requered");
        }

        return null;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.input),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.milk_conductivity_input.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //confirmation field
    final confirmpasswordField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.number,
      controller: value2controller,
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        value2controller.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp('0-9');
        if (value!.isEmpty) {
          return ("this field is requered");
        }

        return null;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.input),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.milk_ph_input.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final signupbutton = Material(
      elevation: 5,
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            predData();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MilkPresiciton(
                          predictValue: predValue,
                          phValue: '',
                          conductValue: '',
                        )));
          }
        },
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          LocaleKeys.milk_predict_button.tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Milk Quality Cheking Page",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.w300),
                    ),
                    const Text(
                      "Fill The parameters and Check the Quality",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w200),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    coductivityfield,
                    const SizedBox(
                      height: 20,
                    ),
                    phfield,
                    const SizedBox(
                      height: 20,
                    ),
                    lightfield,
                    const SizedBox(
                      height: 20,
                    ),
                    value1field,
                    const SizedBox(
                      height: 20,
                    ),
                    confirmpasswordField,
                    const SizedBox(
                      height: 55,
                    ),
                    signupbutton,
                    const SizedBox(
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
