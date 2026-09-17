import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/data/overpass_client.dart';

void main() {
  test(
    'first successful server wins even if others are slow or fail',
    () async {
      final result = await firstSuccess<String>([
        () async => throw Exception('certificate expired'),
        () => Future.delayed(const Duration(milliseconds: 200), () => 'slow'),
        () => Future.delayed(const Duration(milliseconds: 10), () => 'fast'),
      ]);

      expect(result, 'fast');
    },
  );

  test('fails only when every server fails', () async {
    await expectLater(
      firstSuccess<String>([
        () async => throw Exception('504'),
        () async => throw Exception('timeout'),
      ]),
      throwsA(isA<OverpassException>()),
    );
  });
}
