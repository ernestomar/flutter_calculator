import 'package:calculator/bloc/bloc_provider.dart';
import 'package:calculator/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'widgets/my_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: CalculatorBloc(),
        child: MaterialApp(
          title: 'Calculator',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var userInput = '';
  var answer = '';

  // Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    final calculatorBloc =
                        BlocProvider.of<CalculatorBloc>(context);
                    return MyButton(
                      buttontapped: () =>
                          calculatorBloc.pressKeySink.add(index),
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );

                    // // Clear Button
                    // if (index == 0) {
                    //   return MyButton(
                    //     buttontapped: () {
                    //       final calculatorBloc =
                    //           BlocProvider.of<CalculatorBloc>(context);
                    //       calculatorBloc.pressKeySink.add(index);
                    //       // setState(() {
                    //       //   userInput = '';
                    //       //   answer = '0';
                    //       // });
                    //     },
                    //     buttonText: buttons[index],
                    //     color: Colors.blue[50],
                    //     textColor: Colors.black,
                    //   );
                    // }

                    // // +/- button
                    // else if (index == 1) {
                    //   return MyButton(
                    //     buttonText: buttons[index],
                    //     color: Colors.blue[50],
                    //     textColor: Colors.black,
                    //   );
                    // }
                    // // % Button
                    // else if (index == 2) {
                    //   return MyButton(
                    //     buttontapped: () {
                    //       setState(() {
                    //         userInput += buttons[index];
                    //       });
                    //     },
                    //     buttonText: buttons[index],
                    //     color: Colors.blue[50],
                    //     textColor: Colors.black,
                    //   );
                    // }
                    // // Delete Button
                    // else if (index == 3) {
                    //   return MyButton(
                    //     buttontapped: () {
                    //       setState(() {
                    //         // Elimina el ultimo carcater
                    //         userInput =
                    //             userInput.substring(0, userInput.length - 1);
                    //       });
                    //     },
                    //     buttonText: buttons[index],
                    //     color: Colors.blue[50],
                    //     textColor: Colors.black,
                    //   );
                    // }
                    // // Equal_to Button
                    // else if (index == 18) {
                    //   return MyButton(
                    //     buttontapped: () {
                    //       setState(() {
                    //         equalPressed();
                    //       });
                    //     },
                    //     buttonText: buttons[index],
                    //     color: Colors.orange[700],
                    //     textColor: Colors.white,
                    //   );
                    // }

                    // //  other buttons
                    // else {
                    //   return MyButton(
                    //     buttontapped: () {
                    //       setState(() {
                    //         userInput += buttons[index];
                    //       });
                    //     },
                    //     buttonText: buttons[index],
                    //     color: isOperator(buttons[index])
                    //         ? Colors.blueAccent
                    //         : Colors.white,
                    //     textColor: isOperator(buttons[index])
                    //         ? Colors.white
                    //         : Colors.black,
                    //   );
                    // }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }

  /// Este metodo se utiliza en la construcción del Widget y lo unico que hace
  /// es determinar si es una operación mantemática o no
  /// a partir d es esto se cambia el color del botón
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  // /// Este metodo se invoca cuando se apreta al boton igual, luego se calcula
  // /// con la libreria math_expressions el valor del computo.
  // /// Este metodo se invoca dentro de un setState()
  // void equalPressed() {
  //   String finaluserinput = userInput;
  //   finaluserinput = userInput.replaceAll('x', '*');

  //   Parser p = Parser();
  //   Expression exp = p.parse(finaluserinput);
  //   ContextModel cm = ContextModel();
  //   double eval = exp.evaluate(EvaluationType.REAL, cm);
  //   answer = eval.toString();
  // }
}
