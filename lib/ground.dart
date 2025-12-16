import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent with HasGameReference<FlameGame> {
  final double _groundHeight = 200;
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    position = Vector2(0, game.size.y - _groundHeight);
    anchor = Anchor.topLeft;
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    Paint groundPaint = Paint()..color = Colors.grey;
    canvas.drawRect(Rect.fromLTWH(0, 0, game.size.x, _groundHeight), groundPaint);
    canvas.drawCircle(
      Offset(anchor.x, anchor.y),
      3,
      Paint()..color = Colors.blue,
    );
    super.render(canvas);
  }
}
