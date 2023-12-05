import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../../my_game.dart';

class Legs extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  final bool isEnemy;

  Legs({required this.isEnemy});

  @override
  FutureOr<void> onLoad() async {
    await addLegs();
    addHitbox();
    return super.onLoad();
  }

  late SpriteComponent downSpriteComponent;
  late CompositeHitbox downHitBox;

  static const spriteScale = 0.4;
  Vector2 player1Position = Vector2(100, 410);
  Vector2 player2Position = Vector2(1280 - 200, 410);
  double footAngle = 0;

  Future<void> addLegs() async {
    var userPlImg = 'Player 1 nogi.png';
    var enemyPlImg = 'Player 2 nogi.png';

    var image = await Flame.images.load(isEnemy ? enemyPlImg : userPlImg);
    sprite = Sprite(image);
    downSpriteComponent = SpriteComponent(
      sprite: sprite,
    );
  }

  void addHitbox() {
    var downHitBox = CompositeHitbox(children: [
      RectangleHitbox(
        size: Vector2(50, 110),
        position: downSpriteComponent.position +
            (isEnemy ? Vector2(20, 0) : Vector2(0, 0)),
      ),
      RectangleHitbox(
        size: Vector2(70, 20),
        position: downSpriteComponent.position +
            (isEnemy ? Vector2(0, 90) : Vector2(0, 90)),
      )
    ]);
    add(downHitBox);
  }
}
