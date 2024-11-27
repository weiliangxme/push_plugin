import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:push_example/page/widget/my_loading.dart';
import 'package:push_plugin/api/push_api.dart';
import 'package:push_plugin/model/notification_setting.dart';
import '../utils/color.dart';
import 'no_data_page.dart';
import 'widget/dialog.dart';


///通知设置
class NotificationSettings extends StatefulWidget{
  const NotificationSettings();

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings>{
  List<NotificationSetting> items = [];
  bool allowNotify = false;

  @override
  void initState() {
    super.initState();
    SystemChannels.lifecycle.setMessageHandler((msg)async{
      if(msg == 'AppLifecycleState.resumed'){
        initData();
      }
      return '';
    });
    initData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知设置'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SingleChildScrollView(
          child: items.isEmpty?const NoDataPage(
            height: 550,
          ):Column(
            children: items.map((e) => _group(e)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _group(NotificationSetting setting){
    return Column(
      children: [
        (setting.messageTypeName.isEmpty || setting.subMessageTypeStateResps.isEmpty) ? const SizedBox(height: 16,width: double.infinity) : Container(
          height: 47,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(setting.messageTypeName,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: setting.subMessageTypeStateResps.map((e) => _item(e)).toList(),
          )
        )
      ],
    );
  }

  Widget _item(NotificationSettingItem item){
    return Container(
      padding: const EdgeInsets.all(12),
      // color: Colors.yellow,
      child: Row(
        children: [
          Expanded(
            child: Text(item.subtitleName,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),maxLines: 1,overflow: TextOverflow.clip),
          ),
         const SizedBox(width: 20),
          SizedBox(
            width: 42,
            height: 24,
            child: CupertinoSwitch(
              value: item.openState,
              trackColor:  const Color(0xFFE9E9EB),
              activeColor: allowNotify ? MyColor.themeColor : MyColor.themeColor.withOpacity(0.5),
              onChanged: (value){
                setState(() {
                  _updateSetting(item,value);
                });
              })
          )
        ],
      ),
    );
  }
  initData()async{
    items = [];
    PermissionStatus status = await Permission.notification.status;
    allowNotify = status == PermissionStatus.granted;
    MyLoading.show();
    PushApi.updateUserNotificationState(allowNotify);
    if(!allowNotify){
      NotificationSetting setting = NotificationSetting(messageTypeName: '',messageType: '',subMessageTypeStateResps: [
        NotificationSettingItem(id: -1,subtitleName: "Receive System Reminder",openState: false)
      ]);
      items.add(setting);
    }
    var result = await PushApi.getUserNotificationStates();
    MyLoading.dismiss();
    items.addAll(result);

    if(mounted) {
      setState(() {});
    }
  }

  _updateSetting(NotificationSettingItem item,bool value)async{

    if(item.id == -1){
      showNormalDialog(
        context,
        title: "Get Important Notifications",
        content: "We will notify you about reward events, asset changes, important updates, etc.",
        btnAlignment: DialogButtonAlignment.vertical,
        confirmLabel: "Yes, notify me",
        cancelLabel: "Maybe later",
        confirm: (){
          openAppSettings().then((value){
            Navigator.pop(context);
          });
        }
      );
    }else{

      if(allowNotify){
        MyLoading.show();
        var result = await PushApi.changeNotificationState(item.id, value);
        MyLoading.dismiss();
        if(result.success){
          setState(() {
            item.openState = value;
          });
        }

      }else{
        print("Please turn on the system notification first");
      }
    }
  }

}
