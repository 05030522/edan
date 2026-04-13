# 데이터베이스 (Supabase)

## profiles 테이블 RLS 정책
```sql
-- 자기 프로필만 읽기/수정/삽입 가능 (단순한 정책, 재귀 없음)
CREATE POLICY "Users can read own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);
```

## 주의사항
- profiles 테이블을 참조하는 RLS 정책에서 profiles를 다시 SELECT하면 **무한 재귀** 발생
- `profiles_select_same_church` 같은 정책은 재귀를 유발하므로 삭제해야 함
