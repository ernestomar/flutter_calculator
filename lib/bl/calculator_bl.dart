import 'package:math_expressions/math_expressions.dart';

class CalculatorBl {
  var userInput = '';
  var answer = '0';
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

  String onKeyPress(int keyIndex) {
    var isButtonEqual = false;
    if (keyIndex == 0) {
      // CLEAR BUTTON
      userInput = '';
      answer = '0';
    } else if (keyIndex == 3) {
      // DEL BUTTON
      userInput = userInput.substring(0, userInput.length - 1);
    } else if (keyIndex == 18) {
      // EQUAL BUTTON
      isButtonEqual = true;
      equalPressed();
    } else {
      // LOS DEMAS BOTONES
      userInput += buttons[keyIndex];
    }
    print("En onkeypress: $keyIndex - $answer - $userInput");
    return isButtonEqual ? answer : userInput;
  }

  /// Este metodo se invoca cuando se apreta al boton igual, luego se calcula
  /// con la libreria math_expressions el valor del computo.
  /// Este metodo se invoca dentro de un setState()
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
