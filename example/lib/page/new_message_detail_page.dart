
import 'package:flutter/material.dart';
import 'package:push_example/page/widget/my_loading.dart';
import 'package:push_plugin/api/push_api.dart';
import 'package:push_plugin/model/MessageContentModel.dart';
import '../utils/date_format_locale.dart';
import 'no_data_page.dart';
import 'widget/new_message_detail_item.dart';


///消息详情
class NewMessageDetailPage extends StatefulWidget {
  final String messageType;
  final String title;

  const NewMessageDetailPage(
      { required this.messageType, required this.title});

  @override
  State<NewMessageDetailPage> createState() => _NewMessageDetailPageState();
}

class _NewMessageDetailPageState extends State<NewMessageDetailPage> {

  late ScrollController _scrollController;

  List<MessageContentModel> _data = [];

  bool showEmptyPage = false;
  int _pageNo = 0;
  int _pageSize = 20;

  Set<String> times = Set();

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    loadData();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知详情'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (showEmptyPage) {
                  return const NoDataPage(
                    height: 550,
                  );
                } else {
                  return NewMessageDetailItem(
                      model: _data[index],
                      onTap: () {
                        if (_data[index].readState == false) {
                          setNotificationRead(_data[index].id.toString());
                        }
                      });
                }
              }, childCount: showEmptyPage ? 1 : _data.length),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    MyLoading.show();
      var data = await PushApi.getMessageListByType(
          widget.messageType,
          pageNo: _pageNo,
          pageSize: _pageSize);
    MyLoading.dismiss();
      for (var element in data.content) {
        var timeString = formatMessageTimestamp(element.createTime!);
        if (!times.contains(timeString)) {
          times.add(timeString);
          element.timeString = timeString;
        }
      }
      _data.addAll(data.content);
      setState(() {});

  }

  void setNotificationRead(String messageId) async {
    for (var element in _data) {
      if (element.id.toString() == messageId) {
        setState(() {
          element.readState = true;
        });
        continue;
      }
    }
    PushApi.setNotificationRead(messageId);
  }


}
