import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/pages/game_field_page/controller/game_page_controller.dart';
import 'level.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasGameRef<MyGame>, TapCallbacks {
  final WidgetRef ref;
  final BuildContext context;
  late bool gameFinished;
  late bool stopGame;
  late bool isScoreSend;
  MyGame(
      {required this.ref,
      required this.gameFinished,
      required this.stopGame,
      required this.context});
  List<int> scoreList = [];
  late final CameraComponent cam;
  /// DEBUG MODE
  @override
  bool get debugMode => false;
  ///
  @override
  final Level world = Level();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    isScoreSend = false;
    setCamera();

    setWorld();
    addAll([]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    sendMatchEndAndScores();
    super.update(dt);
  }

  void setWorld() {
    add(world);
    // world = Level();
  }

  void setCamera() {
    camera = CameraComponent.withFixedResolution(
        width: 1280, height: 720, world: world);
    camera.viewfinder.anchor = Anchor.topLeft;
  }

  void sendMatchEndAndScores() {
    if (gameFinished && !isScoreSend) {
      isScoreSend = true;
      stopGame = true;
      GameControl.onMatchEnd(ref, scoreList, context);
    }
  }

  void startMatch() {
    if (!stopGame && !gameFinished && !isScoreSend) {
      debugPrint('START MATCH');
      gameRef.world.matchIsEnded = false;
      // GameControl.changeStopGame(ref, false, false);
    }
  }
}
