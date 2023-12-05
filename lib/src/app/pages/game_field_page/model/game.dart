class GameState {
  final bool showStartDialog;
  final bool showRoundResultDialog;
  final bool showResultDialog;
  final int bet;
  final int userMoney;
  final int userScore;
  final bool isBetted;
  final bool isWinGame;
  final int playerWins;
  final int lifes;
  final bool showRestartGameDialog;
  final List<int> teamsScore;
  final bool matchIsEnded;
  final bool stopGame;
  final bool showMainDialog;

//<editor-fold desc="Data Methods">
  const GameState({
    required this.showStartDialog,
    required this.showRoundResultDialog,
    required this.showResultDialog,
    required this.bet,
    required this.userMoney,
    required this.userScore,
    required this.isBetted,
    required this.isWinGame,
    required this.playerWins,
    required this.lifes,
    required this.showRestartGameDialog,
    required this.teamsScore,
    required this.matchIsEnded,
    required this.stopGame,
    required this.showMainDialog,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameState &&
          runtimeType == other.runtimeType &&
          showStartDialog == other.showStartDialog &&
          showRoundResultDialog == other.showRoundResultDialog &&
          showResultDialog == other.showResultDialog &&
          bet == other.bet &&
          userMoney == other.userMoney &&
          userScore == other.userScore &&
          isBetted == other.isBetted &&
          isWinGame == other.isWinGame &&
          playerWins == other.playerWins &&
          lifes == other.lifes &&
          showRestartGameDialog == other.showRestartGameDialog &&
          teamsScore == other.teamsScore &&
          matchIsEnded == other.matchIsEnded &&
          stopGame == other.stopGame &&
          showMainDialog == other.showMainDialog);

  @override
  int get hashCode =>
      showStartDialog.hashCode ^
      showRoundResultDialog.hashCode ^
      showResultDialog.hashCode ^
      bet.hashCode ^
      userMoney.hashCode ^
      userScore.hashCode ^
      isBetted.hashCode ^
      isWinGame.hashCode ^
      playerWins.hashCode ^
      lifes.hashCode ^
      showRestartGameDialog.hashCode ^
      teamsScore.hashCode ^
      matchIsEnded.hashCode ^
      stopGame.hashCode ^
      showMainDialog.hashCode;

  @override
  String toString() {
    return 'GameState{' +
        ' showStartDialog: $showStartDialog,' +
        ' showRoundResultDialog: $showRoundResultDialog,' +
        ' showResultDialog: $showResultDialog,' +
        ' bet: $bet,' +
        ' userMoney: $userMoney,' +
        ' userScore: $userScore,' +
        ' isBetted: $isBetted,' +
        ' isWinGame: $isWinGame,' +
        ' playerWins: $playerWins,' +
        ' lifes: $lifes,' +
        ' showRestartGameDialog: $showRestartGameDialog,' +
        ' teamsScore: $teamsScore,' +
        ' matchIsEnded: $matchIsEnded,' +
        ' stopGame: $stopGame,' +
        ' showMainDialog: $showMainDialog,' +
        '}';
  }

  GameState copyWith({
    bool? showStartDialog,
    bool? showRoundResultDialog,
    bool? showResultDialog,
    int? bet,
    int? userMoney,
    int? userScore,
    bool? isBetted,
    bool? isWinGame,
    int? playerWins,
    int? lifes,
    bool? showRestartGameDialog,
    List<int>? teamsScore,
    bool? matchIsEnded,
    bool? stopGame,
    bool? showMainDialog,
  }) {
    return GameState(
      showStartDialog: showStartDialog ?? this.showStartDialog,
      showRoundResultDialog:
          showRoundResultDialog ?? this.showRoundResultDialog,
      showResultDialog: showResultDialog ?? this.showResultDialog,
      bet: bet ?? this.bet,
      userMoney: userMoney ?? this.userMoney,
      userScore: userScore ?? this.userScore,
      isBetted: isBetted ?? this.isBetted,
      isWinGame: isWinGame ?? this.isWinGame,
      playerWins: playerWins ?? this.playerWins,
      lifes: lifes ?? this.lifes,
      showRestartGameDialog:
          showRestartGameDialog ?? this.showRestartGameDialog,
      teamsScore: teamsScore ?? this.teamsScore,
      matchIsEnded: matchIsEnded ?? this.matchIsEnded,
      stopGame: stopGame ?? this.stopGame,
      showMainDialog: showMainDialog ?? this.showMainDialog,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showStartDialog': this.showStartDialog,
      'showRoundResultDialog': this.showRoundResultDialog,
      'showResultDialog': this.showResultDialog,
      'bet': this.bet,
      'userMoney': this.userMoney,
      'userScore': this.userScore,
      'isBetted': this.isBetted,
      'isWinGame': this.isWinGame,
      'playerWins': this.playerWins,
      'lifes': this.lifes,
      'showRestartGameDialog': this.showRestartGameDialog,
      'teamsScore': this.teamsScore,
      'matchIsEnded': this.matchIsEnded,
      'stopGame': this.stopGame,
      'showMainDialog': this.showMainDialog,
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      showStartDialog: map['showStartDialog'] as bool,
      showRoundResultDialog: map['showRoundResultDialog'] as bool,
      showResultDialog: map['showResultDialog'] as bool,
      bet: map['bet'] as int,
      userMoney: map['userMoney'] as int,
      userScore: map['userScore'] as int,
      isBetted: map['isBetted'] as bool,
      isWinGame: map['isWinGame'] as bool,
      playerWins: map['playerWins'] as int,
      lifes: map['lifes'] as int,
      showRestartGameDialog: map['showRestartGameDialog'] as bool,
      teamsScore: map['teamsScore'] as List<int>,
      matchIsEnded: map['matchIsEnded'] as bool,
      stopGame: map['stopGame'] as bool,
      showMainDialog: map['showMainDialog'] as bool,
    );
  }

//</editor-fold>
}
