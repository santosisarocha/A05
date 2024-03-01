import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(AnimatedContainerApp());
}

class AnimatedContainerApp extends StatefulWidget {
  @override
  State<AnimatedContainerApp> createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Animated Container App"),
          backgroundColor: Colors.cyan,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedContainer(
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: _borderRadius,
                ),
                duration: const Duration(milliseconds: 500), // Reduzimos a duração da animação
                curve: Curves.easeInOut, // Alteramos a curva de animação
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateContainer,
              child: Text('Alterar Container'),
            ),
            SnackBarButton(),
          ],
        ),
      ),
    );
  }

  void _updateContainer() {
    final random = Random();
    setState(() {
      _height = random.nextInt(200).toDouble() + 50;
      _width = random.nextInt(200).toDouble() + 50;
      _color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }
}

class SnackBarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final snackBar = SnackBar(
          content: const Text('Yay! A SnackBar!'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: const Text('Show SnackBar'),
    );
  }
}
