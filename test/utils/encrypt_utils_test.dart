import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home/utils/encrypt_utils.dart';

void main() {
  group(
      'Repository Test',
      () => {
            test('generateMd5', () async {
              String result = EncryptUtils.generateMd5("a");
              expect(result, "0cc175b9c0f1b6a831c399e269772661");
            }),
            test('generateSign', () async {
              String result = EncryptUtils.generateMd5("a");
              Map<String, String> data = {
                "password": result,
                "username": "a",
                "system[token]": "asdasdasdasdasdasdasdasd"
              };
              Map resultMap =
                  EncryptUtils.generateSign(data, "abjhsdk/user/login");
              expect(result, "0cc175b9c0f1b6a831c399e269772661");
              expect(resultMap['system[sign]'],
                  "abos5b4e15684d9ea107909e9799693f5d6263b3501d3");
              print(resultMap['system[sign]']);
            })
          });
}
