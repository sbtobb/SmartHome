import 'result_code.dart';
class ResultData{
  String code;
  String msg;
  Map data;

  ResultData({this.code, this.msg, this.data});

  factory ResultData.fromJson(Map<String, dynamic> json) {
    String msg = ResultCode.getErrorMsg(json['code']);
    return ResultData(code: json['code'],msg:msg,data:json['data']);
  }

  @override
  String toString() {
    return 'ResultData{code: $code, msg: $msg, data: $data}';
  }

}