import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_football/src/my_game/components/my_gamepad/my_gamepad_button.dart';
import 'package:mini_football/src/my_game/components/player/football_player.dart';
import 'package:mini_football/src/my_game/my_game.dart';

class MyGamePad extends PositionComponent
    with HasGameRef<MyGame>, TapCallbacks {
  bool isMoveRight = false;
  bool isMoveLeft = false;

  @override
  FutureOr<void> onLoad() {
    addButtons();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    moveUser(dt);
    super.update(dt);
  }

  void addButtons() {
    const double buttonPadding = 200;
    var imgPathList = [
      'LeftArrow.png',
      'RightArrow.png',
      'Jump.png',
      'Hit.png',
      'UpperHit.png'
    ];
    var funcList = [
      () {
        isMoveRight = false;

        isMoveLeft = true;
      },
      () {
        isMoveLeft = false;

        isMoveRight = true;
      },
      () {
        gameRef.world.playersList[0].playerState = PlayerState.jump;
      },
      () {
        gameRef.world.playersList[0].playerState = PlayerState.hit;
      },
      () {
        debugPrint('***********\nTAP HIT IN JUMP\n*********');
        gameRef.world.playersList[0].playerState = PlayerState.hitInJump;
      },
    ];
    var leftButton =
        MyGamepadButton(imgPath: imgPathList[0], function: funcList[0]);
    var rightButton =
        MyGamepadButton(imgPath: imgPathList[1], function: funcList[1]);
    var jumpButton =
        MyGamepadButton(imgPath: imgPathList[2], function: funcList[2]);
    var hitButton =
        MyGamepadButton(imgPath: imgPathList[3], function: funcList[3]);
    var hitInJumpButton =
        MyGamepadButton(imgPath: imgPathList[4], function: funcList[4]);
    rightButton.position = leftButton.position + Vector2(buttonPadding, 0);
    hitInJumpButton.position = Vector2(1350, 0);
    hitButton.position = hitInJumpButton.position + Vector2(-buttonPadding, 0);
    jumpButton.position = hitButton.position + Vector2(-buttonPadding, 0);

    addAll([leftButton, rightButton, jumpButton, hitButton, hitInJumpButton]);
  }

  void moveUser(double dt) {
    if(isMoveRight) {
      debugPrint('MOVE RIGHT');
      if(gameRef.world.playersList[0].x<gameRef.world.playersList[1].x+900) {
        gameRef.world.playersList[0].x+=dt*100;
      }
    } else if (isMoveLeft){
      debugPrint('MOVE LEFT');
      if(gameRef.world.playersList[0].x>-5) {

      gameRef.world.playersList[0].x-=dt*100;}

    }
  }
}
