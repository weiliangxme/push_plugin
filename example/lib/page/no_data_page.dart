

import 'package:flutter/material.dart';


class NoDataPage extends StatefulWidget {
  final String? msg;
  final double? height;
  final double? paddingTop;

  const NoDataPage({Key? key, this.msg,this.height,this.paddingTop}) : super(key: key);

  @override
  State<NoDataPage> createState() => _NoDataPageState();
}

class _NoDataPageState extends State<NoDataPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      padding: widget.paddingTop == null ? EdgeInsets.zero : EdgeInsets.only(top: widget.paddingTop!),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: widget.paddingTop == null ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.msg ?? 'No more data' ,
          )        ],
      ),
    );
  }
}
