import 'package:mini_football/src/universal_widgets/my_button.dart';
import 'package:mini_football/src/utils/library.dart';

import '../../../../../universal_widgets/my_text_button.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/my_colors.dart';
import '../../../../../utils/my_parameters.dart';
import '../../../game_field_page/controller/game_page_controller.dart';

class MainGameDialog extends ConsumerStatefulWidget {
  const MainGameDialog({super.key});

  @override
  ConsumerState createState() => _MainGameDialogState();
}

class _MainGameDialogState extends ConsumerState<MainGameDialog> {
  TextEditingController betController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.shortestSide;
    final width = MediaQuery.of(context).size.longestSide;

    final game = ref.watch(gameProvider);
    return Container(
      height: height * 0.6,
      width: width * 0.5,
      decoration: BoxDecoration(
          borderRadius: MyParameters(context).roundedBorders,
          color: MyColors.whiteColor!.withOpacity(0.8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('LIFES:'),
          SizedBox(
            width: width*0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  game.lifes,
                  (index) => Image.asset(
                        Constants.ballImg,
                        height: height * 0.1,
                      )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Money: ${game.userMoney}'),
              const SizedBox(width: 5,),
              Image.asset(Constants.ballImg, height: height*0.05,)
            ],
          ),
          SizedBox(
            height: height * 0.23,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: width * 0.05,
                    width: height * 0.35,
                    child: TextField(
                      controller: betController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 12.0, left: 10),
                        hintText: 'input bet',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    )),
                MyButton(
                    text: 'Bet',
                    function: () =>
                        GameControl.onTapConfirmButton(ref, betController.text),
                    height: height*1.3)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
