-- =============================================
-- 커뮤니티 기능: 같은 교회 멤버 프로필 조회 허용
-- =============================================

-- 같은 교회 소속 유저의 프로필을 읽을 수 있는 RLS 정책
-- 기존 profiles_select_own 정책과 OR 관계로 동작
CREATE POLICY "profiles_select_same_church"
    ON profiles FOR SELECT
    USING (
        church_id IS NOT NULL
        AND church_id = (
            SELECT p.church_id
            FROM profiles p
            WHERE p.id = auth.uid()
        )
    );

-- church_id 컬럼 인덱스 추가 (조회 성능 최적화)
CREATE INDEX IF NOT EXISTS idx_profiles_church_id ON profiles(church_id);
