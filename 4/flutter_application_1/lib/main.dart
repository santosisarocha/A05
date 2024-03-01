import 'package:flutter/material.dart';

void main() {
  runApp(MachineConsumptionApp());
}

class MachineConsumptionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MachineListPage(),
    );
  }
}

class MachineListPage extends StatefulWidget {
  @override
  _MachineListPageState createState() => _MachineListPageState();
}

class _MachineListPageState extends State<MachineListPage> {
  List<Machine> machines = [
    Machine(name: 'Torno', power: 1000), 
    Machine(name: 'Fresa', power: 1500),
    Machine(name: 'Furadeira', power: 800),
  ];

  double electricityPrice = 0.65; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Consumo de Energia'),
      ),
      body: ListView.builder(
        itemCount: machines.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(machines[index].name),
            subtitle: Text('Potência: ${machines[index].power} W'),
            trailing: IconButton(
              icon: Icon(Icons.calculate),
              onPressed: () {
                _showConsumptionDialog(machines[index]);
              },
            ),
          );
        },
      ),
    );
  }

  void _showConsumptionDialog(Machine machine) {
    double timeUsed = 0.0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Calcular Consumo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Tempo de Uso (horas)'),
                onChanged: (value) {
                  timeUsed = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                double consumption = machine.calculateConsumption(timeUsed);
                double totalCost = consumption * electricityPrice; 
                _showResultDialog(machine, consumption, totalCost);
                Navigator.of(context).pop();
              },
              child: Text('Calcular'),
            ),
          ],
        );
      },
    );
  }

  void _showResultDialog(Machine machine, double consumption, double totalCost) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Consumo para ${machine.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Consumo Total: ${consumption.toStringAsFixed(2)} kWh'),
              SizedBox(height: 10),
              Text('Custo Total: R\$ ${totalCost.toStringAsFixed(2)}'),
            ],
          ),
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
  }
}

class Machine {
  final String name;
  final int power; 

  Machine({required this.name, required this.power});

  double calculateConsumption(double timeUsed) {
    return power * timeUsed / 1000; 
  }
}
