import 'result_data.dart';
import 'result_code.dart';
import 'package:smart_home/data/protocol/result_code.dart';
class ResultBool {
  /// 执行是否成功
  bool exeResult;
  /// 不成功的消息
  String msg;
  /// 状态
  bool status;

  ResultBool({this.exeResult, this.msg, this.status});

  factory ResultBool.fromResultData(ResultData resultData) {
    ResultBool resultBool = new ResultBool(exeResult: false);
    if(resultData.code == "00000"){
      resultBool.exeResult = true;
    }else{
      resultBool.exeResult = false;
    }
    resultBool.msg = ResultCode.getErrorMsg(resultData.code);
    if(resultData.data != null){
      if(resultData.data['state'] == "1"){
        resultBool.status = true;
      }else{
        resultBool.status = false;
      }
    }else{
      resultBool.status = false;
    }
    return resultBool;
  }

  @override
  String toString() {
    return 'ResultBool{exeResult: $exeResult, msg: $msg, status: $status}';
  }

}