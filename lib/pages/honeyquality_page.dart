import 'package:final_project_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:final_project_app/pages/honey_prediction.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../generated/locale_keys.g.dart';

class MakeDashboardItems extends StatefulWidget with NavigationStates {
  const MakeDashboardItems({Key? key}) : super(key: key);

  @override
  _MakeDashboardItemsState createState() => _MakeDashboardItemsState();
}

class _MakeDashboardItemsState extends State<MakeDashboardItems> {
  final _formkey = GlobalKey<FormState>();
  final conductivitycotroller = TextEditingController();
  final phcontroller = TextEditingController();
  final lightabsorptioncontroller = TextEditingController();
  final value1controller = TextEditingController();

  var predValue = "";
  @override
  void initState() {
    super.initState();
    predValue = "click predict button";
  }

  Future<void> predData() async {
    final interpreter = await Interpreter.fromAsset('honeyss.tflite');
    var input = [
      double.parse(conductivitycotroller.text),
      double.parse(phcontroller.text),
      double.parse(lightabsorptioncontroller.text),
      double.parse(value1controller.text),
    ];
    // ignore: deprecated_member_use
    var output = List<int>.filled(1 * 2, 0).reshape([1, 2]);

    interpreter.run(input, output);
    var predvalue1 = output.toString();
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
    setState(() {
      predValue = predvalue1;
    });
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
          prefixIcon: Icon(Icons.input),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.milk_light_value.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //email field
    final lightfield = TextFormField(
      autofocus: false,
      controller: lightabsorptioncontroller,
      keyboardType: TextInputType.number,
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
          prefixIcon: Icon(Icons.input),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.milk_ph_input.tr(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //password field
    final value1field = TextFormField(
      autofocus: false,
      controller: value1controller,
      keyboardType: TextInputType.number,
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
          prefixIcon: Icon(Icons.input),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: LocaleKeys.milk_conductivity_input.tr(),
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
                          predictValue: '',
                          phValue: '',
                          conductValue: '',
                        )));
          }
        },
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                        const Text(
                          "Honey Quality Cheking Page",
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
