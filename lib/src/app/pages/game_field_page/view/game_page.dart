import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_football/src/my_game/my_game.dart';

import '../../../../app/pages/game_field_page/controller/game_page_controller.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({
    Key? key,
  }) : super(key: key);

  final String route = 'game page';

  @override
  ConsumerState createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  TextEditingController betController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.longestSide;
    final width = MediaQuery.of(context).size.shortestSide;
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final game = ref.watch(gameProvider);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GameWidget(

          game: MyGame(
            ref: ref,
            gameFinished: game.matchIsEnded,
            stopGame: game.stopGame,
            context: context,
          ),
        ),
      ),
    );
  }
}
