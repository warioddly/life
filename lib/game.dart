import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:life/grid.dart';

class LifeGame extends FlameGame {

  var _dtSum = 0.0;
  final fixedRate = 1/24; // life speed

  @override
  void onLoad() {
    add(LifeComponent());
    add(FpsComponent());
  }

  @override
  void updateTree(double dt) {
    _dtSum += dt;
    if(_dtSum > fixedRate) {
      super.updateTree(fixedRate);
      _dtSum -= fixedRate;
    }
  }

}

