

import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bomb_game/utils/adMob.dart';
import 'package:bomb_game/utils/mode_converter.dart';
import 'package:bomb_game/utils/setting.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:bomb_game/utils/text_fields.dart';
import 'package:bomb_game/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nice_buttons/nice_buttons.dart';
import '../utils/buttons.dart';
import 'audio_players.dart';
import 'setting_page.dart';


class PlayingPage extends StatefulWidget {
  const PlayingPage({Key? key}) : super(key: key);

  @override
  _PlayingPageState createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {

  bool isIgnore = false;
  int counter = 0;


  @override
  void initState() {
    // TODO: implement initState
    print('chairs${Setting.isChairsGame}');
    print('bomb${Setting.isBombGame}');
    print('rush${Setting.isRushGame}');
    Setting.stopTime = Random().nextInt(SharedPreference().myPitch);
    print(Setting.stopTime);
    SharedPreference().getVoice;
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    AdMob.myBanner().dispose();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingPage()));
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
            const Expanded(
              child: SizedBox(),
            ),
            IgnorePointer(
              ignoring: isIgnore,
              child: Buttons.callButton(function: ()async{
                setState(() {
                  // if(SharedPreference().isVibration){
                  //   HapticFeedback.mediumImpact();
                  // }
                });
                if(Setting.isChairsGame){
                  Setting.stopTime = Random().nextInt(SharedPreference().myPitch);
                  print(Setting.stopTime);
                  AudioPlayers.playLocal(SharedPreference().selectAudio);
                  setState(() {
                    isIgnore = true;
                    print('rocked');
                  });
                  Timer(Duration(seconds: 3), () => print('時間が経過しました！'));
                // 　再生中に押は再度押せないようにしたいが、なぜかawaitが聞かないので曲が鳴り止む前に、unrokedになってしまう。
                  Timer(Duration(seconds: Setting.stopTime + 5), () async => await AudioPlayers.audioPlayer.stop());
                  setState(() {
                    isIgnore = false;
                    print('unrocked');
                  });
                  print('stop');
                }else if(Setting.isBombGame){
                  AudioPlayers.audioPlay(fileName: SharedPreference().selectVoice);
                  counter ++;
                  print(counter);
                  if(counter == Setting.stopTime){
                    SharedPreference().selectVoice = 'other/shout.mp3';
                  }
                }else{
                  // rushgameの関数を記入
                  AudioPlayers.audioPlay(fileName: SharedPreference().selectVoice);
                }
              }),
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
