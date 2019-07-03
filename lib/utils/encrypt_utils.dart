import 'dart:convert';
import 'dart:core';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:smart_home/utils/time_utils.dart';

class EncryptUtils {
  static Map<String,String> generateSign(Map<String,String> data,String url){
    int currentTimes =  (TimeUtils.currentTimeMillis() / 1000).round();
    String currentTimeStr= currentTimes.toString();
    String dataStr = "";
    data.forEach((key,value){
      if(key == "system[token]"){
        return;
      }
      dataStr += "$key:$value,";
    });
    String encodeUri = Uri.encodeFull(url);
    String tmpEncry = EncryptUtils.generateMd5("${dataStr}url:${encodeUri},time:$currentTimeStr,secret:00000");

    int var21 = currentTimes % 9;
    int var9 = currentTimes % 7;
    int var14 = currentTimes % 4;

    String var16 = currentTimeStr.substring(0, 3);
    String var3 = currentTimeStr.substring(3, 6);
    String var18 = currentTimeStr.substring(6, 9);

    String var19 = tmpEncry.substring(0, var21);
    String var10 = tmpEncry.substring(var21, var21 + var9);
    String var11 = tmpEncry.substring(var21 + var9, var21 + var9 + var14);
    String var1 = tmpEncry.substring(var21 + var9 + var14);

    String sign = "abos" + var19 + var16 + var10 + var3 + var11 + var18 + var1;

    Map<String,String> signMap = {
      "system[sign]":sign,
      "system[time]":currentTimeStr
    };
    return signMap;
  }
  ///Generate MD5 hash
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}