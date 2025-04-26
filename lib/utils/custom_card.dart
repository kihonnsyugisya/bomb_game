
import 'dart:async';
import 'package:bomb_game/utils/buttons.dart';
import 'package:bomb_game/utils/color/original_theme_color.dart';
import 'package:bomb_game/utils/setting.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:flutter/material.dart';

import '../view/audio_players.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  String imagePass = '';
  String title ='';
  Function function;
  String? fileName;
  int itemIndex;
  bool isActive = false;
  bool isButtonSelect = false;
  CustomCard({Key? key, required this.imagePass,required this.title,required this.function,required this.fileName,required this.itemIndex,required this.isActive,required this.isButtonSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                imagePass,
                fit: BoxFit.contain,
                width: double.infinity,

              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ChoiseButton(
                    isActive: isActive,
                    function: function
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShopItemEntity{
  String imagePass = '';
  String title ='';
  String fileName = '';
  bool isActive = false;
  ShopItemEntity({required this.imagePass,required this.title,required this.fileName,required this.isActive});
}

class ShopItemList{
  static List<ShopItemEntity> itemList = [
    ShopItemEntity(imagePass: Setting.shopImagePass[0], title: '追いかけっこキャッハー',fileName: Setting.fileNames[0], isActive: false),
    ShopItemEntity(imagePass: Setting.shopImagePass[1], title: 'ゆかいな日常',fileName: Setting.fileNames[1],isActive: false),
    ShopItemEntity(imagePass: Setting.shopImagePass[2], title: 'Cat life',fileName: Setting.fileNames[2] , isActive: false),
    ShopItemEntity(imagePass: Setting.shopImagePass[3], title: 'シャイニングスター',fileName: Setting.fileNames[3] , isActive: false),
  ];
  static void changeActive(int index,List list){
    for(var value in list){
      value.isActive = false;
    }
    list[index].isActive = true;
  }
}


class ButtonItemEntity{
  String imagePass = '';
  String title ='';
  bool isActive = false;
  ButtonItemEntity({required this.imagePass,required this.title,required this.isActive});
}

class ButtonItemList{
  static List<ButtonItemEntity> itemList = [
    ButtonItemEntity(imagePass: Setting.buttonImagePass[0], title: Setting.buttonNames[0], isActive: false),
    ButtonItemEntity(imagePass: Setting.buttonImagePass[1], title: Setting.buttonNames[1], isActive: false),
    ButtonItemEntity(imagePass: Setting.buttonImagePass[2], title: Setting.buttonNames[2], isActive: false),
  ];
  static void intiSetActive(){
    for(var value in ButtonItemList.itemList){
      print(SharedPreference().selectButton);
      if(value.title == SharedPreference().selectButton){
        value.isActive = true;
        print('set');
      }
    }
    for(var value in ShopItemList.itemList){
      if(value.fileName == SharedPreference().selectAudio){
        value.isActive = true;
      }
    }
  }
}

