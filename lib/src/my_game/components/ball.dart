import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_football/src/my_game/components/player/football_player.dart';
import 'package:mini_football/src/my_game/components/player/legs.dart';
import 'package:mini_football/src/my_game/level.dart';
import 'package:mini_football/src/my_game/my_game.dart';

class Ball extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  late SpriteComponent ball;

  // late Vector2 ballPosition;

  @override
  FutureOr<void> onLoad() async {
    var ballImg = await Flame.images.load('Ball.png');
    sprite = Sprite(ballImg);
    ball = SpriteComponent(sprite: sprite, size: Vector2(100, 100));
    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is FootballPlayer) {
      // Находим вектор от мяча к игроку/ногам
      var collisionVector = position - other.position;
      double speed = 200; // коэффициент ускорения мяча

      // Вычисляем угол между мячом и игроком/ногами
      var collisionAngle = collisionVector.angleTo(
          Vector2(1, 0)); // предполагаем направление вправо как базовое
      if (gameRef.world.playersList[1].playerState == PlayerState.jump) {
        collisionAngle = collisionVector.angleTo(Vector2(-1, 0));
        // speed=speed*8;
      }

      // Устанавливаем новую скорость мяча с учетом угла столкновения
      double newVelocityX = speed * cos(collisionAngle);
      double newVelocityY = speed * sin(collisionAngle);

      gameRef.world.ballVelocity.setValues(newVelocityX, newVelocityY);
    } else if (other is Legs) {
      // Находим вектор от мяча к игроку/ногам
      var collisionVector = position - other.position;

      // Вычисляем угол между мячом и игроком/ногами
      var collisionAngle = collisionVector.angleTo(
          Vector2(1, 0)); // предполагаем направление вправо как базовое

      // Устанавливаем новую скорость мяча с учетом угла столкновения
      double speed = 100; // коэффициент ускорения мяча
      if (gameRef.world.playersList[0].playerState == PlayerState.hit ||
          gameRef.world.playersList[0].playerState == PlayerState.hitInJump) {
        speed = speed * 8;
        collisionAngle = pi * 0.43;
      }
      if (gameRef.world.playersList[1].playerState == PlayerState.hit ||
          gameRef.world.playersList[1].playerState == PlayerState.hitInJump) {
        speed = speed * 8;
        collisionAngle = pi * 0.58;
        if (gameRef.world.playersList[1].playerState == PlayerState.hitInJump) {
          collisionAngle = collisionVector.angleTo(
              Vector2(-1, 0));        }
      }
      double newVelocityX = speed * cos(collisionAngle);
      double newVelocityY = speed * sin(collisionAngle);

      gameRef.world.ballVelocity.setValues(newVelocityX, newVelocityY);
    }
    super.onCollision(intersectionPoints, other);
  }
}
