
import 'dart:math';

import 'package:animated_button/animated_button.dart';
import 'package:bomb_game/utils/color/original_theme_color.dart';
import 'package:bomb_game/utils/mode_converter.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:bomb_game/view/audio_players.dart';
import 'package:bomb_game/view/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:launch_review/launch_review.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/adMob.dart';
import '../utils/buttons.dart';
import '../utils/dialogs.dart';

class VoiceSelectPage extends StatefulWidget {
  @override
  _VoiceSelectPageState createState() => _VoiceSelectPageState();
}

class _VoiceSelectPageState extends State<VoiceSelectPage> {
  int coin = 0;

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'こうか音をかえる'
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const SettingPage()));
              },
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: '元気な女の子'),
                Tab(text: 'ボタン音'),
                Tab(text: 'その他'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              contents(deviceWidth: deviceWidth,list: VoiceSelectBox.girlList, lock: SharedPreference().girlLock, deviceHeight: deviceHeight * 0.16),
              contents(deviceWidth: deviceWidth,list: VoiceSelectBox.buttonList ,lock: false, deviceHeight: deviceHeight * 0.16),
              contents(deviceWidth: deviceWidth,list: VoiceSelectBox.otherList ,lock: SharedPreference().otherLock, deviceHeight: deviceHeight * 0.16),

            ],
          ),
        ),
    );
  }



  SingleChildScrollView contents({required double deviceWidth,required double deviceHeight,required List list,required bool lock}) {
    String getImagePath(List list){
      if(list == VoiceSelectBox.girlList){
        return 'assets/other_image/gennki.png';
      }else if(list == VoiceSelectBox.buttonList){
        return 'assets/other_image/button.png';
      }else{
        return 'assets/other_image/other.png';
      }
    }
    return SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    decoration: BoxDecoration(
                      color: OriginalThemeColor.retro1,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      getImagePath(list),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: OriginalThemeColor.white
                        ),
                        child: ListTile(
                          title: Text(
                            list[index].title,
                            style: TextStyle(
                              color: OriginalThemeColor.black
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor:  Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            child: Text(list[index].title.substring(0,2))
                          ),
                          onTap: (){
                            if(lock){
                              null;
                            }else{
                              AudioPlayers.audioPlay(fileName: list[index].voiceName);

                            }
                          },
                          trailing: lock
                              ? ElevatedButton(
                                    child: Icon(
                                      Icons.lock,
                                      color: OriginalThemeColor.gray,
                                    ),
                                    onPressed: (){
                                      Dialogs.rewardDialog(
                                          context: context,
                                          onPressed: ()async{
                                            if(AdMob.myRewardAd != null){
                                              AdMob.myRewardAd!.fullScreenContentCallback =
                                                  FullScreenContentCallback(
                                                      onAdDismissedFullScreenContent: (ad){
                                                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                                                        // ignore: avoid_print
                                                        print('バーを復活');
                                                        ad.dispose();
                                                        if(coin > 0){
                                                          if(list == VoiceSelectBox.girlList){
                                                            setState(() {
                                                              SharedPreference().setGirlLock();
                                                            });
                                                          }else if(list == VoiceSelectBox.otherList){
                                                            setState(() {
                                                              SharedPreference().setOtherLock();
                                                            });
                                                          }
                                                          coin = 0;
                                                          Navigator.pop(context);
                                                          AdMob.loadReward();
                                                        }
                                                      },
                                                      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error){
                                                        ad.dispose();
                                                        AdMob.loadReward();
                                                      }
                                                  );
                                              await AdMob.myRewardAd!.show(
                                                  onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
                                                    // ignore: avoid_print
                                                    print('$ad with reward $RewardItem(${rewardItem.amount}, ${rewardItem.type})');
                                                    setState(() {
                                                      coin += rewardItem.amount.toInt();
                                                      // ignore: avoid_print
                                                      print('報酬を獲得：　$coin');
                                                    });
                                                  }
                                              );
                                            }else{
                                              Dialogs.netWorkErrorDialog(
                                                  context: context,
                                                  onPressed: (){
                                                    AdMob.loadReward();
                                                    Navigator.of(context).pop();
                                                  }
                                              );
                                            }
                                          }
                                      );
                                    },
                          )
                              : ElevatedButton(
                                    child: Text(
                                      list[index].isActive
                                          ? '設定中'
                                          : '設定'
                                    ),
                                    onPressed: (){
                                      void resetBool(List list){
                                        for(var value in list){
                                          value.isActive = false;
                                        }
                                      }
                                      setState(() {
                                        SharedPreference().setVoice(list[index].voiceName);
                                        resetBool(VoiceSelectBox.buttonList);
                                        resetBool(VoiceSelectBox.girlList);
                                        resetBool(VoiceSelectBox.otherList);
                                        list[index].isActive = true;
                                      });
                                    },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Buttons.reviewHopeButton(
                  width: deviceWidth * 0.8,
                  onPressed: (){
                    LaunchReview.launch(
                      writeReview: true,iOSAppId: "1635106525"
                    );
                  }
                ),
                SizedBox(
                  height: 60,
                ),
              ]),
            );
  }
}
