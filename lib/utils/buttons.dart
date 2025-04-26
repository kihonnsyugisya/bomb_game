
import 'package:animated_button/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'color/original_theme_color.dart';
import 'original_theme_font.dart';


class Buttons{
  static TextButton originalTextButton({
    required String text,
    required VoidCallback? onPress})
  {
    return TextButton(
        onPressed: onPress,
        style: ButtonStyle(overlayColor: MaterialStateProperty.all(OriginalThemeColor.transparent),),
        child: Text(
          text,
          style: OriginalThemeFont.subFont,
        ),
      // onFocusChange: ,
    );
  }

  static TextButton nextButton({
    required String text,
    required VoidCallback? onPress})
  {
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(overlayColor: MaterialStateProperty.all(OriginalThemeColor.transparent),),
      child: Text(
        text,
        style: OriginalThemeFont.quizFont,
      ),
      // onFocusChange: ,
    );
  }

  // ignore: non_constant_identifier_names
  static Widget ModeButton({
    required String buttonText,
    required VoidCallback? page,
    required Color? color})
  {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 54,
        child: ElevatedButton(
          child: Text(
            buttonText,
            style: OriginalThemeFont.modeFont
          ),
          style: ElevatedButton.styleFrom(
            primary: color ?? OriginalThemeColor.themeSubColor,
            onPrimary: Colors.black,
          ),
          onPressed: page,
        ),
      ),
    );
  }
  // ※画面に表示されるボタンの数は、クイズリストの数に起因するようにしている。
  static List<dynamic> normalModeList = [
    ModeButtonEntity(buttonText: 'NORMAL', color: null),
    ModeButtonEntity(buttonText: 'HARD', color: null),
    ModeButtonEntity(buttonText: '上級', color: null),
  ];

  static List<dynamic> hardModeList = [
    ModeButtonEntity(buttonText: 'VERY HARD', color: null),
    ModeButtonEntity(buttonText: 'VERY HARD', color: null),
    ModeButtonEntity(buttonText: '第1章', color: null),

  ];


  static ElevatedButton revivalButton({VoidCallback? onPressed}){
    return ElevatedButton(
      child: SizedBox(
        width: 180,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.live_tv_sharp,size: 20,color: OriginalThemeColor.black,),
            const SizedBox(width: 4,),
            Text('CMを視聴して復活する',style: OriginalThemeFont.moderateFont,),
          ],
        ),
      ),
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(OriginalThemeColor.themeColor),
        backgroundColor: MaterialStateProperty.all(OriginalThemeColor.themeColor)
      ),
    );
  }

  static Material dangerousButton({required GestureTapCallback function}){
    return Material(
      color: OriginalThemeColor.transparent,
      elevation: 40,
      child: Material(
        color: OriginalThemeColor.transparent,
        elevation: 40,
        borderRadius: BorderRadius.circular(180),
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: OriginalThemeColor.dangerous1,
            borderRadius: BorderRadius.circular(180),
            boxShadow: [
              BoxShadow(
                color: OriginalThemeColor.dangerous2,
                spreadRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: AnimatedButton(
              color: Colors.redAccent.shade700,
              height: 150,
              width: 150,
              shape: BoxShape.circle,
              shadowDegree: ShadowDegree.dark,
              onPressed: function,
              child: Text(
                'PUSH',
                style: OriginalThemeFont.popFont
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Material emergencyButton({ required GestureTapCallback function}){
    return Material(
      color: OriginalThemeColor.transparent,
      elevation: 40,
      child: Material(
        color: OriginalThemeColor.transparent,
        elevation: 40,
        borderRadius: BorderRadius.circular(180),
        child: Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            color: OriginalThemeColor.emergency1,
            gradient: LinearGradient(
              colors: [OriginalThemeColor.emergency11, OriginalThemeColor.emergency12],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(180),
            boxShadow: [
              BoxShadow(
                color: OriginalThemeColor.emergency2,
                spreadRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 140,
                  height: 40,
                  decoration: BoxDecoration(
                    color: OriginalThemeColor.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text('火災報知機',style: TextStyle(color: OriginalThemeColor.emergency1),)),
                ),
                SizedBox(height: 16,),
                AnimatedButton(
                  color: OriginalThemeColor.emergency3,
                  height: 120,
                  width: 120,
                  shape: BoxShape.circle,
                  shadowDegree: ShadowDegree.dark,
                  onPressed: function,
                  child: Container(
                    // color: OriginalThemeColor.retro1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            '強く押す',
                            style: TextStyle(
                              color: OriginalThemeColor.white,
                              fontSize: 12,
                            )

                        ),
                        Text(
                            'PUSH',
                            style: OriginalThemeFont.popFont
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Material callButton({ required GestureTapCallback function}){
    return Material(
      color: OriginalThemeColor.transparent,
      elevation: 40,
      child: Material(
        color: OriginalThemeColor.transparent,
        elevation: 40,
        child: Container(
          width: 200,
          height: 220,
          decoration: BoxDecoration(
            color: OriginalThemeColor.call1,
            borderRadius: BorderRadius.circular(180),
            boxShadow: [
              BoxShadow(
                color: OriginalThemeColor.call2,
                spreadRadius: 16,
                offset: Offset(0, 18),
              ),
            ],
          ),
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircularText(
                  children: [
                    TextItem(
                      text: Text(
                        "ご用の際はボタンを押してください".toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          color: OriginalThemeColor.emergency3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      space: 10,
                      startAngle: 90,
                      startAngleAlignment: StartAngleAlignment.center,
                      direction: CircularTextDirection.anticlockwise,
                    ),
                  ],
                  radius: 125,
                  position: CircularTextPosition.inside,
                  backgroundPaint: Paint()..color = Colors.grey.shade200,
                ),

                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    color: OriginalThemeColor.transparent,

                  ),
                  child: Center(
                    child: AnimatedButton(
                      color: OriginalThemeColor.emergency3,
                      height: 120,
                      width: 120,
                      shape: BoxShape.circle,
                      shadowDegree: ShadowDegree.dark,
                      onPressed: function,
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            color: OriginalThemeColor.call1,
                          ),
                          child: Center(
                            child: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(180),
                                color: OriginalThemeColor.emergency3,
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: OriginalThemeColor.call1,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static ElevatedButton reviewHopeButton({VoidCallback? onPressed,double? width}){
    return ElevatedButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(CupertinoIcons.bubble_left_bubble_right_fill,size: 24,color: OriginalThemeColor.black,),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('音のリクエストをする',),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static AnimatedButton modeButton({required double width,required Color color,required GestureTapCallback onPressed,required Widget icon,required String string}){
    return AnimatedButton(
      color: color,
      height: width,
      width: width,
      onPressed: onPressed,
      child: Container(
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(
                string
              ),
            ],
          ),
        ),
      ),
    );
  }


}

class ModeButtonEntity{
  String buttonText;
  Color? color;
  ModeButtonEntity({
    required this.buttonText,
    required this.color,
  });
}

class MoreButton extends StatelessWidget {
  static List<Widget> list = [

  ];
  static Divider bottomLine = Divider(color: OriginalThemeColor.black,height: 0.5,);
  final Text text;
  final GestureTapCallback? onTap;
  final Icon icon;
  MoreButton({Key? key, required this.text,required this.onTap,required this.icon,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 8,),
                text,
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class BoolButton extends StatefulWidget {
  static Divider bottomLine = Divider(color: OriginalThemeColor.black,height: 0.5,);
  final Text text;
  void Function(bool)? onChanged;
  final Icon icon;
  bool isActive = false;
  BoolButton({Key? key, required this.text,required this.icon,required this.isActive,required this.onChanged}) : super(key: key);

  @override
  State<BoolButton> createState() => _BoolButtonState();
}

class _BoolButtonState extends State<BoolButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                widget.icon,
                const SizedBox(width: 8,),
                widget.text,
              ],
            ),
            CupertinoSwitch(
                value: widget.isActive,
                onChanged: widget.onChanged
                )
          ],
        ),
      ),
    );
  }
}

class ChoiseButton extends StatelessWidget {
  Function function;
  bool isActive = false;
  ChoiseButton({required this.function,required this.isActive});
  @override
  Widget build(BuildContext context) {
    return NiceButtons(
      disabled: isActive,
      onTap: function,
      stretch: false,
      height: 30,
      borderRadius: 16,
      gradientOrientation: GradientOrientation.Horizontal,
      child: Text(
        isActive == true
            ? '設定中'
            : '設定する',
      ),
    );
  }
}





