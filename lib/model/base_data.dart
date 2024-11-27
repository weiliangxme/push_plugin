class BaseResponseModel {

  late dynamic data;
  late int errorCode;
  late String errorName;
  late String message;

  get success {
    return errorCode == 0 || errorCode == 200;
  }

  BaseResponseModel({
    required this.data,
    required this.errorCode,
    required this.errorName,
  });

  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    errorCode = json['errorCode'];
    errorName = json['errorName']??"";
    message = json['message'] ?? (json['msg'] ?? "");
  }

  @override
  String toString() {
    return 'BaseResponseModel{data: $data, errorCode: $errorCode, errorName: $errorName, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['errorCode'] = errorCode;
    data['errorName'] = errorName;
    data['message'] = message;
    return data;
  }
}

class TokenModel {
  late String jwt;

  TokenModel({required this.jwt});

  TokenModel.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jwt'] = jwt;
    return data;
  }
}
