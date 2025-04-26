
import 'package:bomb_game/utils/color/original_theme_color.dart';
import 'package:bomb_game/view/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../utils/buttons.dart';
import '../utils/original_theme_font.dart';
import '../utils/shared_preference.dart';
import '../utils/text_fields.dart';

class PunishmentPage extends StatefulWidget {
  @override
  _PunishmentPageState createState() => _PunishmentPageState();
}

class _PunishmentPageState extends State<PunishmentPage> {
  bool isPunishment = SharedPreference().isPunishment;
  bool isEditing = false;
  @override
  void initState() {
    // TODO: implement initState
    SharedPreference().getMyPunishments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        print('tap');
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, //キーボードによって画面サイズを変更させないため
        appBar: AppBar(
          title: Text(
              'ばつゲームをせっていする',
              style: OriginalThemeFont.appBarFont
          ),
          leading: IconButton(
            onPressed: ()async{
              FocusScope.of(context).unfocus();
              await Future.delayed(const Duration(milliseconds: 200));
              if(isEditing == true){
                SharedPreference().setMyPunishments();
              }
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const SettingPage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                height: deviceHeight * 1.1,
                child: Column(
                  children:  [
                    BoolButton(
                        text: const Text('罰ゲームモード'),
                        icon: Icon(FontAwesomeIcons.bomb,size: 20,color: OriginalThemeColor.black,),
                        isActive: isPunishment,
                        onChanged: (value){
                          setState(() {
                            isPunishment = value;
                            SharedPreference().setPunishment(value);
                          });
                          print(SharedPreference().isPunishment);
                        }
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'オンにすると、設定した罰ゲームがゲーム終了後にランダムに表示されます。',
                        style: TextStyle(
                          color: isPunishment
                              ? OriginalThemeColor.black
                              : OriginalThemeColor.gray,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: isPunishment ? 1 : 0,
                        duration: const Duration(milliseconds: 80),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: TextFields.textControllers.length,
                          itemBuilder: (BuildContext context, int index){
                            return TextFields.punishmentField(
                                controller: TextFields.textControllers[index],
                                num: index + 1,
                                onChanged: (string){
                                  print(string);
                                  isEditing = true;
                                }
                            );


                            },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
