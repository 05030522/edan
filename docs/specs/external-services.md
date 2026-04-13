# 외부 서비스 설정

## Supabase Dashboard
- **Authentication > URL Configuration**
  - Site URL: `https://05030522.github.io/edan`
  - Redirect URLs: `https://05030522.github.io/edan/**`
- **Authentication > Providers > Kakao**
  - Client ID / Secret: 카카오 개발자 콘솔에서 발급
  - Callback URL: `https://<project>.supabase.co/auth/v1/callback`

## Kakao Developers Console
- **카카오 로그인 > Redirect URI**
  - `https://seawgpunbrnvmxjaseoy.supabase.co/auth/v1/callback`
  - (반드시 현재 사용 중인 Supabase 프로젝트의 URL과 일치해야 함)

## 교회 검색
카카오 로컬 API 대신 로컬 데이터 100개 사용 (`kakao_place_service.dart`).
API 키 없이 동작, 한국 주요 교회 전국 커버.

## 캐릭터
- **루양**: 양 캐릭터, `assets/images/루양.png`
- 파비콘 및 앱 아이콘으로 사용 중
