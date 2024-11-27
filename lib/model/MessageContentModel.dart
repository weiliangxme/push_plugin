class MessageDataModel {
  List<MessageContentModel> content=[];
  int totalElements = 0;

  MessageDataModel();
  MessageDataModel.fromJson(Map json) {
    this.totalElements = json['totalElements'];
    this.content = (json['content'] ?? [])
        .map<MessageContentModel>((item) => MessageContentModel.fromJson(item))
        .toList();
  }
}
class MessageContentModel {
  late int id;
  late String msgContent;
  late String title;
  late String contentType;
  late String extras;
  late String userId;
  late bool sendState;
  late bool readState;
  late bool checkState;
  int? sendPlanDetailId;
  late Map<String,dynamic> payload;
  int? createTime;
  String timeString = '';
  String? subMessageType;
  int? subMessageTypeId;

  MessageContentModel.fromJson(Map json) {
    this.id = json['id'];
    this.msgContent = json['msgContent'] ?? '';
    this.title = json['titile'] ?? '';
    this.contentType = json['contentType'] ?? '';
    this.extras = json['extras'] ?? '';
    this.userId = json['userId'];
    this.sendState = json['sendState'] ?? false;
    this.readState = json['readState'] ?? false;
    this.checkState = json['checkState'] ?? false;
    this.sendPlanDetailId = json['sendPlanDetailId'];
    this.payload = json['payload'] ?? {};
    this.createTime = json['createTime'];
    this.subMessageType = json['subMessageType'];
    this.subMessageTypeId = json['subMessageTypeId'];
  }
}
