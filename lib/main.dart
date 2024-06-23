import 'package:flutter/material.dart';

void main() => runApp(IMCCalculatorApp());

class IMCCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IMCHomePage(),
    );
  }
}

class IMCHomePage extends StatefulWidget {
  @override
  _IMCHomePageState createState() => _IMCHomePageState();
}

class _IMCHomePageState extends State<IMCHomePage> {
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  String _resultado = "";

  void _calcularIMC() {
    setState(() {
      final peso = double.tryParse(_pesoController.text);
      final altura = double.tryParse(_alturaController.text);

      if (peso == null || altura == null || peso <= 0 || altura <= 0) {
        _resultado = "Por favor, insira valores válidos para peso e altura.";
      } else {
        final imc = peso / (altura * altura);
        String classificacao;
        if (imc < 18.5) {
          classificacao = "você está abaixo do peso";
        } else if (imc >= 18.5 && imc < 24.9) {
          classificacao = "você está normal";
        } else if (imc >= 25 && imc < 29.9) {
          classificacao = "você está acima do peso";
        } else {
          classificacao = "Obesidade";
        }
        _resultado = "Seu IMC é ${imc.toStringAsFixed(2)}\n$classificacao";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (m)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularIMC,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 20),
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }
}
