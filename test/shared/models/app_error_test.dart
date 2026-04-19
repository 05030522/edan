import 'package:flutter_test/flutter_test.dart';
import 'package:eden_app/shared/models/app_error.dart';

void main() {
  group('AppError.from - 자동 분류', () {
    test('이미 AppError면 그대로 반환', () {
      const original = NetworkError('already classified');
      final result = AppError.from(original);
      expect(identical(result, original), true);
    });

    test('네트워크 관련 메시지 → NetworkError', () {
      final cases = [
        Exception('SocketException: failed'),
        Exception('Network is unreachable'),
        Exception('Connection refused'),
        Exception('Timeout exceeded'),
        Exception('Failed host lookup: api.example.com'),
      ];
      for (final c in cases) {
        final err = AppError.from(c);
        expect(
          err,
          isA<NetworkError>(),
          reason: '$c → ${err.runtimeType}',
        );
        expect(err.message.contains('인터넷'), true);
      }
    });

    test('인증/권한 관련 메시지 → AuthError', () {
      final cases = [
        Exception('Unauthorized'),
        Exception('401: Invalid credentials'),
        Exception('403: Forbidden'),
        Exception('JWT expired'),
        Exception('permission denied for table profiles'),
      ];
      for (final c in cases) {
        final err = AppError.from(c);
        expect(err, isA<AuthError>(), reason: '$c → ${err.runtimeType}');
      }
    });

    test('기타 메시지 → UnknownError', () {
      final err = AppError.from(Exception('something random'));
      expect(err, isA<UnknownError>());
    });

    test('원본 에러는 cause 필드에 보관', () {
      final source = Exception('test');
      final err = AppError.from(source);
      expect(err.cause, source);
    });
  });

  group('AppError 하위 타입 - sealed 동작', () {
    test('switch에서 모든 타입 처리 가능', () {
      // sealed class 컴파일 체크용 — 아래 switch가 빠진 케이스 없이 컴파일되면 OK
      String classify(AppError e) => switch (e) {
        NetworkError() => 'network',
        AuthError() => 'auth',
        ValidationError() => 'validation',
        ServerError() => 'server',
        UnknownError() => 'unknown',
      };

      expect(classify(const NetworkError('x')), 'network');
      expect(classify(const AuthError('x')), 'auth');
      expect(classify(const ValidationError('x')), 'validation');
      expect(classify(const ServerError('x')), 'server');
      expect(classify(const UnknownError('x')), 'unknown');
    });

    test('toString은 타입명과 메시지를 포함', () {
      const err = NetworkError('test message');
      expect(err.toString(), 'NetworkError(test message)');
    });
  });
}
