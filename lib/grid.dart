import 'dart:developer';
import 'dart:math' hide log;
import 'dart:ui';
import 'package:life/configs.dart';

import 'block.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart' hide Block;

class LifeComponent extends PositionComponent with TapCallbacks {

  late final LifeGrid grid;

  @override
  void onLoad() {

    size = Vector2(
        Configs.rows.toDouble() * Configs.cellSize,
        Configs.columns.toDouble() * Configs.cellSize
    );

    grid = LifeGrid(
        Configs.rows,
        Configs.columns,
        Configs.cellSize,
    );

    for (final items in grid.blocks) {
      for (final item in items) {
        if (Random().nextInt(2) == 1) {
          item.toggle();
        }
      }
    }

  }

  @override
  void update(double dt) {
    grid.update();
  }

  @override
  void render(Canvas canvas) {
    grid.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final i = (event.localPosition.x / Configs.cellSize).floor();
    final j = (event.localPosition.y / Configs.cellSize).floor();
    grid.blocks[i][j].toggle();
  }

}

class LifeGrid {

  final int rows;
  final int columns;
  final double cellSize;
  final List<List<Block>> blocks;

  LifeGrid(this.rows, this.columns, this.cellSize) : blocks = List.generate(rows, (i) => List.generate(columns, (j) => Block()));

  void update() {

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {

        final block = blocks[i][j];
        final neighbors = _countNeighbors(i, j);

        if (block.isAlive && (neighbors < 2 || neighbors > 3)) {
          block.setDead();
        }
        else if (neighbors == 3){
          block.setAlive();
        }

      }
    }

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        blocks[i][j].update();
      }
    }

  }

  int _countNeighbors(int i, int j) {
    int count = 0;
    for (int x = i - 1; x <= i + 1; x++) {
      for (int y = j - 1; y <= j + 1; y++) {
        if (x == i && y == j) {
          continue;
        }
        if (x >= 0 && x < rows && y >= 0 && y < columns) {
          if (blocks[x][y].isAlive) {
            count++;
          }
        }
      }
    }
    return count;
  }

  void render(Canvas canvas) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        blocks[i][j].render(canvas, i * cellSize, j * cellSize, cellSize);
      }
    }
  }

}