import 'package:bomb_game/utils/custom_card.dart';
import 'package:bomb_game/utils/setting.dart';
import 'package:bomb_game/utils/shared_preference.dart';
import 'package:bomb_game/view/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ButtonSelectPage extends StatefulWidget {
  @override
  _ButtonSelectPageState createState() => _ButtonSelectPageState();
}

class _ButtonSelectPageState extends State<ButtonSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ボタンをかえる',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){

            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const SettingPage()));
          },
        ),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(3, (index){
            return CustomCard(
              fileName: null,
              imagePass: ButtonItemList.itemList[index].imagePass,
              title: ButtonItemList.itemList[index].title,
              isButtonSelect: true,
              function: (finish){
                setState(() {
                  SharedPreference().setSelectButton(Setting.buttonNames[index]);
                  ShopItemList.changeActive(index,ButtonItemList.itemList);
                });
              },
              itemIndex: index,
              isActive: ButtonItemList.itemList[index].isActive,
            );
          }),
        ),
      ),
    );
  }
}
