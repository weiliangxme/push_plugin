import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:push_example/page/widget/my_loading.dart';
import 'package:push_example/page/widget/new_message_summary_item.dart';
import 'package:push_plugin/api/push_api.dart';
import 'package:push_plugin/model/MessageSummaryModel.dart';
import 'new_message_detail_page.dart';
import 'no_data_page.dart';

///消息中心
class MessagePage extends StatefulWidget {
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<MessageSummaryModel>? _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    print("+++++++MessagePage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('消息中心'),
          actions: [
            GestureDetector(
              child: Container(
                child: Text("全部已读",style: TextStyle(fontSize: 16),),
                margin: EdgeInsets.only(right: 16),
              ),
              onTap: ()=>{
                PushApi.updateReadStateAll()
              },
            )
          ],
        ),
        body: _data == null
            ? const NoDataPage(
                height: 550,
              )
            : CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (_data != null && _data!.isEmpty) {
                        return const NoDataPage(
                          height: 550,
                        );
                      } else {
                        return NewMessageSummaryItem(
                            messageSummaryModel: _data![index],
                            onTap: () {
                              goMessageCenterDetail(_data![index].messageType!, _data![index].messageTypeTitle!);
                            });
                      }
                    }, childCount: _data == null ? 0 : (_data!.isEmpty ? 1 : _data!.length)),
                  ),
                ],
              ));
  }

  void loadData() {
    MyLoading.show();
    PushApi.getMessageCenterData().then((value) {
      MyLoading.dismiss();
      if (mounted) {
        setState(() {
          _data = value;
        });
      }
    });
  }

  void goMessageCenterDetail(String messageType, String messageTitle) {
    Navigator.of(context)
        .push(CupertinoPageRoute(
            builder: (_) => NewMessageDetailPage(
                  messageType: messageType,
                  title: messageTitle,
                )))
        .then((value) {});
  }
}
