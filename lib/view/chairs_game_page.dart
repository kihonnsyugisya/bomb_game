

import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bomb_game/utils/adMob.dart';
import 'package:bomb_game/utils/mode_converter.dart';
import 'package:bomb_game/utils/original_theme_font.dart';
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
import 'audio_players.dart';
import 'setting_page.dart';


class ChairsGamePage extends StatefulWidget {
  const ChairsGamePage({Key? key}) : super(key: key);

  @override
  _ChairsGamePageState createState() => _ChairsGamePageState();
}

class _ChairsGamePageState extends State<ChairsGamePage> {

  bool isIgnore = false;
  String text = '準備はOK？';
  Timer? timer;
  Timer? textTimer;
  StreamSubscription<PlayerState>? audioStreamers;
  PlayerState? playerState;

  Future<void>? stopTimer(){
    timer = Timer(Duration(seconds: Setting.stopTime + 5),()async{
      if(playerState == PlayerState.PLAYING || playerState == PlayerState.COMPLETED){
        await AudioPlayers.audioPlayer.pause();
        print('止めるぜ');
      }else{
        print('止めれねぇ');
      }
    });
    print('null');
    return null;
  }

  void setPlayingText(){
    textTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      List<String> messageList = [
        'まわってまわって',
        '再生中はボタンは押せないよ',
        'どきどき…',
        'ざわ‥ざわ‥',
        'いつ止まるの？',
      ];
      messageList.shuffle();
      setState(() {
        text = messageList.first;
      });
    });

  }

  // late Timer playingText = Timer.periodic(const Duration(seconds: 4), (timer) {
  //   List<String> messageList = [
  //     'まわってまわって',
  //     '再生中はボタンは押せないよ',
  //     'どきどき…',
  //     'ざわ‥ざわ‥',
  //   ];
  //   messageList.shuffle();
  //   setState(() {
  //     text = messageList.first;
  //   });
  // });


  void buttonFunction(){
    if(SharedPreference().isVibration){
      setState(() {
        HapticFeedback.mediumImpact();
      });
    }
      Setting.stopTime = Random().nextInt(SharedPreference().myPitch);
      print(Setting.stopTime);

      if(AudioPlayers.playerState == PlayerState.PAUSED){
        AudioPlayers.audioPlayer.resume();
        stopTimer();
        if(timer != null){
          print(timer!.isActive);
        }
      }else{
        AudioPlayers.playLocal(SharedPreference().selectAudio);
        stopTimer();
        if(timer != null){
          print(timer!.isActive);
        }
      }

      // Timer(Duration(seconds: Setting.stopTime + 5), ()async{
      //   if(AudioPlayers.playerState == PlayerState.PLAYING || AudioPlayers.playerState == PlayerState.COMPLETED){
      //     await AudioPlayers.audioPlayer.pause();
      //   }
      // });
      print('stop');
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // TODO: implement initState
    ModeConverter.image = AssetImage(
        ModeConverter.resultImages.first
    );
    print('chairs${Setting.isChairsGame}');
    print('bomb${Setting.isBombGame}');
    print('rush${Setting.isRushGame}');
    ModeConverter.resultImages.shuffle();
    print('resultImageをシャッフルしたよ');
    Setting.stopTime = Random().nextInt(SharedPreference().myPitch);
    print(Setting.stopTime);
    SharedPreference().getVoice;
    audioStreamers =
    AudioPlayers.audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      playerState = state;
      AudioPlayers.playerState = state;
      print(playerState);
      if(mounted && AudioPlayers.playerState == PlayerState.PLAYING){
        setState(() {
          isIgnore = true;
          text = 'スタート！';
          setPlayingText();
          print(text);
          print('rocking');
        });
      }else if(mounted && AudioPlayers.playerState == PlayerState.STOPPED){
        setState(() {
          isIgnore = false;
          if(textTimer != null){
            textTimer!.cancel();
          }
          print('タイマーキャンセル');
          text = 'ストップ！';
        });
        print('un rocking');
      }else if(mounted && AudioPlayers.playerState == PlayerState.PAUSED){
        setState(() {
          isIgnore = false;
          if(textTimer != null){
            textTimer!.cancel();
          }
          print('タイマーキャンセル');
          text = 'ストップ！';
        });
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.topToBottom, child: ResultPage()));
        print('tootta');

      }else{
        print('読み込めんかった');
      }
    });
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    AdMob.myBanner().dispose();
    // ignore: avoid_print
    print('バナーを破棄しました。');
    if(timer != null && timer!.isActive){
      timer!.cancel();
      print('タイマーを破棄しました。');
    }
    if(textTimer != null){
      textTimer!.cancel();
    }
    if(playerState == PlayerState.PLAYING){
      AudioPlayers.audioPlayer.stop();
    }
    if(audioStreamers != null){
      audioStreamers!.cancel();
      print('ストリーミングをキャンセル');
    }
    super.dispose();
  }

  // bool isAudioFinish = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'いすとりゲーム',
          style: OriginalThemeFont.appBarFont
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: ()async{
            if(playerState == PlayerState.PLAYING){
              await AudioPlayers.audioPlayer.stop();
              print('音楽止めてから移動しなー');
            }
            // ignore: use_build_context_synchronously
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
                      text,
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
