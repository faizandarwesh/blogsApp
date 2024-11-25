import 'package:blogs_app/test/test_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TestController testController;

  setUp(() {
    testController = TestController();
  });

  tearDown(() {

  });

  group('This is a group which contains mathematical functions', () {
    test('A function which calculate the sum of values a and b', () {
      final result = testController.add(5, 7);
      expect(result, 12);
    });

    test('A function which calculate the subtraction of values a and b', () {
      final result = testController.sub(5, 7);
      expect(result, 30);
    });

    test('A function which calculate the multiplication of values a and b', () {
      final result = testController.multiply(5, 7);
      expect(result, 15);
    });
  });
}
