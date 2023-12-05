import 'package:mini_football/src/utils/library.dart';

import '../../game_field_page/controller/game_page_controller.dart';
import '../../game_field_page/view/game_page.dart';

class HomeAppPageController {
  static void onPlayTap(BuildContext context, WidgetRef ref) {
    final isBetted = ref.read(gameProvider).isBetted;
    if(isBetted) {
      ref.read(gameProvider.notifier).resetScores();
      ref.read(gameProvider.notifier).changeStopGame(false);
      ref.read(gameProvider.notifier).changeMatchEnd(false);

      Navigator.pushNamed(context, const GamePage().route);
    }
  }
}
