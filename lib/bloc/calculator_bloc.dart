import 'dart:async';

import 'package:calculator/bl/calculator_bl.dart';

import 'bloc.dart';

class CalculatorBloc implements Bloc {
  final _calculatorBl = CalculatorBl();

  final _calculatorController = StreamController<int>();

  Sink<int?> get pressKeySink => _calculatorController.sink;

  late Stream<int?> calculatorStream;

  CalculatorBloc() {
    print("SE INVOCA CONSTRUCTOR");
    calculatorStream = _calculatorController.stream.asyncMap((key) {
      print("En el Bloc $key");
      return _calculatorBl.onKeyPress(key);
    });
  }

  @override
  void dispose() {
    _calculatorController.close();
  }
}
