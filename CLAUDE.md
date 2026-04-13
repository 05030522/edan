# 에덴 (Eden)

매일 5분 성경 묵상 앱. Flutter Web + Supabase + Riverpod + GoRouter. GitHub Pages(`docs/`) 배포.

## 절대 규칙 (위반 시 프로젝트 파손)

1. `docs/welcome/auth/callback/index.html`과 `docs/auth/callback/index.html`은 절대 삭제/덮어쓰기 금지 (OAuth 콜백용)
2. profiles 테이블 RLS 정책에서 profiles를 다시 SELECT 금지 (무한 재귀)
3. 빌드 후 반드시 `<base href="/edan/">` 확인
4. 404.html은 index.html과 동일해야 함 (SPA 라우팅)
5. app_router.dart의 `/welcome/auth/callback` 라우트 삭제 금지 (Supabase 리다이렉트 워크어라운드)
6. main.dart 초기화 순서 변경 금지: WidgetsBinding → usePathUrlStrategy → SupabaseService.initialize
7. authProvider는 autoDispose 절대 금지 (앱 전체 생명주기 유지 필수)
8. app_constants.dart의 levelThresholds/levelNames 배열 변경 금지 (기존 유저 진행도 파손)

## 코드 패턴 규칙

- 파일 편집 후 `dart analyze` 통과 필수
- 커밋 전 `dart format` 적용 필수
- 새 파일 생성보다 기존 파일 수정 우선
- StatefulWidget에서 async 작업 후 반드시 `if (mounted)` 체크
- 서버 작업 시 `state.isDevMode` 분기 필수 (devMode면 서버 호출 스킵)
- UI 업데이트는 로컬 퍼스트: 서버 저장 전에 로컬 상태 먼저 반영 (낙관적 UI)
- 웹/모바일 OAuth 분기: 웹=implicit, 모바일=PKCE (`kIsWeb`으로 분기)
- 한국 시간은 `DateTime.now().toUtc().add(Duration(hours: 9))` 사용

## 빌드

```bash
flutter build web --dart-define=FLUTTER_BASE_HREF='/edan/' --no-tree-shake-icons
```

## 프로젝트 구조

```
lib/
  core/        # constants, router, services, theme
  features/    # auth, home, onboarding, study, community, profile 등
docs/          # GitHub Pages 배포 폴더 (빌드 결과물)
docs/specs/    # 세부 스펙 문서
```

## 세부 문서 (필요시 참조)

- `docs/specs/auth-flow.md` — 카카오 OAuth 인증 흐름 상세
- `docs/specs/database.md` — Supabase DB 스키마, RLS 정책
- `docs/specs/deploy.md` — 배포 절차 상세
- `docs/specs/external-services.md` — 카카오/Supabase 대시보드 설정
