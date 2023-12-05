import 'dart:math';
import 'package:mini_football/src/utils/library.dart';

import '../../../repo/shared_prefs.dart';
import 'game.dart';
import 'game_constants.dart';

class GameModel extends StateNotifier<GameState> {
  GameModel() : super(GameConstants.initState) {
    initState();
  }

  void initState() {
    loadUserMoney();
    loadUserScore();
    loadLives();
  }

  void resetNewGame() {
    state = GameConstants.initState;
  }

  void startGame() {
    changeShowStartDialog(false);
    changeMatchEnd(false);
    changeStopGame(false);
  }

  void loadUserMoney() async {
    var userMoney = await Repo().loadUserCoins();
    state = state.copyWith(userMoney: userMoney);
  }

  void loadUserScore() async {
    var userScore = await Repo().loadUserScore();
    state = state.copyWith(userScore: userScore);
  }

  void updateUserMoney(int value) {
    var userMoney = state.userMoney + value;
    state = state.copyWith(userMoney: userMoney);
    Repo().saveUserCoins(userMoney);
  }

  void updateUserScore(int value) {
    var userScore = state.userScore + value;
    state = state.copyWith(userScore: userScore);
    Repo().saveUserScore(userScore);
  }

  void changeShowStartDialog(bool value) {
    state = state.copyWith(showStartDialog: value);
  }

  // void changeShowRoundResultDialog() {
  //   state = state.copyWith(showRoundResultDialog: !state.showRoundResultDialog);
  // }

  void changeShowResultDialog(bool value) {
    state = state.copyWith(showResultDialog: value);
  }

  void setBet(int bet) {
    updateUserMoney(-bet);
    state = state.copyWith(bet: bet);
  }

  void setUserWin(int wins) {
    state = state.copyWith(playerWins: wins);
  }

  void minusLife() {
    if (state.lifes > 0) {
      Repo().saveUserLives(state.lifes - 1);
      state = state.copyWith(lifes: state.lifes - 1);
    }
  }

  void loadLives() async {
    var lives = await Repo().loadUserLives();
    state = state.copyWith(lifes: lives);
  }

  void changeShowRestartGameDialog(bool value) {
    state = state.copyWith(showRestartGameDialog: value);
  }

  void changeMatchEnd(bool isEnd) {
    if (state.matchIsEnded != isEnd) {
      state = state.copyWith(matchIsEnded: isEnd);
    }
  }

  void setScores(List<int> scoreList) {
    if(state.teamsScore.isEmpty) {
      debugPrint('SET SCORE IN MODEL: $scoreList');
      state = state.copyWith(teamsScore: scoreList);
    }
  }

  void changeStopGame(bool bool) {
    if (state.stopGame != bool) {
      state = state.copyWith(stopGame: bool);
    }
  }

  void setIsBetted(bool bool) {
    state = state.copyWith(isBetted: bool);
  }

  void resetScores() {
    state = state.copyWith(teamsScore: []);
    debugPrint('RESET SCORE!');
  }
}
