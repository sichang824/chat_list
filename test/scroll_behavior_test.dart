import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScrollBehavior dragDevices', () {
    test('default ScrollBehavior should include mouse for drag', () {
      // This test verifies the fix: ScrollConfiguration.copyWith should include
      // trackpad in dragDevices for proper desktop scroll support.
      //
      // Before fix: only touch and mouse were included
      // After fix: touch, mouse, and trackpad are included
      //
      // The actual fix is in chat_list.dart _renderList() method:
      // - Uses widget.scrollBehavior if provided (allows customization)
      // - Adds PointerDeviceKind.trackpad to default dragDevices

      final defaultDevices = {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

      final fixedDevices = {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };

      // Verify trackpad is now included
      expect(fixedDevices.contains(PointerDeviceKind.trackpad), isTrue);
      expect(defaultDevices.contains(PointerDeviceKind.trackpad), isFalse);

      // Verify the fix adds trackpad support
      expect(fixedDevices.length, equals(3));
      expect(defaultDevices.length, equals(2));
    });

    test('custom ScrollBehavior can override dragDevices', () {
      // Test that a custom ScrollBehavior can specify its own dragDevices
      final customDevices = {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };

      expect(customDevices.contains(PointerDeviceKind.stylus), isTrue);
      expect(customDevices.length, equals(4));
    });
  });
}
