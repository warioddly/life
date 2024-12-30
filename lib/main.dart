import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const Life());
}

class Life extends StatefulWidget {
  const Life({super.key});

  @override
  State<Life> createState() => _LifeState();
}

class _LifeState extends State<Life> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: LifeGame(),
    );
  }
}

