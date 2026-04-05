# 에덴 (Eden) - 프로젝트 가이드

## 개요
매일 5분 성경 묵상 앱. Flutter Web으로 빌드, GitHub Pages로 배포.

## 기술 스택
- **프레임워크**: Flutter Web
- **백엔드**: Supabase (Auth, Database, RLS)
- **상태관리**: Riverpod
- **라우팅**: GoRouter
- **배포**: GitHub Pages (`docs/` 폴더)

## 프로젝트 구조
```
lib/
  core/
    constants/     # Supabase URL/키, 앱 상수
    router/        # GoRouter 설정 + OAuth 콜백 처리
    services/      # Supabase, 소셜 로그인, 교회 검색
    theme/         # AppColors, AppTypography, AppTheme
  features/
    auth/          # 로그인/회원가입 화면, AuthProvider
    home/          # 홈 화면 (루양 인사말, 정원, 일일 과제)
    onboarding/    # 이름/사진/교회/알림 설정
    study/         # 성경 묵상, 퀴즈
    community/     # 커뮤니티
    profile/       # 프로필, 설정
docs/              # GitHub Pages 배포 폴더 (빌드 결과물)
```

## 빌드 & 배포

### 빌드
```bash
flutter build web --dart-define=FLUTTER_BASE_HREF='/edan/' --no-tree-shake-icons
```

### 배포 (docs/ 폴더에 복사)
```bash
# 1. base href 설정
sed -i 's|<base href=".*">|<base href="/edan/">|' build/web/index.html

# 2. docs/에 복사 (주의: welcome/auth/callback/ 디렉토리는 유지됨)
cp -r build/web/* docs/

# 3. 404.html은 index.html과 동일하게 (SPA 라우팅용)
cp build/web/index.html docs/404.html
```

**주의사항:**
- `docs/welcome/auth/callback/index.html` - OAuth 콜백용 물리 파일, 빌드 시 덮어쓰기 안 됨
- `docs/auth/callback/index.html` - 위와 동일
- 위 두 파일은 `docs/index.html`과 동일한 내용이어야 함 (Flutter 앱 로드)

## 인증 흐름 (카카오 로그인)

### 정상 흐름
```
1. 사용자가 카카오 로그인 클릭
2. signInWithOAuth() → Supabase OAuth URL 생성 → 카카오 인증 페이지
3. 카카오 인증 완료 → Supabase 콜백 (supabase.co/auth/v1/callback)
4. Supabase → 앱으로 리다이렉트 (#access_token=... URL fragment)
5. Flutter 앱 로드 → _AuthCallbackScreen
6. Supabase SDK가 URL fragment에서 토큰 자동 추출
7. onAuthStateChange 이벤트 감지 → 프로필 확인
8. 기존 사용자 → /home, 신규 사용자 → /onboarding/name
```

### 알려진 이슈
- Supabase가 코드의 redirectTo와 무관하게 `/welcome/auth/callback`으로 리다이렉트하는 경우 있음
- 이를 대비해 `docs/welcome/auth/callback/index.html` 물리 파일로 대응
- GitHub Pages는 SPA를 지원하지 않으므로 404.html = index.html로 설정

## 인증 설정 (외부 서비스)

### Supabase Dashboard
- **Authentication > URL Configuration**
  - Site URL: `https://05030522.github.io/edan`
  - Redirect URLs: `https://05030522.github.io/edan/**`
- **Authentication > Providers > Kakao**
  - Client ID / Secret: 카카오 개발자 콘솔에서 발급
  - Callback URL: `https://<project>.supabase.co/auth/v1/callback`

### Kakao Developers Console
- **카카오 로그인 > Redirect URI**
  - `https://seawgpunbrnvmxjaseoy.supabase.co/auth/v1/callback`
  - (반드시 현재 사용 중인 Supabase 프로젝트의 URL과 일치해야 함)

## 데이터베이스 (Supabase)

### profiles 테이블 RLS 정책
```sql
-- 자기 프로필만 읽기/수정/삽입 가능 (단순한 정책, 재귀 없음)
CREATE POLICY "Users can read own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);
```

**주의:** profiles 테이블을 참조하는 RLS 정책에서 profiles를 다시 SELECT하면 무한 재귀 발생.
`profiles_select_same_church` 같은 정책은 재귀를 유발하므로 삭제해야 함.

## 교회 검색
카카오 로컬 API 대신 로컬 데이터 100개 사용 (`kakao_place_service.dart`).
API 키 없이 동작, 한국 주요 교회 전국 커버.

## 캐릭터
- **루양**: 양 캐릭터, `assets/images/루양.png`
- 파비콘 및 앱 아이콘으로 사용 중
