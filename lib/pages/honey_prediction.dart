import 'package:flutter/material.dart';

class MilkPresiciton extends StatelessWidget {
  final String predictValue;
  final String phValue;
  final String conductValue;
  MilkPresiciton(
      {Key? key,
      required this.predictValue,
      required this.phValue,
      required this.conductValue})
      : super(key: key);
  var predictionText1 = '';
  var predictionText2 = '';

  @override
  Widget build(BuildContext context) {
    if (predictValue == ("Good")) {
      predictionText1 = "1.The honey has Good Quality";
      predictionText2 =
          "2.The Product is Free From Any Mixiture And contamination";
    } else {
      predictionText1 = "1.The Honey is on Bad Quality";
      predictionText2 = "2.the Honey has high Water Mixiture";
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/milk_pred.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      predictValue,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        predictionText1,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      predictionText2,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "ThankYou For Using Our Application",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w200),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
