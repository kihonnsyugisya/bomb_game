

import 'dart:async';
import 'dart:math';
import 'package:bomb_game/utils/adMob.dart';
import 'package:bomb_game/utils/custom_card.dart';
import 'package:bomb_game/utils/setting.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:bomb_game/view/home_page.dart';
import 'package:bomb_game/view/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:heroicons/heroicons.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/buttons.dart';
import '../utils/mode_converter.dart';
import '../utils/original_theme_font.dart';
import 'audio_players.dart';
import 'setting_page.dart';


class BombGamePage extends StatefulWidget {
  const BombGamePage({Key? key}) : super(key: key);

  @override
  _BombGamePageState createState() => _BombGamePageState();
}

class _BombGamePageState extends State<BombGamePage> {

  bool isIgnore = false;
  int counter = 0;
  String text = 'おしてごらん';
  Timer? textTimer;
  List<String> messageList = [];
  List<String> messageListContents = [
    'このボタンは',
    'ある回数をおすと',
    'ばくはつするよ',
    'ばくはつさせた人が負けだよ',
    'すきなだけおして',
    '次の人にボタンをわたしてね',
  ];
  StreamController counterStreamer = StreamController();

  Future<void> stopLittleTime(int seconds)async{
    print('delay now');
    await Future.delayed(Duration(seconds: seconds));
  }

  void buttonFunction() async {
    await AudioPlayers.playAsset(SharedPreference().selectVoice);
    counterStreamer.sink.add(1);
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

  // void setPlayingText(){
  //
  //   setState(() {
  //     text = messageList[counter];
  //   });
  //
  // }

  void setPlayingText(){
    int counter = 0;
    textTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        text = messageListContents[counter];
      });
      counter ++;
      if(counter == messageListContents.length){
        counter = 0;
        print("end");
      }
    });

  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    ModeConverter.image = const AssetImage(
        "assets/other_image/ezgif.com-gif-maker.gif"
      );
    setPlayingText();
    counterStreamer.stream.listen((data) {
      if(SharedPreference().isVibration){
        setState(() {
          HapticFeedback.mediumImpact();
        });
      }
      print('受信したデータ：$data');
      counter += data as int;
      if(counter == Setting.stopTime -1){
        SharedPreference().selectVoice = Setting.bombsAudio();
      }else if(counter == Setting.stopTime){
        setState(() {
          isIgnore = true;
        });
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade,duration: const Duration(seconds: 1), child: ResultPage()));
        SharedPreference().totalCount += counter;
        SharedPreference().setTotalCount();
        print('只今の記録：${SharedPreference().totalCount}');
      }

    });
    // TODO: implement initState
    print('chairs${Setting.isChairsGame}');
    print('bomb${Setting.isBombGame}');
    print('rush${Setting.isRushGame}');
    for(var i = 0; i < 7; i++){
      messageList.addAll(messageListContents);
    }
    Setting.stopTime = Random().nextInt(SharedPreference().myPitch) + 2;
    print(Setting.stopTime);
    SharedPreference().getVoice;
    ModeConverter.resultImages.shuffle();
    print('resultImageをシャッフルしたよ');
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    AdMob.myBanner().dispose();
    counterStreamer.close();
    if(textTimer!.isActive){
      print("テキストタイマーを破棄しました");
      textTimer!.cancel();
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
            'ばくだんゲーム',
            style: OriginalThemeFont.appBarFont
        ),
        leading: IgnorePointer(
          ignoring: isIgnore,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const HomePage()));
            },
          ),
        ),
        actions: [
          IgnorePointer(
            ignoring: isIgnore,
            child: IconButton(
                onPressed: (){
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const SettingPage()));
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: HeroIcon(HeroIcons.cog,size: 32,),
                )),
          )
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
              child: SizedBox(
                  child: Container(
                    child: Center(
                      child: Text(
                        text,
                        style: OriginalThemeFont.resultFont,
                      ),
                    ),
                  )
              ),
            ),
            IgnorePointer(
              ignoring: isIgnore,
              child: choseButton(),
              // child: Buttons.callButton(
              //     function: (){
              //       setState(() {// if(SharedPreference().isVibration){
              //     //   HapticFeedback.mediumImpact();
              //     // }
              //   });
              //       AudioPlayers.audioPlay(fileName: SharedPreference().selectVoice);
              //       counter ++;
              //       print(counter);
              //       if(counter == Setting.stopTime - 1){
              //         SharedPreference().selectVoice = 'other/shout.mp3';
              //         print('終わったな');
              //       }
              //       if(counter == Setting.stopTime){
              //         setState(() {
              //           isIgnore = true;
              //         });
              //         SharedPreference().totalCount += counter;
              //         SharedPreference().setTotalCount();
              //         print('只今の記録：${SharedPreference().totalCount}');
              //       }
              //     }
              // ),
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
