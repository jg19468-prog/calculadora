import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "÷" || buttonText == "×") {
        _num1 = double.tryParse(_output) ?? 0;
        _operand = buttonText;
        _currentInput = "";
      } else if (buttonText == ".") {
        if (!_currentInput.contains(".")) {
          _currentInput += buttonText;
          _output = _currentInput;
        }
      } else if (buttonText == "=") {
        _num2 = double.tryParse(_currentInput.isEmpty ? _output : _currentInput) ?? 0;
        
        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "×":
            _output = (_num1 * _num2).toString();
            break;
          case "÷":
            _output = _num2 != 0 ? (_num1 / _num2).toString() : "Error";
            break;
        }

        // Limpiar decimales innecesarios (ej. 5.0 -> 5)
        if (_output.endsWith(".0")) {
          _output = _output.substring(0, _output.length - 2);
        }
        
        _num1 = 0;
        _num2 = 0;
        _operand = "";
        _currentInput = _output; // Permite seguir operando con el resultado
      } else {
        // Ingreso de números
        if (_currentInput == "0" && buttonText != ".") {
          _currentInput = buttonText;
        } else {
          _currentInput += buttonText;
        }
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String text, {Color? textColor, Color? bgColor, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? Colors.grey[850],
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            padding: const EdgeInsets.all(24.0),
          ),
          onPressed: () => _onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Pantalla de resultados
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Text(
                  _output,
                  style: const TextStyle(
                    fontSize: 72.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            
            // Teclado numérico
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton("C", textColor: Colors.black, bgColor: Colors.grey[400]),
                      _buildButton("()", textColor: Colors.black, bgColor: Colors.grey[400]), // Placeholder
                      _buildButton("%", textColor: Colors.black, bgColor: Colors.grey[400]),  // Placeholder
                      _buildButton("÷", textColor: Colors.white, bgColor: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("×", textColor: Colors.white, bgColor: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("-", textColor: Colors.white, bgColor: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("+", textColor: Colors.white, bgColor: Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton("0", flex: 2), // Botón más ancho para el 0
                      _buildButton("."),
                      _buildButton("=", textColor: Colors.white, bgColor: Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}