
import 'package:audioplayers/audioplayers.dart';
import 'package:bomb_game/utils/setting.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class ModeConverter{
  static String maxCountText(){
    if(Setting.isChairsGame){
      return 'ストップする最大の時間を変更できます。';
    }else if(Setting.isBombGame){
      return '爆発する最大の回数を変更できます。';
    }else{
      return  '時間を変更できます';
    }
  }
  static String resultText1(){
    if(Setting.isChairsGame){
      return 'ストップ！';
    }else if(Setting.isBombGame){
      return 'GAME OVER！';
    }else{
      return '結果発表';
    }
  }
  static List resultImages = List.of(Setting.shopImagePass);
  static AssetImage? image;

  static String getPunishmentText(){
    List list = List.of(SharedPreference().myPunishments);
    list.shuffle();
    return list.first;
  }

}

class VoiceSelectEntity{
  String voiceName;
  String title;
  bool isActive;
  VoiceSelectEntity({required this.voiceName,required this.title,required this.isActive});
}


class VoiceSelectBox{
  static void setActive(List list){
    for(var value in list){
      if(value.voiceName == SharedPreference().selectVoice){
        value.isActive = true;
      }
    }
  }
  static void initVoiceActiveSet(){
    setActive(girlList);
    setActive(otherList);
    setActive(buttonList);
  }
  static List girlList = [
    VoiceSelectEntity(voiceName: 'girl/inaiinai.mp3', title: 'いないいない', isActive: false),
    VoiceSelectEntity(voiceName: 'girl/baa.mp3', title: 'ばぁ', isActive: false),
    VoiceSelectEntity(voiceName: 'girl/eekagennisennkai.mp3', title: 'ええかげんにせんかい', isActive: false),
    VoiceSelectEntity(voiceName: 'girl/ei.mp3', title: 'えい！', isActive: false),
    VoiceSelectEntity(voiceName: 'girl/ka-tu.mp3', title: 'かーつ', isActive: false),
    VoiceSelectEntity(voiceName: 'girl/nanndeyabebb.mp3', title: 'なんでやねん！', isActive: false),
    VoiceSelectEntity(voiceName: 'girl/tyotto.mp3', title: 'ちょっとまってよ', isActive: false),
  ];
  static List otherList = [
    VoiceSelectEntity(voiceName: 'other/bashi.mp3', title: 'バシっ', isActive: false),
    VoiceSelectEntity(voiceName: 'other/buzaa.mp3', title: 'ブザー', isActive: false),
    VoiceSelectEntity(voiceName: 'other/fanfare.mp3', title: 'ファンファーレ', isActive: false),
    VoiceSelectEntity(voiceName: 'other/jajan.mp3', title: 'ジャジャーン', isActive: false),
    VoiceSelectEntity(voiceName: 'other/kiran.mp3', title: 'じけんのにおい', isActive: false),
    VoiceSelectEntity(voiceName: 'other/manuke.mp3', title: 'マヌケ', isActive: false),
    VoiceSelectEntity(voiceName: 'other/parin.mp3', title: 'パリーン', isActive: false),
    VoiceSelectEntity(voiceName: 'other/revelup.mp3', title: 'レベルアップ', isActive: false),
    VoiceSelectEntity(voiceName: 'other/shout.mp3', title: 'うわぁー', isActive: false),
    VoiceSelectEntity(voiceName: 'other/tirin.mp3', title: 'チリーン', isActive: false),
  ];
  static List buttonList = [
    VoiceSelectEntity(voiceName: 'button/chaim.mp3', title: 'ピーンポーン', isActive: false),
    VoiceSelectEntity(voiceName: 'button/correct001.mp3', title: 'ピーンポーン↑', isActive: false),
    VoiceSelectEntity(voiceName: 'button/correct030.mp3', title: 'ピーンポーン↓', isActive: false),
    VoiceSelectEntity(voiceName: 'button/ok8.mp3', title: 'ピロリーン', isActive: false),
    VoiceSelectEntity(voiceName: 'button/ok35.mp3', title: 'ポチ', isActive: false),
    VoiceSelectEntity(voiceName: 'button/poch.mp3', title: 'ぽち', isActive: false),
  ];
}