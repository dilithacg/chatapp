import 'package:chatapp/services/apiservice.dart';
import 'package:chatapp/utils/locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';


void main() {
  setUp(() {

    GetIt.instance.reset();
  });

  test('ApiService is registered correctly', () {

    setupLocator();


    expect(locator<ApiService>(), isA<ApiService>());
  });
}