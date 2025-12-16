import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:stack_me/main_game.dart';

void main() {
  final game = MainGame(); 
  runApp(GameWidget<MainGame>(game: game));
}
