/// 앱 전역에서 쓰는 에러 타입.
///
/// sealed class로 모든 하위 타입을 컴파일러가 추적 → `switch`에서 빠진 케이스 자동 감지.
///
/// 사용 예:
/// ```dart
/// try {
///   await someNetworkCall();
/// } catch (e) {
///   final err = AppError.from(e);
///   state = state.copyWith(error: err);
/// }
///
/// // UI에서:
/// if (state.error case final err?) {
///   ErrorSnackbar.show(context, err);
/// }
/// ```
sealed class AppError {
  /// 사용자에게 보여줄 한국어 메시지 (기술 용어 금지).
  final String message;

  /// 개발자·로그용 원본 에러.
  final Object? cause;

  const AppError(this.message, {this.cause});

  @override
  String toString() => '$runtimeType($message)';

  /// 임의의 예외를 AppError로 분류.
  ///
  /// 매칭 순서:
  /// 1. 이미 AppError면 그대로 반환
  /// 2. 네트워크 관련 키워드 → NetworkError
  /// 3. 인증/권한 관련 키워드 → AuthError
  /// 4. 그 외 → UnknownError
  factory AppError.from(Object error) {
    if (error is AppError) return error;

    final msg = error.toString().toLowerCase();

    if (msg.contains('socket') ||
        msg.contains('network') ||
        msg.contains('connection') ||
        msg.contains('timeout') ||
        msg.contains('failed host lookup')) {
      return NetworkError('인터넷 연결을 확인해 주세요', cause: error);
    }

    if (msg.contains('unauthorized') ||
        msg.contains('403') ||
        msg.contains('401') ||
        msg.contains('jwt') ||
        msg.contains('permission denied')) {
      return AuthError('로그인이 필요하거나 권한이 부족해요', cause: error);
    }

    return UnknownError('알 수 없는 오류가 발생했어요', cause: error);
  }
}

/// 네트워크 문제 (연결 끊김, 타임아웃 등).
class NetworkError extends AppError {
  const NetworkError(super.message, {super.cause});
}

/// 인증·권한 문제 (로그인 만료, RLS 거부 등).
class AuthError extends AppError {
  const AuthError(super.message, {super.cause});
}

/// 입력값 검증 실패.
class ValidationError extends AppError {
  const ValidationError(super.message, {super.cause});
}

/// 서버/Supabase 에러 (5xx, DB 제약 위반 등).
class ServerError extends AppError {
  const ServerError(super.message, {super.cause});
}

/// 분류되지 않은 기타 에러.
class UnknownError extends AppError {
  const UnknownError(super.message, {super.cause});
}
