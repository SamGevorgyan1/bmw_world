import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:bmw_world/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.bmwBackgroundInterior).existsSync(), isTrue);
    expect(File(AppImages.bmwWelcomeBackground).existsSync(), isTrue);
    expect(File(AppImages.icBmw).existsSync(), isTrue);
    expect(File(AppImages.icBmwActive).existsSync(), isTrue);
  });
}
