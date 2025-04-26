import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayers {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static PlayerState? playerState;

  // プレイヤーの状態変化を購読できる
  static Stream<PlayerState> get onPlayerStateChanged => _audioPlayer.onPlayerStateChanged;

  /// assetsフォルダの音声を再生
  static Future<void> playAsset(String fileName) async {
    await _audioPlayer.play(AssetSource(fileName));
    print('Playing asset: $fileName');
  }

  // 音声ファイルを再生するメソッド
  static Future<void> audioPlay({required String fileName}) async {
    await playAsset(fileName);  // playAssetメソッドに処理を委託
  }

  /// 一時停止
  static Future<void> pause() async {
    await _audioPlayer.pause();
    print('Paused audio');
  }

  /// 再開
  static Future<void> resume() async {
    await _audioPlayer.resume();
    print('Resumed audio');
  }

  /// 現在のプレイヤー状態を取得
  static Future<PlayerState> getPlayerState() async {
    return _audioPlayer.state;
  }

  /// 停止
  static Future<void> stop() async {
    await _audioPlayer.stop();
    print('Stopped audio');
  }

  /// ローカルストレージに保存した音声ファイルを再生
  static Future<void> playLocal(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    if (!file.existsSync()) {
      // ファイルが存在しない場合、アセットからロードして保存
      final soundData = await rootBundle.load('assets/$fileName');
      final bytes = soundData.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      print('Sound file written to disk');
    }

    // ファイルが存在する場合、ローカルストレージから再生
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(DeviceFileSource(file.path));
    print('Playing local file: $fileName');
  }
}
