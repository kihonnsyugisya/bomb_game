
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bomb_game/utils/color/original_theme_color.dart';
import 'package:bomb_game/utils/mode_converter.dart';
import 'package:bomb_game/utils/original_theme_font.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:bomb_game/view/rush_game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/adMob.dart';
import '../utils/buttons.dart';
import '../utils/dialogs.dart';
import '../utils/setting.dart';
import 'bomb_game_page.dart';
import 'chairs_game_page.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int openPunishment = 500;
  static String? resultImagePath;
  AssetImage? image;
  String? punishmentText;

  @override
  void initState() {
    // TODO: implement initState
    resultImagePath = ModeConverter.resultImages.first;
    // image = AssetImage(
    //   Setting.getResultImage(resultImagePath!),
    // );
    punishmentText = ModeConverter.getPunishmentText();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // image!.evict();
    ModeConverter.image!.evict();
    AdMob.myBanner().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: deviceHeight * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ModeConverter.resultText1(),
                    style: OriginalThemeFont.resultFont,
                  ),
                  Setting.isChairsGame
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "押した回数 : ",
                                  style: TextStyle(
                                    color: OriginalThemeColor.black,
                                      fontSize: 18
                                  )
                                ),
                                Text(
                                  '${Setting.stopTime.toString()}かい',
                                    style: TextStyle(
                                        color: OriginalThemeColor.black,
                                        fontSize: 18
                                    )
                                ),
                              ],
                            ),
                            onPressed: (){},
                          ),
                          // child: AnimatedTextKit(
                          //   animatedTexts: [
                          //     TypewriterAnimatedText(
                          //       '押した回数',
                          //       textStyle: OriginalThemeFont.resultMessageFont,
                          //       speed: const Duration(milliseconds: 300),
                          //     ),
                          //     TypewriterAnimatedText(
                          //       '${Setting.stopTime.toString()}かい',
                          //       textStyle: OriginalThemeFont.resultMessageFont,
                          //       speed: const Duration(milliseconds: 100),
                          //     ),
                          //   ],
                          //   totalRepeatCount: 1,
                          //   displayFullTextOnTap: false,
                          //   stopPauseOnTap: false,
                          // ),
                  ),
                  SharedPreference().isPunishment
                      ? Text(
                          "ばつゲーム : ${punishmentText!}",
                          style: const TextStyle(
                              fontSize: 18,
                          ),
                  )
                      : const SizedBox(),
                  TextButton(
                    onPressed: ()async{
                      if(Setting.isChairsGame){

                        if(AdMob.myInterstitialAd != null){
                          AdMob.myInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
                              onAdDismissedFullScreenContent: (InterstitialAd ad){
                                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                                // ignore: avoid_print
                                print('バーを復活');
                                ad.dispose();
                                AdMob.loadInterstitial();
                                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.bottomToTop, child: const ChairsGamePage()));
                              },
                              onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error){
                                ad.dispose();
                                AdMob.loadInterstitial();
                              }
                          );
                          await AdMob.myInterstitialAd!.show();

                        }else{
                          // await AdMob.loadInterstitial();
                          Dialogs.netWorkErrorDialog(
                              context: context,
                              onPressed: (){
                                AdMob.loadInterstitial();
                                Navigator.of(context).pop();
                              }
                          );
                        }

                      }else if(Setting.isBombGame){

                        if(AdMob.myInterstitialAd != null){
                          AdMob.myInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
                              onAdDismissedFullScreenContent: (InterstitialAd ad){
                                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                                // ignore: avoid_print
                                print('バーを復活');
                                ad.dispose();
                                AdMob.loadInterstitial();
                                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.bottomToTop, child: const BombGamePage()));
                              },
                              onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error){
                                ad.dispose();
                                AdMob.loadInterstitial();
                              }
                          );
                          await AdMob.myInterstitialAd!.show();
                        }else{
                          // await AdMob.loadInterstitial();
                          Dialogs.netWorkErrorDialog(
                              context: context,
                              onPressed: (){
                                AdMob.loadInterstitial();
                                print(AdMob.myInterstitialAd);
                                Navigator.of(context).pop();
                              }
                          );
                        }
                      }else{
                        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.bottomToTop, child: const RushGamePage()));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '戻る',
                        style: OriginalThemeFont.resultFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: deviceHeight * 0.5,
                child: Image(
                  // image: image as ImageProvider,
                  image: ModeConverter.image as ImageProvider,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
            ),
          ],
        ),
      ),
    );
  }
}


