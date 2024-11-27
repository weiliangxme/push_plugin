class PushClickModel {
  PushClickModel({
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
    _businessType = businessType;
  }

  PushClickModel.fromJson(dynamic json) {
    try{
      _inUrl = json['inUrl'] != null ? json['inUrl'].cast<String>() : [];
      _browserOpenType = json['browserOpenType']??false;
      _sendPlanDetailId = "${json['sendPlanDetailId']??'0'}";
      _messageId = "${json['messageId']??'0'}";
      _jumpType = json['jumpType']??false;
      _dappFlag = json['dappFlag']??false;
      _joinId = json['joinId'] == null ? 0:json['joinId'];
      _outUrl = json['outUrl']??'';
      _businessType = json['businessType']??'';
    }catch(e){
      print("JOOO11:Parse error:$e");
    }


  }

  late bool _jumpType;
  late List<String> _inUrl;
  late bool _browserOpenType;
  late String _outUrl;
  late dynamic _sendPlanDetailId;
  late dynamic _messageId;
  late bool _dappFlag;
  late int _joinId;
  late String _businessType;
  PushClickModel copyWith({
    required bool jumpType,
    required List<String> inUrl,
    required bool browserOpenType,
    required String outUrl,
    required String sendPlanDetailId,
    required String messageId,
    required bool dappFlag,
    required int joinId,
    required String businessType,
  }) => PushClickModel(  jumpType: jumpType ?? _jumpType,
      inUrl: inUrl ?? _inUrl,
      browserOpenType: browserOpenType ?? _browserOpenType,
      outUrl: outUrl ?? _outUrl,
      sendPlanDetailId: sendPlanDetailId ?? _sendPlanDetailId,
      messageId: messageId ?? _messageId,
      dappFlag: dappFlag ?? _dappFlag,
      joinId: joinId??_joinId,
      businessType:businessType??_businessType
  );
  bool get jumpType => _jumpType;
  List<String> get inUrl => _inUrl;
  bool get browserOpenType => _browserOpenType;
  String get outUrl => _outUrl;
  dynamic get sendPlanDetailId => _sendPlanDetailId;
  dynamic get messageId => _messageId;
  bool get dappFlag => _dappFlag;
  int get joinId => _joinId;
  String get businessType=>_businessType;

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