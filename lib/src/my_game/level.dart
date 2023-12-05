import 'dart:async';
import 'dart:math';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:mini_football/src/app/pages/game_field_page/model/player.dart';
import 'package:mini_football/src/my_game/components/ball.dart';
import 'package:mini_football/src/my_game/components/my_gamepad/my_gamepad.dart';
import 'package:mini_football/src/my_game/components/player/football_player.dart';
import 'package:mini_football/src/my_game/components/gate.dart';
import 'package:mini_football/src/my_game/my_game.dart';
import 'package:mini_football/src/utils/my_colors.dart';

class Level extends World with HasGameRef<MyGame>, TapCallbacks {
  late SpriteComponent background;
  late SpriteComponent ball;
  late List<SpriteComponent> gateFrontList;
  late List<SpriteComponent> gateBackList;
  late SpriteComponent scoreBoard;
  double time = 0;
  late TextComponent matchTime;
  static const double gatesXPosition = 20;
  static const double gatesYPosition = 300;
  static const double ballSize = 20;
  Vector2 ballVelocity = Vector2(0, 100);
  double gravity = 200;
  double damping = 0.9995;
  double angularVelocity = 0;
  double groundXPosition = 480;
  late int team1ScoreNumber;
  late int team2ScoreNumber;
  late TextComponent team1Score;
  late TextComponent team2Score;
  late MyGamePad myGamepad;

  bool isGoal = false;
  late List<FootballPlayer> playersList;
  Vector2 player1Position = Vector2(0, 0);
  Vector2 player2Position = Vector2(0, 0);
  bool matchIsEnded = false;

