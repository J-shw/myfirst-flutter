import 'package:flutter/material.dart';
import 'compass_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detailed Compass App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const CompassScreen(),
    );
  }
}

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  double _currentAngle = 40.0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compass'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4.0,
              shape: const CircleBorder(),
              color: colorScheme.surfaceContainerHighest,
              child: SizedBox(
                width: 250,
                height: 250,
                child: CustomPaint(
                  painter: CompassPainter(
                    angle: _currentAngle,
                    colorScheme: colorScheme,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Heading: ${_currentAngle.toStringAsFixed(1)}°',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Slider(
              min: 0,
              max: 360,
              value: _currentAngle,
              onChanged: (newValue) {
                setState(() {
                  _currentAngle = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}