
import '../../../../utils/constants.dart';
import '../../../../utils/library.dart';
import '../../../repo/shared_prefs.dart';
import '../../home_app/view/home_app_page.dart';
import '../model/game.dart';
import '../model/game_model.dart';

final gameProvider = StateNotifierProvider<GameModel, GameState>((ref) {
  return GameModel();
});

class GameControl {
  static onTapConfirmButton(WidgetRef ref, String betString) {
    if (betString.isNotEmpty) {
      int? bet = int.tryParse(betString);
      final isBetted = ref.read(gameProvider).isBetted;
      if (bet != null && bet > 0 && !isBetted) {
        ref.read(gameProvider.notifier).setIsBetted(true);
        ref.read(gameProvider.notifier).setBet(bet);
        // ref.read(gameProvider.notifier).startGame();
      }
    }
  }

  // static void onTapPlayer(WidgetRef ref, int index) {}

  // static onNewGameTap(WidgetRef ref) {
  //   ref.read(gameProvider.notifier).startGame();
  // }

  static onRestartGameTap(WidgetRef ref) {
    ref.read(gameProvider.notifier).resetNewGame();
    Repo().saveUserCoins(Constants.userStartCoins);
    Repo().saveUserScore(0);
    Repo().saveUserLives(3);
  }

  static onMatchEnd(WidgetRef ref, List<int> scoreList, BuildContext context) {
    // if (scoreList[0] == 0 && scoreList[1] == 17) {
    // } else {
      ref.read(gameProvider.notifier).setScores(scoreList);
    // }

    ref.read(gameProvider.notifier).changeStopGame(true);
    // ref.read(gameProvider.notifier).changeMatchEnd(false);
    // if (scoreList[0] != 0 || scoreList[1] != 1) {
    // debugPrint('SCORE: $scoreList');
    // }

    ref.read(gameProvider.notifier).changeShowStartDialog(false);
    ref.read(gameProvider.notifier).changeShowResultDialog(true);
    Navigator.pushNamed(context, const HomeAppPage().route);
  }

  static void changeStopGame(WidgetRef ref, bool bool, bool isEnd) {
    ref.read(gameProvider.notifier).changeStopGame(bool);
    ref.read(gameProvider.notifier).changeMatchEnd(isEnd);
  }

  static void onTapFinishMatch(BuildContext context, WidgetRef ref) {
    Navigator.pushNamed(context, const HomeAppPage().route);
    ref.read(gameProvider.notifier).changeShowStartDialog(false);
    // ref.read(gameProvider.notifier).changeShowResultDialog();
  }

  static void onCloseResultTap(WidgetRef ref, bool isWin, bool isDraw) {
    ref.read(gameProvider.notifier).changeStopGame(true);
    final bet = ref.read(gameProvider).bet;
    if (isWin) {
      ref.read(gameProvider.notifier).updateUserMoney(bet * 2);
      ref.read(gameProvider.notifier).updateUserScore(bet * 2);
    } else if (isDraw) {
      ref.read(gameProvider.notifier).updateUserMoney(bet);
      ref.read(gameProvider.notifier).updateUserScore(bet);
    } else {
      ref.read(gameProvider.notifier).minusLife();
      final game = ref.read(gameProvider);
      if (game.lifes == 0 || game.userMoney <= 0) {
        ref.read(gameProvider.notifier).changeShowRestartGameDialog(true);
      }
    }
    ref.read(gameProvider.notifier).setBet(0);
    ref.read(gameProvider.notifier).setIsBetted(false);

    ref.read(gameProvider.notifier).changeShowStartDialog(true);
    ref.read(gameProvider.notifier).changeShowResultDialog(false);
  }
}
