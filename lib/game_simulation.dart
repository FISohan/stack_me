import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stack_me/box.dart';
import 'package:stack_me/ground.dart';

class GameSimulation extends Component {
  List<Box> _stack = [];

  Box _notDropYetBox = Box();
  Box? _fallingBox = null;
  Box? _topMostBoxOnTheStack = null;

  Ground _ground = Ground();

  @override
  FutureOr<void> onLoad() {
    initStack();
    add(_ground);
    priority = 9999;
    return super.onLoad();
  }

  bool _isColideWithGround() {
    if (_fallingBox == null) return false;
    final boxBottom = _fallingBox!.position.y + _fallingBox!.boxSize / 2;
    final groundTop = _ground.position.y;

    return boxBottom >= groundTop;
  }

  void _handleGoundAndBoxCollision() {
    // Check collision
    if (_isColideWithGround()) {
      _fallingBox!.updateBoxState(BoxState.onTheGround);
      _fallingBox!.stopFalling();
      _topMostBoxOnTheStack = _fallingBox;
      _fallingBox = null;
    }
  }

  void initStack() {
    final Box box = Box();
    _notDropYetBox = box;
    add(_notDropYetBox);
  }

  void dropCurrentBox() {
    if (_fallingBox != null) return;

    _notDropYetBox.drop();
    _fallingBox = _notDropYetBox;
    _notDropYetBox = Box();
    add(_notDropYetBox);
  }

  void _drawDebugPoint(Canvas canvas, Vector2 pos) {
    canvas.drawCircle(Offset(pos.x, pos.y), 3, Paint()..color = Colors.yellow);
  }

void _handleBoxAndBoxCollision() {
  if (_topMostBoxOnTheStack == null || _fallingBox == null) return;

  final falling = _fallingBox!;
  final topBox = _topMostBoxOnTheStack!;

  final prevBottom =
      falling.prevPosition.y + falling.boxSize / 2;
  final currBottom =
      falling.position.y + falling.boxSize / 2;

  final topBoxTop =
      topBox.position.y - topBox.boxSize / 2;

  final xOverlap =
      falling.position.x + falling.boxSize / 2 > topBox.position.x - topBox.boxSize / 2 &&
      falling.position.x - falling.boxSize / 2 < topBox.position.x + topBox.boxSize / 2;

  // 🚀 KEY FIX: crossing check
  final crossed = prevBottom < topBoxTop && currBottom >= topBoxTop;

  if (crossed && xOverlap) {
    // snap exactly
    falling.position.y =
        topBox.position.y - topBox.boxSize;

    falling.stopFalling();
    falling.updateBoxState(BoxState.onTheGround);

    _topMostBoxOnTheStack = falling;
    _fallingBox = null;
  } else if (crossed && !xOverlap) {
    print('GAME OVER');
  }
}


  @override
  void update(double dt) {
    _handleGoundAndBoxCollision();
    _handleBoxAndBoxCollision();
    super.update(dt);
  }
}
