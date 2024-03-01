import 'package:flutter/material.dart';

void main() {
  runApp(ElectricityCalculatorApp());
}

class ElectricityCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _consumptionController = TextEditingController();
  final double kWPrice = 0.65;
  double totalBill = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de contas de eletricidade'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _consumptionController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Consumo (kWh)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateBill();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Fatura total'),
                      content: Text('O valor total da fatura é R\$${totalBill.toStringAsFixed(2)}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Fechar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBill() {
    double consumption = double.tryParse(_consumptionController.text) ?? 0.0;
    totalBill = consumption * kWPrice;
  }
}
