# 배포 절차

## 빌드
```bash
flutter build web --dart-define=FLUTTER_BASE_HREF='/edan/' --no-tree-shake-icons
```

## docs/ 폴더에 복사
```bash
# 1. base href 설정
sed -i 's|<base href=".*">|<base href="/edan/">|' build/web/index.html

# 2. docs/에 복사 (주의: welcome/auth/callback/ 디렉토리는 유지됨)
cp -r build/web/* docs/

# 3. 404.html은 index.html과 동일하게 (SPA 라우팅용)
cp build/web/index.html docs/404.html
```

## 주의사항
- `docs/welcome/auth/callback/index.html` - OAuth 콜백용 물리 파일, 빌드 시 덮어쓰기 안 됨
- `docs/auth/callback/index.html` - 위와 동일
- 위 두 파일은 `docs/index.html`과 동일한 내용이어야 함 (Flutter 앱 로드)
