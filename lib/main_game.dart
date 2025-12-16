import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:stack_me/game_simulation.dart';

class MainGame extends FlameGame with KeyboardEvents {
  final GameSimulation _gameSim = GameSimulation();
  @override
  FutureOr<void> onLoad() {
    add(_gameSim);
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      _gameSim.dropCurrentBox();
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
