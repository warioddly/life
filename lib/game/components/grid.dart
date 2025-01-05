import 'dart:async';
import 'dart:math' hide log;
import 'dart:ui';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:life/game/bloc/config_bloc.dart';
import 'package:life/game/core/configs.dart';
import 'package:life/game/game.dart';
import 'block.dart';
import 'package:flame/events.dart';
import 'package:flame/components.dart' hide Block;

class LifeComponent extends PositionComponent
    with TapCallbacks, HasGameReference<LifeGame> {

  LifeGrid _grid = LifeGrid(0, 0, 0);
  var _dtSum = 0.0;

  ConfigModel get state => game.configBloc.state.model;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _initialize();

    add(FlameBlocListener(
      bloc: game.configBloc,
      onNewState: (ConfigState state) {

        if (state.state is ConfigUpdateGridState) {
          _initialize(
            grid: state.model.grid,
            cellSize: state.model.cellSize,
          );
        }

      },
    ));

  }


  void _initialize({
    int grid = Configs.grid,
    double cellSize = Configs.cellSize,
  }) {

    size = Vector2(
        grid.toDouble() * cellSize,
        grid.toDouble() * cellSize
    );
    position = (game.size - size) / 2;

    _grid = LifeGrid(
      grid,
      grid,
      cellSize,
    );

    for (final items in _grid.blocks) {
      for (final item in items) {
        if (Random().nextInt(2) == 1) {
          item.toggle();
        }
      }
    }

  }

  @override
  void update(double dt) {
    _grid.update();
  }

  @override
  void render(Canvas canvas) {
    _grid.render(canvas);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final i = (event.localPosition.x / state.cellSize).floor();
    final j = (event.localPosition.y / state.cellSize).floor();
    _grid.blocks[i][j].toggle();
  }

  @override
  void updateTree(double dt) {
    if (state.paused) {
      return;
    }
    final speed = 1 / state.speed;
    _dtSum += dt;
    if(_dtSum > speed) {
      super.updateTree(speed);
      _dtSum -= speed;
    }
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
        else if (neighbors == 3) {
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