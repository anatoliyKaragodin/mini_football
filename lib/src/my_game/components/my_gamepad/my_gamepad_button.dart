import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_football/src/my_game/components/player/football_player.dart';
import 'package:mini_football/src/my_game/my_game.dart';

class MyGamepadButton extends SpriteButtonComponent with HasGameRef<MyGame> {
  final String imgPath;
  final Function function;

  MyGamepadButton(
      {super.button,
      super.buttonDown,
      super.onPressed,
      super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.children,
      super.priority,
      required this.imgPath,
      required this.function});
  @override
  FutureOr<void> onLoad() {
    addButton();
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent _) {
    if (gameRef.world.playersList[0].playerState == PlayerState.idle) {
      function();
    }
    super.onTapDown(_);
  }

  @override
  void onTapUp(TapUpEvent _) {
    if (gameRef.world.myGamepad.isMoveLeft ||
        gameRef.world.myGamepad.isMoveRight) {
      gameRef.world.myGamepad.isMoveLeft = false;
      gameRef.world.myGamepad.isMoveRight = false;

    }
    super.onTapUp(_);
  }

  void addButton() async {
    var image = await Flame.images.load(imgPath);
    button = Sprite(image);
  }
}
