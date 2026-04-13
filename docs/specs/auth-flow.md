# 인증 흐름 (카카오 로그인)

## 정상 흐름
```
1. 사용자가 카카오 로그인 클릭
2. signInWithOAuth() -> Supabase OAuth URL 생성 -> 카카오 인증 페이지
3. 카카오 인증 완료 -> Supabase 콜백 (supabase.co/auth/v1/callback)
4. Supabase -> 앱으로 리다이렉트 (#access_token=... URL fragment)
5. Flutter 앱 로드 -> _AuthCallbackScreen
6. Supabase SDK가 URL fragment에서 토큰 자동 추출
7. onAuthStateChange 이벤트 감지 -> 프로필 확인
8. 기존 사용자 -> /home, 신규 사용자 -> /onboarding/name
```

## 알려진 이슈
- Supabase가 코드의 redirectTo와 무관하게 `/welcome/auth/callback`으로 리다이렉트하는 경우 있음
- 이를 대비해 `docs/welcome/auth/callback/index.html` 물리 파일로 대응
- GitHub Pages는 SPA를 지원하지 않으므로 404.html = index.html로 설정