  @override
  FutureOr<void> onLoad() async {
    await addBackground();
    await addScoreBoard();
    addScores();
    addMatchTime();
    await addPlayers();
    addGatesBack();
    addBall();
    addGatesFront();
    addGamepad();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!gameRef.stopGame) {
      reduceMatchTime(dt);
      ballMovement(dt);
      enemyActions();
      checkGoal();
      resetBall();
      resetPlayers();
    }
    super.update(dt);
  }

  Future<void> addBackground() async {
    var backgroundImg = await Images().load('Fon.png');
    background = SpriteComponent(sprite: Sprite(backgroundImg));
    add(background);
  }

  void addBall() {
    ball = Ball();
    ball.size = Vector2(ballSize, ballSize);
    ball.anchor = Anchor.center;
    ball.position = Vector2(640, 0);
    add(ball);
  }

  void addGatesFront() {
    const double size = 1.5;
    gateFrontList = [GateFront(), GateFront()];

    gateFrontList[0].size = Vector2(60, 150) * size;
    gateFrontList[0].position = Vector2(gatesXPosition, gatesYPosition);
    gateFrontList[1].flipHorizontally();
    gateFrontList[1].size = Vector2(60, 150) * size;
    gateFrontList[1].position = Vector2(1280 - gatesXPosition, gatesYPosition);
    addAll(gateFrontList);
  }

  void addGatesBack() {
    const double size = 1.5;
    gateBackList = [GateBack(), GateBack()];

    gateBackList[0].size = Vector2(60, 150) * size;
    gateBackList[0].position = Vector2(gatesXPosition, gatesYPosition);
    gateBackList[1].flipHorizontally();
    gateBackList[1].size = Vector2(60, 150) * size;
    gateBackList[1].position = Vector2(1280 - gatesXPosition, gatesYPosition);
    addAll(gateBackList);
  }

  Future<void> addScoreBoard() async {
    var scoreBoardImg = await Images().load('Scoretab.png');
    scoreBoard = SpriteComponent(sprite: Sprite(scoreBoardImg));
    scoreBoard.position = Vector2(640 - 314 / 2, 0);
    add(scoreBoard);
  }

  addMatchTime() {
    time = 180;
    matchTime = TextComponent(
        text: '',
        size: Vector2(50, 50),
        textRenderer: TextPaint(
          style: TextStyle(fontSize: 30, color: MyColors.whiteColor),
        ),
        position: Vector2(610, 55));
    add(matchTime);
  }

  reduceMatchTime(double dt) {
    // time = 10;
    time -= dt;
    if (time < 0) {
      time = 0;
      gameEnded();
    }

    updateScoreboardText();
  }

  updateScoreboardText() {
    matchTime.text =
        '${(time ~/ 60).toStringAsFixed(0)}:${(time % 60).toStringAsFixed(0).padLeft(2, '0')}';
  }

  void ballMovement(double dt) {
    ballVelocity.y += gravity * dt;

    // Изменяем позицию мяча на основе скорости
    ball.x += ballVelocity.x * dt;
    ball.y += ballVelocity.y * dt;

    // Проверяем столкновение с левой и правой границами экрана
    if (ball.x < 70) {
      // Столкновение с левой границей
      ball.x = 70; // Устанавливаем позицию мяча на границе
      ballVelocity.x *= -0.02; // Меняем направление мяча
    } else if (ball.x > 1280 - 70) {
      // Столкновение с левой границей
      ball.x = 1280 - 70; // Устанавливаем позицию мяча на границе
      ballVelocity.x *= -0.02;
    } // Меняем направление мяча
    else if (ball.x > 1280 - ball.size.x) {
      // Столкновение с правой границей (1280 - ширина мяча)
      ball.x = 1280 - ball.size.x; // Устанавливаем позицию мяча на границе
      ballVelocity.x *= -1; // Меняем направление мяча
    }

    // Проверяем столкновение с землей (нижней границей экрана)
    if (ball.y > groundXPosition) {
      // Отскок мяча с упругостью
      ball.y = groundXPosition;
      ballVelocity.y *= -0.3; // Уменьшаем скорость на половину при отскоке
      ballVelocity.x *=
          damping; // Применяем затухание к скорости по горизонтали
      // Устанавливаем угловую скорость (в градусах в секунду)
      angularVelocity = ballVelocity.x *
          0.05; // Пример: умножаем скорость по горизонтали для управления угловой скоростью
    }

    // Уменьшаем скорость на 10% (применяем затухание) при каждом обновлении
    ballVelocity.x *= damping;

    // Постепенно замедляем угловую скорость
    angularVelocity *= damping;

    // Изменяем угол мяча на основе угловой скорости
    ball.angle += angularVelocity * dt;
  }

  void addScores() {
    team1ScoreNumber = 0;
    team2ScoreNumber = 0;
    double xPosition = 90;
    double yPosition = 85;

    double fontSize = 50;
    team1Score = TextComponent(
      size: Vector2(100, 50),
      anchor: Anchor.center,
      text: team1ScoreNumber.toString(),
      position: Vector2(640 - xPosition, yPosition),
      textRenderer: TextPaint(style: TextStyle(fontSize: fontSize)),
    );
    team2Score = TextComponent(
      size: Vector2(100, 50),
      anchor: Anchor.center,
      text: team2ScoreNumber.toString(),
      position: Vector2(640 + xPosition, yPosition),
      textRenderer: TextPaint(style: TextStyle(fontSize: fontSize)),
    );
    addAll([team1Score, team2Score]);
  }

  void updateScore() {
    team1Score.text = team1ScoreNumber.toString();
    team2Score.text = team2ScoreNumber.toString();
  }

  void checkGoal() {
    if (ball.x < 100 && !isGoal) {
      team2ScoreNumber++;
      updateScore();
      isGoal = true;
    } else if (ball.x > 1280 - 100 && !isGoal) {
      team1ScoreNumber++;
      updateScore();
      isGoal = true;
    }
  }

  Future<void> addPlayers() async {
    playersList = [
      FootballPlayer(isEnemy: false),
      FootballPlayer(isEnemy: true)
    ];
    addAll(playersList);
  }

  void addGamepad() {
    myGamepad = MyGamePad();
    var scale = 0.8;
    myGamepad
      ..scale = Vector2(1, 1) * scale
      ..position = Vector2(50, 600);
    add(myGamepad);
  }

  void resetBall() {
    if (isGoal) {
      ball.position = Vector2(640, 0);
      var random = Random();
      ballVelocity = Vector2(random.nextInt(250) * -1 + 150, 100);
    }
  }

  void resetPlayers() {
    if (isGoal) {
      playersList[0].position = player1Position;
      playersList[1].position = player2Position;
      playersList[1].playerState = PlayerState.idle;

      isGoal = false;
    }
  }

  void gameEnded() {
    matchIsEnded = true;
    gameRef.gameFinished = true;
    gameRef.scoreList = [team1ScoreNumber, team2ScoreNumber];
  }

  void enemyActions() {
    var user = playersList[0];
    var enemy = playersList[1];
    var userPositionX = user.x +
        50; // Учтем смещение мяча влево относительно игрока пользователя
    var enemyPositionX = enemy.x + 1080;
    var ballPosition = gameRef.world.ball;

    debugPrint('POSITIONS X: $userPositionX $enemyPositionX ${ballPosition.y}');
    if (enemyPositionX - ballPosition.x <= 30 &&
        enemyPositionX - ballPosition.x >= -20 &&
        ballPosition.y < 410) {
      playersList[1].playerState = PlayerState.jump;
    } else if (enemy.playerState == PlayerState.idle ||
        enemy.playerState == PlayerState.moveRight ||
        enemy.playerState == PlayerState.moveLeft) {
      _enemyHit(ballPosition.x, enemyPositionX);
      _enemyMove(userPositionX, enemyPositionX, ballPosition.x);
    }
  }

  void _enemyHit(double ballPositionX, double enemyPositionX) {
    if (enemyPositionX - ballPositionX <= -5 &&
        enemyPositionX - ballPositionX >= -25) {
      playersList[1].playerState = PlayerState.hit;
    }
  }

  void _enemyMove(
      double userPositionX, double enemyPositionX, double ballPositionX) {
    if (playersList[1].playerState != PlayerState.hit) {
      if (enemyPositionX - userPositionX > 400) {
        playersList[1].playerState = PlayerState.moveLeft;
      } else if (enemyPositionX - userPositionX < 300) {
        playersList[1].playerState = PlayerState.moveRight;
      } else if (ballPositionX - enemyPositionX > 0) {
        playersList[1].playerState = PlayerState.moveRight;
      } else {
        // playersList[1].playerState = PlayerState.idle;
      }
    }
  }
}
