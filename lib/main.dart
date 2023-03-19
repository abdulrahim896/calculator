import 'package:calculator/buttonsdisplay.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const Calculator(),
        backgroundColor: Colors.teal[900],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(115, 48, 40, 40),
          title: const Text(
            "Calculator",
            style: TextStyle(color: Colors.yellow, fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userinput = "";
  var useroutput = "";
  List<String> buttons = [
    "C",
    "Del",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "00",
    "0",
    ".",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
                color: Colors.teal[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        userinput,
                        style: const TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        useroutput,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ))),
        Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, index) {
                  if (index == 0) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userinput = "";
                          useroutput = "";
                        });
                      },
                      buttontext: buttons[index].toString(),
                      buttoncolor: Colors.red,
                      textcolor: Colors.black,
                    );
                  } else if (index == 1) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userinput =
                              userinput.substring(0, userinput.length - 1);
                        });
                      },
                      buttoncolor: Colors.green,
                      buttontext: buttons[index].toString(),
                      textcolor: Colors.black,
                    );
                  } else if (buttons[index].toString() == "=") {
                    return MyButton(
                      buttoncolor: Colors.blue,
                      buttontapped: equalclicked,
                      textcolor: Colors.black,
                      buttontext: buttons[index].toString(),
                    );
                  } else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userinput += buttons[index].toString();
                        });
                      },
                      buttontext: buttons[index].toString(),
                      buttoncolor: operatorcolors(index)
                          ? Colors.grey[300]
                          : Colors.yellow[200],
                      textcolor: operatorcolors(index)
                          ? Colors.black
                          : Colors.brown[600],
                    );
                  }
                },
              ),
            )),
      ],
    );
  }

  operatorcolors(index) {
    if (buttons[index].toString() == "%" ||
        buttons[index].toString() == "/" ||
        buttons[index].toString() == "*" ||
        buttons[index].toString() == "-" ||
        buttons[index].toString() == "+") {
      return true;
    } else {
      return false;
    }
  }

  equalclicked() {
    Parser p = Parser();
    Expression exp = p.parse(userinput);
    ContextModel cm = ContextModel();
    double evals = exp.evaluate(EvaluationType.REAL, cm);
    useroutput = evals.toString();
    setState(() {});
  }
}
