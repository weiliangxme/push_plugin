

import 'package:flutter/material.dart';
import 'package:push_plugin/model/MessageSummaryModel.dart';
import '../../utils/date_format_locale.dart';

class NewMessageSummaryItem extends StatefulWidget {
  final MessageSummaryModel messageSummaryModel;
  final VoidCallback? onTap;

  const NewMessageSummaryItem(
      {Key? key, required this.messageSummaryModel, this.onTap})
      : super(key: key);

  @override
  State<NewMessageSummaryItem> createState() => NewMessageSummaryItemState();
}

class NewMessageSummaryItemState extends State<NewMessageSummaryItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(left: 16.0,right: 16),
        height: 68,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: 44,
                  height: 44,
                 color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.messageSummaryModel.messageTypeTitle!,
                        maxLines: 1,
                        // overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.messageSummaryModel.createTime==null?"":formatTimestamp(widget.messageSummaryModel.createTime!),
                        maxLines: 1,
                        // overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xFFCECECE)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.messageSummaryModel.firstContent == null
                          ? Container()
                          : Expanded(
                              child: Text(
                              "${widget.messageSummaryModel.firstContent}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xFFCECECE)),
                            )),
                      const SizedBox(width: 40,),
                      Container(
                        // width: 60,
                        child: widget.messageSummaryModel.unReadNumber ==
                                    null ||
                                widget.messageSummaryModel.unReadNumber == 0
                            ? Container(
                                width: 30,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffEB5757),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 16,
                                width:
                                    widget.messageSummaryModel.unReadNumber! > 10
                                        ? 30
                                        : 16,
                                alignment: Alignment.center,
                                child: Text(
                                  "${widget.messageSummaryModel.unReadNumber! > 99 ? '99+' : widget.messageSummaryModel.unReadNumber}",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                      )
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
