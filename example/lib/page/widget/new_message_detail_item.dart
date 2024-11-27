

import 'package:flutter/material.dart';
import 'package:push_plugin/model/MessageContentModel.dart';
import 'package:push_plugin/model/MessagePayload.dart';
import 'package:push_plugin/push_plugin.dart';
import '../../utils/date_format_locale.dart';


class NewMessageDetailItem extends StatefulWidget {
  final VoidCallback onTap;
  final MessageContentModel model;

  const NewMessageDetailItem(
      { required this.model,required this.onTap});

  @override
  State<NewMessageDetailItem> createState() => NewMessageDetailItemState();
}

class NewMessageDetailItemState extends State<NewMessageDetailItem> {
  late MessageContentModel _model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = widget.model;
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: _model.timeString.isNotEmpty ? 44:12,
            child: _model.timeString.isNotEmpty ? Padding(padding: const EdgeInsets.only(top: 17),child:Text(formatMessageTimestamp(_model.createTime!).toString(),style: const TextStyle(fontSize: 12,color: Color(0xFF999999))),) : null,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: _model.readState ? const Color(0xFFE9E9EB) : const Color(0xFFEB5757)
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(_model.title??"",maxLines: 1,overflow: TextOverflow.clip,style: const TextStyle(fontSize: 16,color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),
                 Text(_model.msgContent,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: const Color(0xFF666666),height: 1.5),),
                Visibility(
                  visible: viewDetailVisibility(_model),
                  child: Column(
                    children: [
                      const SizedBox(height: 12,),
                      Container(color: const Color(0xFFF2F2F2),height: 0.5),
                      const SizedBox(height: 12,),
                      GestureDetector(
                        onTap: widget.onTap,
                        behavior: HitTestBehavior.opaque,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("详情",style: TextStyle(fontSize: 14,color: Color(0xFFFFAC13),fontWeight: FontWeight.w400),),
                            SizedBox(width: 5),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


  bool viewDetailVisibility(MessageContentModel model){
    if(model.extras.isEmpty){
      if(!model.readState){
        PushApi.setNotificationRead(model.id.toString());
      }
      return false;
    }
    MessagePayload messagePayload = MessagePayload.fromJson(model.extras);
    if(messagePayload.jumpType== null){
      if(!model.readState){
        PushApi.setNotificationRead(model.id.toString());
      }
      return false;
    }
    return true;
  }
}
