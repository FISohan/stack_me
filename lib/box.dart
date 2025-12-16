import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/*
  Box have:
    Properties:
     1. Velocity with acceleration
     2. Angular Valocity
    Method:
     1.Drop: Drop box from anchore
*/

class Box extends PositionComponent with HasGameReference<FlameGame> {
  Vector2 _velocity = Vector2(0, 0);
  final double _size = 40.0;
  final Random _random = Random();
  late final Vector2 _screenSize;

  double get boxSize => _size;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _screenSize = game.size;
    // Initially set random start position
    position = _getRandomPositionOnTop();
    // Set X velocity
    _setXAxisVelocity();
    return super.onLoad();
  }

  Vector2 _getRandomPositionOnTop() {
    final double randomXPosition = _random.nextDoubleBetween(
      _size,
      _screenSize.x,
    );
    return Vector2(randomXPosition, _size / 2);
  }

  void _setXAxisVelocity() {
    _velocity = Vector2(200, 0);
  }

  void _handleEdgeCollision() {
    if (position.x - _size / 2 <= 0) {
      _velocity *= -1;
    }
    if (position.x + _size / 2 >= _screenSize.x) {
      _velocity *= -1;
    }
  }

  void drop() {
    _velocity = Vector2.zero();
    _velocity = Vector2(0, 200);
  }

  void stopFalling() {
    _velocity = Vector2.zero();
  }

  @override
  void update(double dt) {
    position += _velocity * dt;
    // Handle collision when box touches edge of screen X axis
    _handleEdgeCollision();
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: _size, height: _size),
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.red,
    );
    // Draw anchor
    canvas.drawCircle(
      Offset(anchor.x, anchor.y),
      3,
      Paint()..color = Colors.blue,
    );
    super.render(canvas);
  }
}
