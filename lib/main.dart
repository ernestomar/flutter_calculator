import 'package:calculator/bloc/bloc_provider.dart';
import 'package:calculator/bloc/calculator_bloc.dart';
import 'package:flutter/material.dart';

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
    'C', //0
    '+/-', //1
    '%', //2
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
    final calculatorBloc = BlocProvider.of<CalculatorBloc>(context);
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
                    // La calculadora tiene dos textos.
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        // En letra pqequeña para mostrar la formula
                        userInput,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: _buildAnswerText(calculatorBloc),
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
                    return MyButton(
                      buttontapped: () {
                        print("Boton presionado $index");
                        calculatorBloc.pressKeySink.add(index);
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
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

  Widget _buildAnswerText(CalculatorBloc bloc) {
    return StreamBuilder<String?>(
      stream: bloc.calculatorStream,
      builder: (context, snapshot) {
        print("En StreamBuilder: ${snapshot.data}");
        var answerText = "0";
        if (snapshot.data != null) {
          answerText = snapshot.data.toString();
        }
        return Text(
          // En letra grande para mostrar el resultado
          answerText,
          style: const TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
