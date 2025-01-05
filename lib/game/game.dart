import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:life/game/bloc/config_bloc.dart';
import 'package:life/game/components/grid.dart';

class LifeGame extends FlameGame with PanDetector, ScrollDetector {

  LifeGame( {
    required this.configBloc,
    super.camera,
  });

  final ConfigBloc configBloc;

  @override
  FutureOr<void> onLoad() async {

    camera.viewfinder.position = size / 2;
    world.add(LifeComponent());

  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final vector2 = info.delta.global;
    camera.viewfinder.position += -vector2;
  }

  @override
  void onScroll(PointerScrollInfo info) {
    final dy = info.scrollDelta.global.y;
    final zoom = double.parse(camera.viewfinder.zoom.toStringAsFixed(1));
    if (zoom <= 5.0 && zoom >= 0.5) {
      final isNegative = dy < 0;
      camera.viewfinder.zoom += isNegative ? 0.1 : -0.1;
    }
  }

}

