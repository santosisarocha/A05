import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Student {
  String name;
  List<double> grades = [0, 0, 0];

  Student(this.name);
}

class Discipline {
  String name;
  String serviceType;
  double serviceValue;

  Discipline(this.name, this.serviceType, this.serviceValue);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/discipline': (context) => DisciplineScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Student> students = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro do cliente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nome:'),
              onSubmitted: (value) {
                students.add(Student(value));
                Navigator.pushNamed(context, '/discipline');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DisciplineScreen extends StatelessWidget {
  final List<Discipline> disciplines = [
    Discipline('automação', 'Projeto', 200.0),
    Discipline('administração', 'Consultoria', 150.0),
    Discipline('medico', 'Elaboração de Laudo', 180.0),
    Discipline('eletrico', 'Projeto', 190.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas das Disciplinas'),
      ),
      body: ListView.builder(
        itemCount: disciplines.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(disciplines[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tipo de Serviço: ${disciplines[index].serviceType}'),
                Text('Valor do Serviço: R\$ ${disciplines[index].serviceValue.toStringAsFixed(2)}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GradesScreen(discipline: disciplines[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GradesScreen extends StatefulWidget {
  final Discipline discipline;

  GradesScreen({required this.discipline});

  @override
  _GradesScreenState createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  double calculateAverage() {
    double sum = double.parse(_controller1.text) +
        double.parse(_controller2.text) +
        double.parse(_controller3.text);
    return sum / 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.discipline.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nota 1'),
            ),
            TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nota 2'),
            ),
            TextField(
              controller: _controller3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Nota 3'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Resultado'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Média: ${calculateAverage().toStringAsFixed(2)}'),
                          Text('Aprovado: ${calculateAverage() >= 7.0 ? 'Sim' : 'Não'}'),
                          Text('Tipo de Serviço: ${widget.discipline.serviceType}'),
                          Text('Valor do Serviço: R\$ ${widget.discipline.serviceValue.toStringAsFixed(2)}'),
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
              },
              child: Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
