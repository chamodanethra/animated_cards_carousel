import 'package:animated_cards_carousel/src/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Carousel Animation Functions Tests', () {
    // --- getInterpolatePos Tests ---

    test('getInterpolatePos: Test below bottom threshold', () {
      double result = getInterpolatePos(100, 100, 200, 300);
      expect(result, 0);
    });

    test('getInterpolatePos: Test at bottom threshold', () {
      double result = getInterpolatePos(200, 100, 200, 300);
      expect(result, 0);
    });

    test('getInterpolatePos: Test between bottom and appearing', () {
      double result = getInterpolatePos(250, 100, 200, 300);
      expect(result, -12.5);
    });

    test('getInterpolatePos: Test at appearing threshold', () {
      double result = getInterpolatePos(300, 100, 200, 300);
      expect(result, -25);
    });

    test('getInterpolatePos: Test above appearing threshold', () {
      double result = getInterpolatePos(400, 100, 200, 300);
      expect(result, -25);
    });

    // --- getAnimatedScale Tests ---

    test('getAnimatedScale: Test below disappearing threshold', () {
      double result = getAnimatedScale(-100, -100, 0, 100, 200);
      expect(result, 0.5);
    });

    // --- getAnimatedOpacity Tests ---

    test('getAnimatedOpacity: Test below disappearing threshold', () {
      double result = getAnimatedOpacity(-100, -100, 0, 100, 200);
      expect(result, 0.5);
    });
  });
}
