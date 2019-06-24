class SmartApi {
  ///登录
  static const String user_login = "abjhsdk/user/login";
  ///验证token
  static const String is_validate_token = "abjhsdk/user/validate";
  ///红外学习
  static const String study_ir = "abjhsdk/ir/:devName/study";
  //发送红外指令
  static const String send_ir = "abjhsdk/ir/:devName/send";
  ///控制插座
  static const String sock_ctrl = "abjhsdk/zigbee/sock/:devName";
  ///取得插座状态
  static const String get_sock_status = "abjhsdk/sock/properties";
  ///取得门磁状态
  static const String get_door_status = "abjhsdk/do/properties";
  ///取得温湿度
  static const String get_th_status = "abjhsdk/th/properties";


  static String getPath({String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    return sb.toString();
  }
}