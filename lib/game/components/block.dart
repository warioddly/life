import 'package:flutter/material.dart' show Colors, Canvas, Paint, Rect;

class Block {

  bool isAlive = false;
  bool willBeAlive = false;

  void update() {
    isAlive = willBeAlive;
  }

  void setAlive() {
    willBeAlive = true;
  }

  void setDead() {
    willBeAlive = false;
  }

  void toggle() {
    willBeAlive = !willBeAlive;
  }

  void render(Canvas canvas, double x, double y, double size) {
    final paint = Paint()
      ..color = isAlive ? Colors.black : Colors.white;
    canvas.drawRect(Rect.fromLTWH(x, y, size, size), paint);
  }

}