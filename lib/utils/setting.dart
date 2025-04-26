
import 'package:flutter/cupertino.dart';

import 'buttons.dart';

class Setting {
  static int stopTime = 6;
  static List<String> fileNames = [
    'oikakekko.mp3',
    'yukai.mp3',
    'Cat_life.mp3',
    'shining_star.mp3',
  ];
  static List<String> shopImagePass = [
    'assets/audio_image/asobi_onigokko.png',
    'assets/audio_image/kids_isutori_game.png',
    'assets/audio_image/douga_haishin_youtuber.png',
    'assets/audio_image/job_kasyu.png'
  ];

  static List<String> buttonImagePass = [
    'assets/buttons_Image/dangerousButton.png',
    'assets/buttons_Image/emergencyButton.png',
    'assets/buttons_Image/callButton.png',
  ];

  static String bombsAudio(){
    List<String> list = [
      'bombs/bomb1.mp3',
      'bombs/bomb2.mp3',
      'bombs/bomb3.mp3',
    ];
    list.shuffle();
    return list[0];
  }

  static List<String> buttonNames = [
    '押してはいけなさそうなボタン',
    '学校でよく見るボタン',
    'お店でよく見るボタン'
  ];

  static String getResultImage(String text){
    if(isBombGame){
      return 'assets/other_image/ezgif.com-gif-maker.gif';
    }else{
      return text;
    }
  }

  static bool isChairsGame = false;
  static bool isBombGame = false;
  static bool isRushGame = false;
  static bool isHomePage = true;

}

