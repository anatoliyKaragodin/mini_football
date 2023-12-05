
import '../../../../utils/constants.dart';
import 'game.dart';

class GameConstants {
  static const initState = GameState(
      showStartDialog: true,
      showRoundResultDialog: false,
      showResultDialog: false,
      showMainDialog: false,
      bet: 0,
      userMoney: Constants.userStartCoins,
      userScore: 0,
      isBetted: false,
      isWinGame: false,
      playerWins: 0,
      lifes: 3,
      showRestartGameDialog: false,
      teamsScore: [],
      matchIsEnded: false,
      stopGame: true);
}
