import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:bomb_game/utils/adMob.dart';
import 'package:bomb_game/utils/color/original_theme_color.dart';
import 'package:bomb_game/utils/custom_card.dart';
import 'package:bomb_game/utils/dialogs.dart';
import 'package:bomb_game/view/audio_players.dart';
import 'package:bomb_game/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'utils/mode_converter.dart';
import 'utils/shared_preference.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  MobileAds.instance.initialize();
  await SharedPreference().init();
  await SharedPreference().getStatus;
  VoiceSelectBox.initVoiceActiveSet();
  ButtonItemList.intiSetActive();
  AdMob.loadReward();
  AdMob.loadInterstitial();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    Future(() async {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if(status == TrackingStatus.notDetermined){
        Dialogs.attDialog();
      }else{
        FlutterNativeSplash.remove();
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bomb Game!',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: GoogleFonts.dotGothic16TextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
