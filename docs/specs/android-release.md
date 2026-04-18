# Android 릴리즈 빌드 가이드

## 1. 릴리즈 서명 키 생성 (최초 1회)

### 1-1. keystore 생성
**중요**: 이 파일을 잃어버리면 Play Store에 앱 업데이트를 못 올립니다. 백업 필수.

```bash
cd "C:\Users\kjinh\OneDrive\Desktop\edan\android"

keytool -genkey -v -keystore eden-upload.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias eden-upload
```

Windows PowerShell에서는:
```powershell
cd C:\Users\kjinh\OneDrive\Desktop\edan\android
keytool -genkey -v -keystore eden-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias eden-upload
```

질문 답변 예시:
- keystore 비밀번호: **강한 비밀번호 설정 후 안전한 곳에 기록** (예: 비트워든)
- 이름과 성: 권진혁
- 조직 단위: Eden
- 조직명: 에덴
- 도시: Seoul
- 도/시: Seoul
- 국가 코드: KR
- 확인: y

### 1-2. key.properties 파일 생성
`android/key.properties` 파일에 아래 내용 작성 (**절대 git에 커밋하지 말 것** — 이미 .gitignore에 등록됨):

```properties
storePassword=여기에_keystore_비밀번호
keyPassword=여기에_key_비밀번호
keyAlias=eden-upload
storeFile=eden-upload.jks
```

### 1-3. 백업
- `eden-upload.jks` 를 **구글드라이브 개인 폴더** 또는 **1Password/비트워든 첨부파일**에 백업
- 비밀번호도 같이 저장

---

## 2. 릴리즈 AAB 빌드 (Play Store 업로드용)

```bash
cd "C:\Users\kjinh\OneDrive\Desktop\edan"
flutter build appbundle --release
```

결과물:
- `build/app/outputs/bundle/release/app-release.aab`
- 이 파일을 Play Console에 업로드

---

## 3. 디버그 APK 빌드 (실기기 테스트용)

```bash
flutter build apk --debug
```

결과물:
- `build/app/outputs/flutter-apk/app-debug.apk`
- USB로 폰에 직접 설치: `flutter install`

---

## 4. 릴리즈 APK 테스트 빌드 (서명 확인용)

```bash
flutter build apk --release
```

결과물:
- `build/app/outputs/flutter-apk/app-release.apk`

---

## 5. 버전 업데이트

`pubspec.yaml`의 `version` 수정:
```yaml
version: 1.0.1+2
#         ↑    ↑
#         |    버전 코드 (정수, Play Store 올릴 때마다 증가)
#         버전 이름 (사용자에게 보이는 문자열)
```

---

## 주의사항

- **keystore 파일 분실 = Play Store 앱 업데이트 불가**
- `android/key.properties`, `eden-upload.jks` 는 절대 git에 커밋 금지
- 업로드 후 첫 앱 등록 시 Google Play App Signing 사용 권장 (키 분실 시 복구 가능)
