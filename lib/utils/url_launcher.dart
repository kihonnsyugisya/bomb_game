
// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:url_launcher/url_launcher.dart';

class UrlLauncher  {
  static String twitterHashTags = '\n#よくみるボタン' ;
  static String iosAppId = 'https://apps.apple.com/us/app/bomggames/id1635106525';
  // static String androidAppId = 'https://onl.bz/AepQQKZ';


  static void tweet({
    required String text,}) async {
    // final Map<String, dynamic> tweetQuery = {
    //   "text":text + '\n' + '\n'+ 'Android版' + '\n'+ androidAppId + '\n' + '\n'+ 'iOS版' + '\n'+ iosAppId + '\n'+ twitterHashTags
    // };

    final Map<String, dynamic> tweetQuery = {
      "text":text + '\n' + '\n' + 'iOS版' + '\n'+ iosAppId + '\n'+ twitterHashTags
    };

    final Uri tweetScheme =
    Uri(scheme: "twitter", host: "post", queryParameters: tweetQuery);

    final Uri tweetIntentUrl =
    Uri.https("twitter.com", "/intent/tweet", tweetQuery);

    await canLaunchUrl(tweetScheme)
        ? await launchUrl(tweetScheme)
        : await launchUrl(tweetIntentUrl);
  }

  static void privacyPolicy()async{
    final Uri githubScheme = Uri.https('kihonnsyugisya.github.io', 'privacy_policy_quiz_app/');
    // https://kihonnsyugisya.github.io/privacy_policy_quiz_app/
    if(await canLaunchUrl(githubScheme)){
      await launchUrl(githubScheme);
    }else{
      // ignore: avoid_print
      print('error');
    }
  }

}
