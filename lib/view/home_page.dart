
import 'dart:async';

import 'package:animated_button/animated_button.dart';
import 'package:bomb_game/utils/mode_converter.dart';
import 'package:bomb_game/view/bomb_game_page.dart';
import 'package:bomb_game/view/chairs_game_page.dart';
import 'package:bomb_game/view/playing_page.dart';
import 'package:bomb_game/view/rush_game_page.dart';
import 'package:bomb_game/view/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:heroicons/heroicons.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/adMob.dart';
import '../utils/buttons.dart';
import '../utils/color/original_theme_color.dart';
import '../utils/review.dart';
import '../utils/setting.dart';
import '../utils/shared_preference.dart';
import 'audio_players.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AssetImage? image;
  StreamController counterStreamer = StreamController();

  @override
  void initState() {
    counterStreamer.stream.listen((data) {
      if(SharedPreference().isVibration){
        setState(() {
          HapticFeedback.mediumImpact();
        });
        print('受信したデータ：$data');
      }
    });
    print(ModeConverter.resultImages);
    Setting.isHomePage = true;
    Setting.isBombGame = false;
    Setting.isRushGame = false;
    Setting.isChairsGame = false;
    image = AssetImage(
      Setting.getResultImage('assets/other_image/ezgif.com-gif-maker.gif'),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AdMob.myBanner().dispose();
    image!.evict();
    counterStreamer.close();
    super.dispose();
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

  Future<void> buttonFunction() async {
    counterStreamer.sink.add(1);
    await AudioPlayers.playAsset(SharedPreference().selectVoice);
  }



  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 100,
                  child: AdMob.bannerAdArea(child: AdWidget(ad: AdMob.myBanner()))
              ),
              const Expanded(child: SizedBox()),
              choseButton(),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Buttons.modeButton(
                      width: 96,
                      color: OriginalThemeColor.white,
                      onPressed: ()async{
                        if(await Review.inAppReview.isAvailable() && SharedPreference().totalCount % 5 == 0){
                          Review.requestReview();
                        }
                        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const BombGamePage()));
                        Setting.isChairsGame = false;
                        Setting.isBombGame = true;
                        Setting.isRushGame = false;
                        Setting.isHomePage = false;
                      },
                      icon: Icon(
                        FontAwesomeIcons.bomb,
                        size: 30,
                      ),
                      string: 'ばくだん\nゲーム',
                  ),
                  Buttons.modeButton(
                    width: 96,
                    color: OriginalThemeColor.white,
                    onPressed: (){
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const ChairsGamePage()));
                      Setting.isChairsGame = true;
                      Setting.isBombGame = false;
                      Setting.isRushGame = false;
                      Setting.isHomePage = false;
                    },
                    icon: Icon(
                      FontAwesomeIcons.chair,
                      size: 30,
                    ),
                    string: 'いすとり\nゲーム',
                  ),
                  Buttons.modeButton(
                    width: 96,
                    color: OriginalThemeColor.white,
                    onPressed: (){
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const SettingPage()));
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: HeroIcon(
                        HeroIcons.cog,
                        size: 30,
                      ),
                    ),
                    string: '設定',
                  ),
                ],
              ),
              const SizedBox(height: 24,),
              SizedBox(
                  height: 100,
                  child: AdMob.bannerAdArea(child: AdWidget(ad: AdMob.myBanner()))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
