
import 'package:flutter/material.dart';
import '../../utils/color.dart';
enum DialogButtonAlignment { horizontal, vertical }

 showNormalDialog(BuildContext context, {
  String? title,
  String? content,
  String? cancelLabel,
  String? confirmLabel,
  DialogButtonAlignment btnAlignment = DialogButtonAlignment.horizontal,
  bool showCancelBtn = true,
  VoidCallback? confirm,
  VoidCallback? cancel}){

  showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context){
        return Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: MyColor.greyColor_1.withOpacity(0.08),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: title != null && title.isNotEmpty,
                  child: Container(
                    margin: EdgeInsets.only(bottom: (content == null || content.isEmpty) ? 16:12),
                    child: Text(
                      title ?? "",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black,height: 1.6),
                    ),
                  ),
                ),
                Visibility(
                  visible: content != null && content.isNotEmpty,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      content ?? "",
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black,height: 1.4,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                (showCancelBtn == false || btnAlignment == DialogButtonAlignment.vertical) ?
                Column(
                  children: [
                    GestureDetector(
                      onTap: confirm ?? (){Navigator.of(context).pop();},
                      child: Container(
                        width: showCancelBtn ? double.infinity :140,
                        height: 42,
                        decoration: BoxDecoration(
                            color: MyColor.themeColor,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Center(
                          child: Text((confirmLabel != null && confirmLabel.isNotEmpty) ? confirmLabel : "好的",style: const TextStyle(fontSize: 14,color: Colors.white)),
                        ),
                      ),
                    ),
                    if(showCancelBtn)GestureDetector(
                      onTap: cancel ?? (){Navigator.of(context).pop();},
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        width: double.infinity,
                        height: 42,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: MyColor.greyColor_5,width: 1)
                        ),
                        child: Center(
                          child: Text((cancelLabel != null && cancelLabel.isNotEmpty) ? cancelLabel : "取消",style: TextStyle(fontSize: 14,color: MyColor.greyColor_4)),
                        ),
                      ),
                    )
                  ],
                ) : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap:  cancel ?? (){Navigator.of(context).pop();},
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: MyColor.greyColor_5,width: 1)
                          ),
                          child: Center(
                            child: Text((cancelLabel != null && cancelLabel.isNotEmpty) ? cancelLabel : "取消",style: TextStyle(fontSize: 14,color: MyColor.greyColor_4)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: GestureDetector(
                        onTap: confirm ?? (){Navigator.of(context).pop();},
                        child: Container(
                          height: 42,
                          decoration: BoxDecoration(
                              color: MyColor.themeColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text((confirmLabel != null && confirmLabel.isNotEmpty) ? confirmLabel : "好的",style: TextStyle(fontSize: 14,color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
