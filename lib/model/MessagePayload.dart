import 'dart:convert';

class MessagePayload {


  MessagePayload({
    required bool jumpType,
    required List<String> inUrl,
    required bool browserOpenType,
    required String outUrl,
    required bool dappFlag,
    required String sendPlanDetailId,//For click event reporting
    required String messageId,//for read push messages
    required int joinId,
    required String businessType,
  }){
    _jumpType = jumpType;//Whether to open internally, null means no operation
    _inUrl = inUrl;//Internal link address
    _browserOpenType = browserOpenType;//Whether the internal app is open
    _outUrl = outUrl;//URL
    _sendPlanDetailId = sendPlanDetailId;//The id used to click to report
    _messageId = messageId;//id used for read messages
    _dappFlag = dappFlag;//Whether to open the URL with dapp
    _joinId = joinId;
    _businessType =businessType;
  }

  MessagePayload.fromJson(dynamic json1) {
    Map<String, dynamic> jsonMap = jsonDecode(json1.toString());

      try{
        _inUrl = jsonMap.containsKey("inUrl")?jsonMap['inUrl'] != null ? jsonMap['inUrl'].cast<String>() : []:[];
        _browserOpenType = jsonMap.containsKey("browserOpenType")?jsonMap['browserOpenType']:false;
        _sendPlanDetailId = jsonMap.containsKey("sendPlanDetailId")?"${jsonMap['sendPlanDetailId']??'0'}":"0";
        _messageId = "${jsonMap['messageId']??'0'}";
        _jumpType = jsonMap['jumpType']==null?false:jsonMap['jumpType'];
        _dappFlag = jsonMap['dappFlag'] == null ? false : jsonMap['dappFlag'].toString().contains('true');
        _joinId = jsonMap.containsKey('joinId')?jsonMap['joinId'] == null ? 0:jsonMap['joinId']:0;
        _businessType = jsonMap.containsKey('businessType')?jsonMap['businessType'] == null ? "":jsonMap['businessType']:"";
      }catch(e){
        print("JOOO11:Parse error:$e");
      }

    _outUrl = jsonMap['outUrl']??'';

  }


  late bool _jumpType;
  late List<String> _inUrl;
  late bool _browserOpenType;
  late String _outUrl;
  late String _sendPlanDetailId;
  late String _messageId;
  late bool _dappFlag;
  late int _joinId;
  late String _businessType;

  MessagePayload copyWith({
    bool? jumpType,
    List<String>? inUrl,
    bool? browserOpenType,
    String? outUrl,
    String? sendPlanDetailId,
    String? messageId,
    bool? dappFlag,
    int? joinId,
    String? businessType,
  }) => MessagePayload(  jumpType: jumpType ?? _jumpType,
      inUrl: inUrl ?? _inUrl,
      browserOpenType: browserOpenType ?? _browserOpenType,
      outUrl: outUrl ?? _outUrl,
      sendPlanDetailId: sendPlanDetailId ?? _sendPlanDetailId,
      messageId: messageId ?? _messageId,
      dappFlag: dappFlag ?? _dappFlag,
      joinId:joinId??_joinId,
      businessType:businessType??_businessType
  );

  bool get jumpType => _jumpType;
  List<String> get inUrl => _inUrl;
  bool get browserOpenType => _browserOpenType;
  String get outUrl => _outUrl;
  String get sendPlanDetailId => _sendPlanDetailId;
  String get messageId => _messageId;
  bool get dappFlag => _dappFlag;
  int get joinId => _joinId;
  String get businessType => _businessType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jumpType'] = _jumpType;
    map['inUrl'] = _inUrl;
    map['browserOpenType'] = _browserOpenType;
    map['outUrl'] = _outUrl;
    map['sendPlanDetailId'] = _sendPlanDetailId;
    map['messageId'] = _messageId;
    map['dappFlag'] = _dappFlag;
    map['joinId'] = _joinId;
    map['businessType'] = _businessType;
    return map;
  }

}