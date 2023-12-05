import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:mini_football/src/my_game/my_game.dart';

class GateFront extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  late SpriteComponent gateFront;

  @override
  FutureOr<void> onLoad() async {
    var ballImg = await Flame.images.load('GateFront.png');
    sprite = Sprite(ballImg);
    gateFront = SpriteComponent(sprite: sprite, size: Vector2(120, 300));
    // add(RectangleHitbox());

    return super.onLoad();
  }
}



class GateBack extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  late SpriteComponent gateBack;

  @override
  FutureOr<void> onLoad() async {
    var ballImg = await Flame.images.load('GateBack.png');
    sprite = Sprite(ballImg);
    gateBack = SpriteComponent(sprite: sprite, size: Vector2(120, 300));
    // add(RectangleHitbox());

    return super.onLoad();
  }
}