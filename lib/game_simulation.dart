import 'dart:async';

import 'package:flame/components.dart';
import 'package:stack_me/box.dart';

class GameSimulation extends Component {

  @override
  FutureOr<void> onLoad() {
    add(Box());
    return super.onLoad();
  }
}