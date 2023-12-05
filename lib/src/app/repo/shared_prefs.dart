import '../../utils/constants.dart';
import '../../utils/library.dart';

class Repo {
  final _prefs = SharedPreferences.getInstance();

  Future<void> saveUserCoins(int coins) async {
    final prefs = await _prefs;

    await prefs.setInt('userCoins', coins);
  }

  Future<int> loadUserCoins() async {
    final prefs = await _prefs;

    return prefs.getInt('userCoins') ?? Constants.userStartCoins;
  }

  Future<void> saveSoundStatus(bool value) async {
    final prefs = await _prefs;

    await prefs.setBool('soundStatus', value);
  }

  Future<bool> loadSoundStatus() async {
    final prefs = await _prefs;

    return prefs.getBool('soundStatus') ?? false;
  }

  Future<void> saveVibrationStatus(bool value) async {
    final prefs = await _prefs;

    await prefs.setBool('vibrationStatus', value);
  }

  Future<bool> loadVibrationStatus() async {
    final prefs = await _prefs;

    return prefs.getBool('vibrationStatus') ?? false;
  }

  Future<void> saveUserScore(int score) async {
    final prefs = await _prefs;

    await prefs.setInt('userScore', score);
  }

  Future<int> loadUserScore() async {
    final prefs = await _prefs;
    return prefs.getInt('userScore') ?? 0;
  }

  Future<void> saveUserLives(int lives) async {
    final prefs = await _prefs;

    await prefs.setInt('userLives', lives);
  }

  Future<int> loadUserLives() async {
    final prefs = await _prefs;
    return prefs.getInt('userLives') ?? 3;
  }

  //
  // Future<void> saveUserWins(int wins) async {
  //   final prefs = await _prefs;
  //
  //   await prefs.setInt('userWins', wins);
  // }
  //
  // Future<int> loadUserWins() async {
  //   final prefs = await _prefs;
  //
  //   return prefs.getInt('userWins') ?? 0;
  // }
  //
  // Future<void> saveUserDefeats(int defeats) async {
  //   final prefs = await _prefs;
  //
  //   await prefs.setInt('userDefeats', defeats);
  // }
  //
  // Future<int> loadUserDefeats() async {
  //   final prefs = await _prefs;
  //
  //   return prefs.getInt('userDefeats') ?? 0;
  // }
}
