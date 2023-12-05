import 'dart:async';
import 'package:mini_football/src/utils/library.dart';
import 'package:mini_football/src/utils/my_colors.dart';
import '../../../../universal_widgets/my_button.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/my_parameters.dart';
import '../controller/tutorial_page_controller.dart';

class TutorialPageView extends ConsumerStatefulWidget {
  const TutorialPageView({super.key});
  final route = 'tutorial page';

  @override
  ConsumerState createState() => _TutorialPageViewState();
}

class _TutorialPageViewState extends ConsumerState<TutorialPageView> {
  static const team1ImgList = [
    'assets/images/Team 1 throw.png',
    'assets/images/Team 1 throw 2.png'
  ];
  static const team2ImgList = [
    'assets/images/Team 2 throw.png',
    'assets/images/Team 2 throw 2.png'
  ];
  static const ballPositions = [0.175, 0.775];
  late Timer _ballPositionTimer;
  late double ballPosition;
  late String team1Img;
  late String team2Img;

  @override
  void initState() {
    super.initState();
    ballPosition = ballPositions[0];
    team1Img = team1ImgList[0];
    team2Img = team2ImgList[0];
    _ballPositionTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final newPositionIndex = timer.tick % ballPositions.length;
      ballPosition = ballPositions[newPositionIndex];
      final playerIndex = newPositionIndex == 0 ? 1 : 0;
      team1Img = team1ImgList[newPositionIndex];
      team2Img = team2ImgList[playerIndex];

      setState(() {});
    });
  }

  @override
  void dispose() {
    _ballPositionTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,]);
    final height = MediaQuery.of(context).size.longestSide;
    final width = MediaQuery.of(context).size.shortestSide;
    final orientationPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
                    physics: orientationPortrait
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    child: Center(
                        child: SizedBox(
                      height: height,
                      width: width,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(Constants.tutorialBackImg),
                          Positioned(
                            top: height * 0.25,
                            child: SizedBox(
                              width: width * 0.8,
                              child: Text(
                                Constants.tutorialText,
                                style: TextStyle(
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          buildPlayer(height, width, 0.1, team1Img),
                          buildPlayer(height, width, 0.7, team2Img),
                          buildBall(height, width, ballPosition),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.68),
                            child: MyButton(
                                text: 'Close',
                                function: () =>
                                    TutorialPageController.onCloseTap(context),
                                height: height),
                          )
                        ],
                      ),
                    ))))));
  }

  AnimatedPositioned buildBall(
      double height, double width, double ballPosition) {
    return AnimatedPositioned(
        top: height * 0.65,
        left: width * ballPosition,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
        child: Image.asset(
          'assets/images/Ball.png',
          height: height * 0.03,
        ));
  }

  Positioned buildPlayer(
      double height, double width, double leftShift, String img) {
    return Positioned(
        top: height * 0.6,
        left: width * leftShift,
        child: Image.asset(
          img,
          height: height * 0.1,
        ));
  }
}
