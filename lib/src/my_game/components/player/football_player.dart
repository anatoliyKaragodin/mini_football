import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_football/src/my_game/components/player/legs.dart';

import '../../my_game.dart';

enum PlayerState { idle, hit, jump, hitInJump, moveRight, moveLeft }

class FootballPlayer extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  final bool isEnemy;

  FootballPlayer({required this.isEnemy});
  late SpriteComponent upSpriteComponent;
  late SpriteComponent downSpriteComponent;
  late CompositeHitbox upHitBox;

  static const spriteScale = 0.4;
  Vector2 player1Position = Vector2(100, 410);
  Vector2 player2Position = Vector2(1280 - 200, 410);
  PlayerState playerState = PlayerState.idle;
  bool isLegsMoveForward = true;
  bool isPlayerMoveUp = true;
  double verticalVelocity = 0;
  double jumpSpeed = -220;

  bool isJumping = false;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is FootballPlayer) {
      if (playerState == PlayerState.moveLeft && isEnemy) {
        playerState = PlayerState.idle;
      }
      if (playerState == PlayerState.moveRight && !isEnemy) {
        playerState = PlayerState.idle;
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    // if (playerState != PlayerState.idle)
    // {
    //   debugPrint(playerState.toString());
    // }
    move(dt);
    hit(dt);
    jump(dt);
    hitInJump(dt);

    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    await _addSpriteComponents();
    _addHitboxes();
    return super.onLoad();
  }

  Future<void> _addSpriteComponents() async {
    var userPlImgList = ['Player1Down.png', 'Player 1 nogi.png'];
    var enemyPlImgList = ['Player2Up.png', 'Player 2 nogi.png'];

    var images =
        await Flame.images.loadAll(isEnemy ? enemyPlImgList : userPlImgList);
    Sprite upSprite = Sprite(images[0]);
    upSpriteComponent = SpriteComponent(
        sprite: upSprite,
        scale: Vector2(1, 1) * spriteScale,
        position: isEnemy ? player2Position : player1Position);
    downSpriteComponent = Legs(isEnemy: isEnemy);
    downSpriteComponent.anchor =
        isEnemy ? const Anchor(0.65, 0.1) : const Anchor(0.35, 0.1);
    downSpriteComponent.position = isEnemy
        ? player2Position + Vector2(47, 45)
        : player1Position + Vector2(35, 45);
    downSpriteComponent.scale = Vector2(1, 1) * spriteScale;
    addAll([downSpriteComponent, upSpriteComponent]);
  }

  void _addHitboxes() {
    upHitBox = CompositeHitbox(children: [
      CircleHitbox(
        radius: 13,
        position: upSpriteComponent.position +
            (isEnemy ? Vector2(31, 0) : Vector2(22, 0)),
      ),
      RectangleHitbox(
        size: Vector2(20, 40),
        position: upSpriteComponent.position +
            (isEnemy ? Vector2(31, 0) : Vector2(22, 0)),
      )
    ]);

    addAll([upHitBox]);
  }

  void hit(double dt) {
    var moveSpeed = 8;
    if (isEnemy && playerState == PlayerState.hit) {
      _enemyHit(dt, moveSpeed);
    } else if (!isEnemy && playerState == PlayerState.hit) {
      _userHit(dt, moveSpeed);
    }
  }

  void jump(double dt) {
    if (!isJumping && playerState == PlayerState.jump) {
      isJumping = true;
      verticalVelocity = jumpSpeed;
    }

    if (playerState == PlayerState.jump) {
      _verticalMove(dt);
      _fellOnGround();
    }
  }

  void move(double dt) {
    var moveSpeed = 100;
    bool isPlayerMove = playerState == PlayerState.moveRight ||
        playerState == PlayerState.moveLeft;
    if (isPlayerMove) {
      _enemyXMove(dt, moveSpeed);
      _userXMove(dt, moveSpeed);
    }
  }

  void hitInJump(double dt) {
    var moveSpeed = 3;
    if (playerState == PlayerState.hitInJump) {
      // Прыгаем
      _setJumpAndJumpSpeed();

      // Бьем
      _enemyHit(dt, moveSpeed);
      _userHit(dt, moveSpeed);

      // Применяем вертикальное движение
      _verticalMove(dt);

      // Когда достигнута земля
      _fellOnGround();
      //
    }
  }

  void _fellOnGround() {
    if (position.y >= gameRef.world.groundXPosition - 480) {
      isJumping = false;
      playerState = PlayerState.idle;
      position.y = gameRef.world.groundXPosition - 480;
      downSpriteComponent.angle = 0; // Возвращаем угол ног в исходное положение
      isLegsMoveForward =
          true; // Возвращаем направление вращения ног в исходное положение
    }
  }

  void _verticalMove(double dt) {
    verticalVelocity += gameRef.world.gravity * dt * 3;
    position.y += verticalVelocity * dt;
  }

  void _enemyXMove(double dt, moveSpeed) {
    if (isEnemy) {
      if (playerState == PlayerState.moveRight && position.x < 10) {
        position.x += dt * moveSpeed;
      }
      if (playerState == PlayerState.moveLeft) {
        position.x -= dt * moveSpeed;
      }
    }
  }

  void _userXMove(double dt, int moveSpeed) {
    if (!isEnemy) {
      if (playerState == PlayerState.moveRight) {
        position.x += dt * moveSpeed;
      }
      if (playerState == PlayerState.moveLeft && position.x > 0) {
        position.x -= dt * moveSpeed;
      }
    }
  }

  void _enemyHit(double dt, int moveSpeed) {
    if (isEnemy) {
      if (isLegsMoveForward) {
        if (downSpriteComponent.angle < 1) {
          downSpriteComponent.angle += dt * moveSpeed;
        } else {
          downSpriteComponent.angle = 1;
          isLegsMoveForward = false;
        }
      } else {
        if (downSpriteComponent.angle > 0) {
          downSpriteComponent.angle -= dt * moveSpeed;
        } else {
          downSpriteComponent.angle = 0;
          isLegsMoveForward = true;
          playerState = PlayerState.idle;
          isJumping = false;
        }
      }
    }
  }

  void _userHit(double dt, int moveSpeed) {
    if (!isEnemy) {
      if (isLegsMoveForward) {
        if (downSpriteComponent.angle > -1) {
          downSpriteComponent.angle -= dt * moveSpeed;
        } else {
          downSpriteComponent.angle = -1;
          isLegsMoveForward = false;
        }
      } else {
        if (downSpriteComponent.angle < 0) {
          downSpriteComponent.angle += dt * moveSpeed;
        } else {
          downSpriteComponent.angle = 0;
          isLegsMoveForward = true;
          playerState = PlayerState.idle;
          isJumping = false;
        }
      }
    }
  }

  void _setJumpAndJumpSpeed() {
    if (!isJumping) {
      isJumping = true;
      verticalVelocity = jumpSpeed+50;
    }
  }
}
