import 'package:flutter/material.dart';
import 'package:push_plugin/api/push_api.dart';
import 'package:push_plugin/push_plugin.dart';
import 'message_page.dart';
import 'notification_setting.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pushPlugin = PushPlugin();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bee Push example '),
        ),
        body: Center(
          child:Column(children: [
            CustomButton(
              text: "初始化推送",
              onPressed: () =>initPush(),
            ),
            CustomButton(
              text: "监听推送通知",
              onPressed: () =>listenerNotification(),
            ),
            CustomButton(
              text: "消息中心",
              onPressed: () =>navigateToPage(context,MessagePage()),
            ),
            CustomButton(
              text: "通知管理",
              onPressed: () =>navigateToPage(context,const NotificationSettings()),
            ),
            CustomButton(
              text: "注销推送ID",
              onPressed: () =>PushPlugin().unregisterDevice(),
            ),
          ],),
        ),
      ),
    );
  }


  initPush(){
    _pushPlugin.init(baseUrl: '', appId:'',uid: '', version:"",language: 'zh-Hans');
  }

  listenerNotification(){
    _pushPlugin.jumpEvent.listen((event){
      if(!mounted)return;
      switch (event.jumpType){
        case JumpType.internalPage:
        //跳转内部页面
          Navigator.of(context).pushNamed(event.page!);
          break;
        case JumpType.inAppWebView:
        //跳转内部 webview
        //   Navigator.of(context).push(WebView());
        case JumpType.systemWebView:
        //跳转外部浏览器
        //   launchUrl(Uri.parse(event.url!));
      }
    });
  }

  navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }





}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
