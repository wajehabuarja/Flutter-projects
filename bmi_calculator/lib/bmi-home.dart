import 'dart:math';

import 'package:bmi_calculator/bmi-result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMIHome extends StatefulWidget {
  const BMIHome({super.key});

  @override
  State<BMIHome> createState() => _homeState();
}

class _homeState extends State<BMIHome> {
  bool isMale = true;
  double height = 120;
  int wieght = 40;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bmi Calculator",
          style: TextStyle(
            color: Color(0xFF9FF0BD),
          ),
        ),
        backgroundColor: Color(0xFF353535),
      ),
      body: Container(
        color: Color(0xFF353535),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    //male
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isMale
                                  ? Color(0xFF202020)
                                  : Color(0xFF9FF0BD)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.male,
                                size: 70,
                                color: isMale
                                    ? Color(0xFF9FF0BD)
                                    : Color(0xFF202020),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "MALE",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isMale
                                      ? Color(0xFF9FF0BD)
                                      : Color(0xFF202020),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //female
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: !isMale
                                  ? Color(0xFF202020)
                                  : Color(0xFF9FF0BD)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.female,
                                size: 70,
                                color: isMale
                                    ? Color(0xFF202020)
                                    : Color(0xFF9FF0BD),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "FEMALE",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isMale
                                      ? Color(0xFF202020)
                                      : Color(0xFF9FF0BD),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //height
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF9FF0BD),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "HEIGHT",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "${height.round()}",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "CM",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        activeColor: Color(0xFF202020),
                        value: height,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        },
                        max: 272,
                        min: 62,
                      )
                    ],
                  ),
                ),
              ),
            ),
            //age and wieght
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    //age
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF9FF0BD),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "AGE",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${age}",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (age > 1) age--;
                                    });
                                  },
                                  heroTag: 'age--',
                                  mini: true,
                                  child: Icon(
                                    Icons.remove,
                                    color: Color(0xFF9FF0BD),
                                  ),
                                  backgroundColor: Color(0xFF202020),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  heroTag: 'age++',
                                  mini: true,
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xFF9FF0BD),
                                  ),
                                  backgroundColor: Color(0xFF202020),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //wieght
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF9FF0BD),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "WEIGHT",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${wieght}",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (wieght > 1) wieght--;
                                    });
                                  },
                                  heroTag: 'wieght--',
                                  mini: true,
                                  child: Icon(
                                    Icons.remove,
                                    color: Color(0xFF9FF0BD),
                                  ),
                                  backgroundColor: Color(0xFF202020),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      wieght++;
                                    });
                                  },
                                  heroTag: 'wieght++',
                                  mini: true,
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xFF9FF0BD),
                                  ),
                                  backgroundColor: Color(0xFF202020),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //calc btn
            Container(
              color: Color(0xFF202020),
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                onPressed: () {
                  var result = wieght / pow(height / 100, 2);
                  print(result.toStringAsFixed(1));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BMIResult(
                        result: result,
                        isMale: isMale,
                        age: age,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Calculate",
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
