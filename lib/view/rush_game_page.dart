

import 'dart:async';
import 'dart:math';
import 'package:bomb_game/utils/adMob.dart';
import 'package:bomb_game/utils/setting.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:bomb_game/view/home_page.dart';
import 'package:bomb_game/view/result_page.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:heroicons/heroicons.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/buttons.dart';
import '../utils/mode_converter.dart';
import '../utils/original_theme_font.dart';
import 'audio_players.dart';
import 'setting_page.dart';


class RushGamePage extends StatefulWidget {
  const RushGamePage({Key? key}) : super(key: key);

  @override
  _RushGamePageState createState() => _RushGamePageState();
}

class _RushGamePageState extends State<RushGamePage> {

  bool isIgnore = false;
  int counter = 0;
  Timer? minutesTimer;
  int countTimer = 0;

  void startMinutes(){
    minutesTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          countTimer ++;
        });
        if(countTimer == Setting.stopTime){
          minutesTimer!.cancel();
        }
      });
    // if(minutesTimer == null){
    //   minutesTimer = Timer(Duration(seconds: Setting.stopTime),()async{
    //     setState(() {
    //       isIgnore = true;
    //     });
    //     Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.topToBottom, child: ResultPage()));
    //   });
    // }
  }

  void buttonFunction(){
    startMinutes();
    AudioPlayers.playAsset(SharedPreference().selectVoice);
    setState(() {
      counter++;
    });
    print(counter);
    if(minutesTimer!.tick == Setting.stopTime){
      setState(() {
        isIgnore = true;
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ResultPage()));
      });
    }
  }

  Widget choseButton(){
    List<Widget> buttons = [
      Buttons.dangerousButton(function: buttonFunction),
      Buttons.emergencyButton(function: buttonFunction),
      Buttons.callButton(function: buttonFunction),
    ];
    if(SharedPreference().selectButton == Setting.buttonNames[0]){
      return buttons[0];
    }else if(SharedPreference().selectButton == Setting.buttonNames[1]){
      return buttons[1];
    }else{
      return buttons[2];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print('chairs${Setting.isChairsGame}');
    print('bomb${Setting.isBombGame}');
    print('rush${Setting.isRushGame}');
    print(Setting.stopTime);
    SharedPreference().getVoice;
    ModeConverter.resultImages.shuffle();
    print('resultImageをシャッフルしたよ');
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    AdMob.myBanner().dispose();
    if(minutesTimer != null){
      minutesTimer!.cancel();
    }
    // ignore: avoid_print
    print('バナーを破棄しました。');
    super.dispose();
  }

  // bool isAudioFinish = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'れんだゲーム',
            style: OriginalThemeFont.appBarFont
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const HomePage()));
          },
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const SettingPage()));
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: HeroIcon(HeroIcons.cog,size: 32,),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                height: 100,
                child: AdMob.bannerAdArea(child: AdWidget(ad: AdMob.myBanner()))
            ),
            Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      minutesTimer != null
                          ? countTimer.toString()
                          : '押すと始まるよ',
                      style: OriginalThemeFont.resultFont,
                    ),
                  ),
                )
            ),
            IgnorePointer(
              ignoring: isIgnore,
              child: choseButton()
            ),
            const Expanded(
              child: SizedBox(),
            ),
            SizedBox(
                height: 100,
                child: AdMob.bannerAdArea(child: AdWidget(ad: AdMob.myBanner()))
            ),
          ],
        ),
      ),
    );
  }
}
