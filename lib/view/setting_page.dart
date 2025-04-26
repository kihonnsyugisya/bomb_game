
import 'package:bomb_game/utils/adMob.dart';
import 'package:bomb_game/utils/mode_converter.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:bomb_game/view/bomb_game_page.dart';
import 'package:bomb_game/view/button_select_page.dart';
import 'package:bomb_game/view/chairs_game_page.dart';
import 'package:bomb_game/view/rush_game_page.dart';
import 'package:bomb_game/view/voice_select_page.dart';
import 'package:bomb_game/view/playing_page.dart';
import 'package:bomb_game/view/shop_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heroicons/heroicons.dart';
import 'package:launch_review/launch_review.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/buttons.dart';
import '../utils/color/original_theme_color.dart';
import '../utils/dialogs.dart';
import '../utils/original_theme_font.dart';
import '../utils/setting.dart';
import '../utils/url_launcher.dart';
import 'home_page.dart';
import 'punishment_page.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isPunishment = SharedPreference().isPunishment;
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'せってい',
            style: OriginalThemeFont.appBarFont
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            if(Setting.isChairsGame){
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const ChairsGamePage()));
            }else if(Setting.isBombGame){
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const BombGamePage()));
            }else if(Setting.isRushGame){
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const RushGamePage()));
            }else{
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const HomePage()));
            }
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    '設定',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth * 0.85,
                  decoration: BoxDecoration(
                    color: OriginalThemeColor.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: OriginalThemeColor.gray,
                        width: 0.5
                    ),
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MoreButton(
                            text: const Text('ボタンをへんこうする'),
                            onTap: (){
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ButtonSelectPage()));
                            },
                            icon: Icon(Icons.radio_button_checked,size: 20,color: OriginalThemeColor.retro1,)),
                        MoreButton.bottomLine,
                        Setting.isChairsGame
                            ? MoreButton(
                                  text: const Text('ミュージックをかえる'),
                                    onTap: () {
                                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: ShopPage()));
                                    },
                                    icon: Icon(Icons.music_note,
                                      color: OriginalThemeColor.star,))
                            : MoreButton(
                                  text: const Text('こうか音をかえる'),
                                  onTap: (){
                                    if(AdMob.myRewardAd == null){
                                      AdMob.loadReward();
                                    }
                                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: VoiceSelectPage()));
                                  },
                                  icon: Icon(Icons.music_note,color: OriginalThemeColor.star,)),
                        MoreButton.bottomLine,
                        Setting.isHomePage
                            ? const SizedBox()
                            : MoreButton(
                                  text: const Text('ばつゲームをせっていする'),
                                  onTap: (){
                                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: PunishmentPage()));
                                  },
                                  icon: Icon(FontAwesomeIcons.bomb,size: 18,color: OriginalThemeColor.black,)
                        ),

                        MoreButton.bottomLine,
                        BoolButton(text: Text('おした時のしんどう'), icon: Icon(Icons.vibration), isActive: SharedPreference().isVibration, onChanged: (bool value){
                          setState(() {
                            SharedPreference().setVibration(value);
                          });
                        }),
                        MoreButton.bottomLine,
                        Setting.isHomePage
                            ? const SizedBox()
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          ModeConverter.maxCountText(),
                                          style: TextStyle(
                                            fontSize: 12
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Slider(
                                    value: SharedPreference().myPitch.toDouble(),
                                    min: 15,
                                    max: 90,
                                    divisions: 5,
                                    label: '${SharedPreference().myPitch.toString()}秒',
                                    onChanged: (double value) {
                                      setState(() {
                                        SharedPreference().myPitch = value.toInt();
                                        print(value);
                                        // print(values);
                                      });
                                    },
                                    onChangeEnd: (double value){
                                      setState(() {
                                        SharedPreference().setMyPitch();
                                        print('value saved');
                                      });
                                    },
                                  ),
                                ],
                        ),
                      ]
                  ),
                ),
                const SizedBox(height: 24,),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'その他',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth * 0.85,
                  decoration: BoxDecoration(
                    color: OriginalThemeColor.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: OriginalThemeColor.gray,
                        width: 0.5
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MoreButton(
                          text: const Text('アプリを評価する'),
                          onTap: (){
                            LaunchReview.launch(
                                writeReview: true,iOSAppId: "1635106525"
                            );
                          },
                          icon: Icon(Icons.star,color: OriginalThemeColor.star,)),
                      MoreButton.bottomLine,
                      MoreButton(
                        text: const Text('シェアする'),
                        onTap: (){
                          UrlLauncher.tweet(text: '日常でよく見かけるあのボタンを好きなだけ押しまくれたらなぁ。を叶えるアプリが登場。早速ダウンロードして、好きなだけ押してください。');
                        },
                        icon: Icon(FontAwesomeIcons.twitter,size: 20,color: OriginalThemeColor.twitter,),),
                      MoreButton.bottomLine,
                      MoreButton(
                          text: const Text('ライセンス'),
                          onTap: (){
                            Dialogs.licenseDialog(context);
                          },
                          icon: const Icon(CupertinoIcons.doc)),
                      MoreButton.bottomLine,
                      MoreButton(
                          text: const Text('プライバシーポリシー'), onTap: (){
                            UrlLauncher.privacyPolicy();
                            },
                          icon: const Icon(Icons.privacy_tip_outlined)),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
