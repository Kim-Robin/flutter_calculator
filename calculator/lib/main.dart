import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.red),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "<-") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;

        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else if (buttonText == "10%") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;

        double temp = double.tryParse(equation);
        equation = equation + "+" + (temp * 0.1).toString();
        buttonPressed("=");
      } else if (buttonText == "15%") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;

        double temp = double.tryParse(equation);
        equation = equation + "+" + (temp * 0.15).toString();
        buttonPressed("=");
      } else if (buttonText == "18%") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;

        double temp = double.tryParse(equation);
        equation = equation + "+" + (temp * 0.18).toString();
        buttonPressed("=");
      } else if (buttonText == "20%") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;

        double temp = double.tryParse(equation);
        equation = equation + "+" + (temp * 0.2).toString();
        buttonPressed("=");
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttoneHeight, Color buttonColor) {
    return Container(
        margin: EdgeInsets.all(2.0),
        height: MediaQuery.of(context).size.height * 0.11 * buttoneHeight,
        // color: buttonColor,
        child: FlatButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          shape: new CircleBorder(),
          color: buttonColor,
        )

        // child: FlatButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.0),
        //     side: BorderSide(
        //         color: Colors.black, width: 1, style: BorderStyle.solid),
        //   ),
        //   padding: EdgeInsets.all(16.0),
        //   onPressed: () => buttonPressed(buttonText),
        //   child: Text(
        //     buttonText,
        //     style: TextStyle(
        //       fontSize: 30.0,
        //       fontWeight: FontWeight.normal,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize)),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("10%", 1, Colors.green),
                        buildButton("15%", 1, Colors.green),
                        buildButton("18%", 1, Colors.green),
                        // buildButton("20%", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("<-", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("20%", 1, Colors.green),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: SizedBox(
//         width: 70.0,
//         height: 70.0,
//         child: FloatingActionButton(
//           onPressed: _incrementCounter,
//           tooltip: "Increment",
//           child: Text("1"),
//         ),
//       ),

//       // floatingActionButton: FloatingActionButton(
//       //   // onPressed: _incrementCounter,
//       //   // tooltip: 'Increment',
//       //   child: Text("1"),
//       // ),
//     );
//   }
// }
