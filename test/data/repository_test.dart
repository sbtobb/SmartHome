import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home/data/repository/api_repository.dart';

void main() {
  group(
      'Repository Test',
      () => {
            test('Login', () async {
              ApiRepository apiRepository = ApiRepository.instance;
              var result = await apiRepository.login("a", "a");
              print(result);
            }),
            test('ValidateToken', () async {
              ApiRepository apiRepository = ApiRepository.instance;
              var result = await apiRepository.isValidateToken();
              print(result);
            }),
            test('getSockStatus', () async {
              ApiRepository apiRepository = ApiRepository.instance;
              var result = await apiRepository.getSockStatus("123");
              print(result);
            }),
            test('gethStatus', () async {
              ApiRepository apiRepository = ApiRepository.instance;
              var result = await apiRepository.getThStatus("温湿度传感器");
              print(result);
            })
          });
}
