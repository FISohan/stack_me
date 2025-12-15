import 'dart:async';

import 'package:flame/game.dart';
import 'package:stack_me/game_simulation.dart';

class MainGame extends FlameGame {
  @override
  FutureOr<void> onLoad() {
    add(GameSimulation());
    return super.onLoad();
  }
}
