import 'package:audioplayers/audioplayers.dart';
import 'package:bomb_game/utils/custom_card.dart';
import 'package:bomb_game/utils/setting.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:bomb_game/view/audio_players.dart';
import 'package:bomb_game/view/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ミュージックをかえる'
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: ()async{
            if(AudioPlayers.playerState == PlayerState.playing){
              await AudioPlayers.stop();
              print('音楽止めてから移動しなー');
            }
            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const SettingPage()));
          },
        ),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(4, (index){
            return CustomCard(
              fileName: ShopItemList.itemList[index].fileName,
              imagePass: ShopItemList.itemList[index].imagePass,
              title: ShopItemList.itemList[index].title,
              isButtonSelect: false,
              function: (finish){
                setState(() {
                  SharedPreference().setAudio(ShopItemList.itemList[index].fileName);
                  ShopItemList.changeActive(index,ShopItemList.itemList);
                });
              },
              itemIndex: index,
              isActive: ShopItemList.itemList[index].isActive,
            );
          }),
        ),
      ),
    );
  }
}
