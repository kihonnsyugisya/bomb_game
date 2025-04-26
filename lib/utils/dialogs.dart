
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:quiz_app/utils/shared_preference.dart';

class Dialogs{

  static void licenseDialog(BuildContext context){
    return showLicensePage(
      context: context,
    );
  }

  static Future<dynamic> netWorkErrorDialog({
    required BuildContext context,
    required VoidCallback onPressed}){
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("ネットワークエラー"),
          content: const Text("通信状況をご確認ください。"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: onPressed
              ,
            ),
          ],
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      duration: const Duration(seconds: 1),
    );
  }
  static Future<bool> isTrackingNotDetermined()async{
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if(status == TrackingStatus.notDetermined){
      return true;
    }else{
      return false;
    }
  }
  static Future<dynamic> attDialog()async{
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
        //ダイアログ表示
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
    FlutterNativeSplash.remove();
    // ignore: avoid_print
    print('このデバイスのuuid = $uuid');
  }

  static Future<dynamic> rewardDialog({
    required BuildContext context,
    required VoidCallback onPressed}){
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("ロックをかいじょする"),
          content: Column(
            children: [
              Text(
                textAlign: TextAlign.start,
                  "こうこくを見てこのページのロックをかいじょしますか？"
              ),
              Image.asset(
                "assets/other_image/job_kagiya.png",
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: onPressed,
              child: const Text("はい"),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              isDestructiveAction: true,
              child: const Text("今はいいや"),
            ),
          ],
        );
      },
      animationType: DialogTransitionType.slideFromBottomFade,
      duration: const Duration(seconds: 1),
    );
  }
}