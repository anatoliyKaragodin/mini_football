import 'package:mini_football/src/utils/library.dart';

import '../../../../../universal_widgets/my_text_button.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_parameters.dart';
import '../../../game_field_page/controller/game_page_controller.dart';

class ResultDialog extends ConsumerStatefulWidget {
  const ResultDialog({super.key});

  @override
  ConsumerState createState() => _ResultDialogState();
}

class _ResultDialogState extends ConsumerState<ResultDialog> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.shortestSide;
    final width = MediaQuery.of(context).size.longestSide;
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final game = ref.watch(gameProvider);
    final score = game.teamsScore.isNotEmpty? game.teamsScore: [0,17];
    final isWin = score[0]>score[1];
    final isDraw = score[0]==score[1];
    return Container(
        height: height * 0.5,
        width: width * 0.6,
        decoration: BoxDecoration(
            borderRadius: MyParameters(context).roundedBorders,
            color: MyColors.whiteColor!.withOpacity(0.8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(!isDraw) Text(
              'DEFEAT',
              textAlign: TextAlign.center,
              style: MyParameters(context).middleTextStyle,
            ),
            // if(!isDraw)Image.asset(isWin?Constants.winnerImg:Constants.looseImg),
            if(isDraw) Text(
              'DRAW',
              textAlign: TextAlign.center,
              style: MyParameters(context).middleTextStyle,
            ),
            Text(
              'SCORE:\n${score[0]}-${score[1]}',
              textAlign: TextAlign.center,
            ),
           if(isWin) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You win: ${game.bet*2}  '),
                // Image.asset(Constants.coinsImg, height: height*0.03,)
              ],
            ),
            MyTextButton(
                text: 'Close',
                function: () {
                  GameControl.onCloseResultTap(ref, isWin, isDraw);
                },
                height: height),
          ],
        ));
  }
}
