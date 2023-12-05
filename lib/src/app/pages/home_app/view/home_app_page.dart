import 'package:mini_football/src/app/pages/home_app/view/widgets/main_game_dialog.dart';
import 'package:mini_football/src/app/pages/home_app/view/widgets/restart_game_dialog.dart';
import 'package:mini_football/src/app/pages/home_app/view/widgets/result_dialog.dart';
import 'package:mini_football/src/utils/library.dart';

import '../../../../universal_widgets/my_button.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/my_parameters.dart';

import '../../../../utils/library.dart';
import '../../../../utils/my_colors.dart';
import '../../game_field_page/controller/game_page_controller.dart';
import '../../game_field_page/model/game.dart';

import '../controller/home_app_page_controller.dart';

class HomeAppPage extends ConsumerStatefulWidget {
  const HomeAppPage({
    Key? key,
  }) : super(key: key);

  final String route = 'home app page';

  @override
  ConsumerState createState() => _HomeAppPageState();
}

class _HomeAppPageState extends ConsumerState<HomeAppPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final height = MediaQuery.of(context).size.shortestSide;
    final width = MediaQuery.of(context).size.longestSide;

    final game = ref.watch(gameProvider);
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
              body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Constants.mainGameBackImg),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (game.showStartDialog && !game.showRestartGameDialog)
                      buildStartPage(height, width, context, game),
                    if (game.showResultDialog && !game.showRestartGameDialog)
                      const ResultDialog(),
                    if (game.showRestartGameDialog) const RestartGameDialog()
                  ],
                ),
              ),
            ),
          )),
        ),
        onWillPop: () async {
          return false;
        });
  }

  SizedBox buildStartPage(
      double height, double width, BuildContext context, GameState game) {
    return SizedBox(
      height: height * 0.77,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const MainGameDialog(),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.00),
            child: Opacity(
              opacity: game.isBetted ? 1 : 0.5,
              child: Column(
                children: [
                  MyButton(
                      text: "Play",
                      function: () {
                        HomeAppPageController.onPlayTap(context, ref);
                      },
                      height: height * 1.3),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
