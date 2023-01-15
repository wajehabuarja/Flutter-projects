import 'package:bmi_calculator/bmi-home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMIResult extends StatelessWidget {
  final double result;
  final bool isMale;
  final int age;

  BMIResult({
    required this.result,
    required this.isMale,
    required this.age,
  });

  Color changeColor() {
    var color;
    if (result < 18.5) {
      return color = Colors.lightBlue;
    } else if (result >= 18.5 && result <= 24.9) {
      return color = Colors.green;
    } else if (result >= 25 && result <= 29.9) {
      return color = Color.fromARGB(255, 255, 146, 138);
    } else if (result >= 30 && result <= 39.9) {
      return color = Colors.red;
    } else {
      return color = Color.fromARGB(255, 119, 8, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var state;
    if (result < 18.5) {
      state = 'Under Weight';
    } else if (result >= 18.5 && result <= 24.9) {
      state = 'Normal';
    } else if (result >= 25 && result <= 29.9) {
      state = 'Over Weight';
    } else if (result >= 30 && result <= 34.9) {
      state = 'Obesity ( Class I )';
    } else if (result >= 35 && result <= 39.9) {
      state = 'Obesity ( Class II )';
    } else {
      state = 'Extreme Obesity';
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF353535),
        title: const Text(
          "Your Result",
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFF9FF0BD),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFF353535),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                child: Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 63, 63, 63),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Gender: ${isMale ? 'Male' : 'Female'}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "Age: ${age}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${state}",
                          style: TextStyle(
                            color: changeColor(),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "${result.toStringAsFixed(1)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: const Color(0xFF202020),
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: const Text(
                  "Re Calculate",
                  style: TextStyle(color: Color(0xFF9FF0BD), fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
