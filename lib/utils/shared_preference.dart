
import 'package:bomb_game/utils/setting.dart';
import 'package:bomb_game/utils/text_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  SharedPreference._();

  static final _instance = SharedPreference._internal();

  SharedPreference._internal();

  factory SharedPreference(){
    return _instance;
  }

  SharedPreferences? _prefs;
  String status = 0.toString();
  String selectAudio = '';
  String selectVoice ='';
  String selectButton = '';
  bool isPunishment = false;
  List<String> myPunishments = [];
  //ピッチはデフォで30秒
  int myPitch = 30;
  bool isVibration = true;
  int totalCount = 0;
  bool girlLock = true;
  bool otherLock = true;


  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get getStatus {
    selectAudio = _prefs!.getString('selectAudio') ?? Setting.fileNames[0];
    selectVoice = _prefs!.getString('selectVoice') ?? 'button/correct001.mp3';
    selectButton = _prefs!.getString('selectButton') ?? '押してはいけなさそうなボタン';
    isPunishment = _prefs!.getBool('isPunishment') ?? false;
    myPunishments = _prefs!.getStringList('myPunishments') ?? ['','','','',''];
    myPitch = _prefs!.getInt('myPitch') ?? 30;
    isVibration = _prefs!.getBool('isVibration') ?? true;
    totalCount = _prefs!.getInt('totalCount') ?? 0;
    girlLock = _prefs!.getBool('girlLock') ?? true;
    otherLock = _prefs!.getBool('otherLock') ?? true;
  }

  get getVoice {
    selectVoice = _prefs!.getString('selectVoice') ?? 'button/correct001.mp3';
  }

  void setPunishment(bool value) {
    isPunishment = value;
    _prefs!.setBool('isPunishment', isPunishment);
  }


  void setMyPunishments(){
    SharedPreference().myPunishments.clear();
    for(var value in TextFields.textControllers){
      SharedPreference().myPunishments.add(value.text);
      print(SharedPreference().myPunishments);
      // if(value.text.isEmpty){
      //   print('not settable');
      // }else{
      //   print('settable');
      //   SharedPreference().myPunishments.add(value.text);
      //   _prefs!.setStringList('myPunishment', myPunishments);
      // }
    }
    _prefs!.remove('myPunishments');
    _prefs!.setStringList('myPunishments', SharedPreference().myPunishments);
    print(SharedPreference().myPunishments);

  }

  get getMyPunishments{
    for(var index = 0; index < TextFields.textControllers.length ; index ++){
      // print(TextFields.textControllers.length);
      // print(TextFields.textControllers[index].text);
      // print(SharedPreference().myPunishments[index]);
      TextFields.textControllers[index].text = SharedPreference().myPunishments[index];
    }
  }

  void getRestStatus() {
    status = 0.toString();
  }

  void setMyPitch(){
    _prefs!.setInt('myPitch', myPitch);
  }

  void setTotalCount(){
    _prefs!.setInt('totalCount', totalCount);
  }

  void setAudio(String selectAudio){
    SharedPreference().selectAudio = selectAudio;
    _prefs!.setString('selectAudio', SharedPreference().selectAudio);
  }

  void setVoice(String selectVoice){
    SharedPreference().selectVoice = selectVoice;
    _prefs!.setString('selectVoice', SharedPreference().selectVoice);
  }

  void setVibration(bool value) {
    isVibration = value;
    _prefs!.setBool('isVibration', isVibration);
  }

  void setSelectButton(String selectButton){
    SharedPreference().selectButton = selectButton;
    _prefs!.setString('selectButton', SharedPreference().selectButton);
  }

  void setGirlLock() {
    girlLock = false;
    _prefs!.setBool('girlLock', girlLock);
  }

  void setOtherLock() {
    otherLock = false;
    _prefs!.setBool('otherLock', otherLock);
  }
}