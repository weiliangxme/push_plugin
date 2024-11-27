
enum MessageSummaryType{
  ASSETS,
  EVENT,
  OFFICIAL,
  SOCIAL
}


class MessageSummaryModel {
  String?  messageType;
  String? messageTypeTitle;
  String? icon;
  String? firstTitle;
  String? firstContent;
  int? createTime;
  int? unReadNumber;

  MessageSummaryModel({
    String?  messageType,
    String? messageTypeTitle,
    String? icon,
    String? firstTitle,
    String? firstContent,
    int? createTime,
    int? unReadNumber,
  }) {
    this.messageType = messageType;
    this.messageTypeTitle = messageTypeTitle;
    this.icon = icon;
    this.firstTitle = firstTitle;
    this.firstContent = firstContent;
    this.createTime = createTime;
    this.unReadNumber = unReadNumber;
  }

  MessageSummaryModel.fromJson(Map json) {
    this.messageType = json['messageType'];
    this.messageTypeTitle = json['messageTypeTitle'];
    this.icon = json['icon'];
    this.firstTitle = json['firstTitle'];
    this.firstContent = json['firstContent'];
    this.createTime = json['createTime'];
    this.unReadNumber = json['unReadNumber'];
  }
}
