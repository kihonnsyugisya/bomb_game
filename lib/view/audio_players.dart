
import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


class AudioPlayers{
  static final AudioCache cache = AudioCache(
    fixedPlayer: AudioPlayer()
  );
  static void audioPlay({required String fileName}){
    cache.play(fileName);
  }
  static final AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  static void audioLocalPlay({required String localPath})async{
    int result = await audioPlayer.play(localPath,isLocal: true);
    if (result == 1){
      print('success');
    }
  }
  static Future playLocal(String fileName)async{
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    StreamSubscription<PlayerState>? audioStreamers;
    // await file.create(recursive: true);
    print(file);
    if(!file.existsSync()){
      final soundData = await rootBundle.load('assets/$fileName');
      final bytes = soundData.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      print('suru-');
    }
    await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    await audioPlayer.play(file.path,isLocal: true,);

    // audioStreamers =
    // audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
    //   playerState = s;
    //   print(playerState);
    // });
    // if(playerState == PlayerState.PLAYING){
    //   await audioPlayer.stop();
    //   print('self stop');
    // }else{
    //   await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    //   await audioPlayer.play(file.path,isLocal: true,);
    //   print('kokosasu');
    // }
  }
  static PlayerState? playerState;
}
