import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stack_me/box.dart';
import 'package:stack_me/ground.dart';

class GameSimulation extends Component {
  List<Box> _stack = [];
  Box _currentBox = Box();
  Ground _ground = Ground();

  @override
  FutureOr<void> onLoad() {
    initStack();
    add(_ground);
    return super.onLoad();
  }

  bool _isColideWithGround() {
    final boxBottom = _stack.last.position.y + _stack.last.boxSize / 2;
    final groundTop = _ground.position.y;

    return boxBottom >= groundTop;
  }

  void _handleGoundAndBoxCollision() {
    // Check collision
    if (_isColideWithGround()) {
      print("------------");
      _stack.last.stopFalling();
    }
  }

  void initStack() {
    _stack.add(_currentBox);
    add(_currentBox);
  }

  void dropCurrentBox() {
    _currentBox.drop();
    // Create new box
    _stack.add(_currentBox);
    _currentBox = Box();
    add(_currentBox);
  }

  void _drawDebugPoint(Canvas canvas, Vector2 pos) {
    canvas.drawCircle(Offset(pos.x, pos.y), 3, Paint()..color = Colors.yellow);
  }

  @override
  void update(double dt) {
    _handleGoundAndBoxCollision();
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    _drawDebugPoint(
      canvas,
      Vector2(
        _stack.last.position.x,
        _stack.last.position.y + _stack.last.boxSize / 2,
      ),
    );
    super.render(canvas);
  }
}
