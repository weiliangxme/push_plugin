class NotificationSetting{
  String messageType = '';
  String messageTypeName = '';
  List<NotificationSettingItem> subMessageTypeStateResps = [];
  NotificationSetting({required this.messageType,required this.messageTypeName,required this.subMessageTypeStateResps});
  NotificationSetting.fromJson(Map json) {
    this.messageType = json['messageType'] ?? '';
    this.messageTypeName = json['messageTypeName'] ?? '';
    if (json['subMessageTypeStateResps'] != null) {
      for (var item in json['subMessageTypeStateResps']) {
        this.subMessageTypeStateResps.add(NotificationSettingItem.fromJson(item));
            }
    } else {
      this.subMessageTypeStateResps = [];
    }
  }
}

class NotificationSettingItem{
  late int id;
  late String subtitleName;
  String? messageType;
  late bool openState;

  NotificationSettingItem({required this.id,required this.subtitleName,this.messageType,required this.openState});
  NotificationSettingItem.fromJson(Map json) {
    this.id = json['id'] ?? 0;
    this.subtitleName = json['subtitleName'] ?? '';
    this.messageType = json['messageType'] ?? '';
    this.openState = json['openState'] ?? false;
  }

}