-- ============================================================================
-- Eden (에덴) - 기독교 성경 공부 앱 데이터베이스 스키마
-- Supabase PostgreSQL 마이그레이션
-- ============================================================================
-- 이 파일은 에덴 앱의 전체 데이터베이스 스키마를 정의합니다.
-- 15개 테이블, RLS 정책, 인덱스, 트리거, 시드 데이터를 포함합니다.
-- ============================================================================

-- ==========================================================================
-- 1. 교회 디렉토리 (churches)
-- ==========================================================================
CREATE TABLE churches (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name            TEXT NOT NULL,
    denomination    TEXT,
    address         TEXT,
    city            TEXT,
    district        TEXT,
    member_count    INT DEFAULT 0,
    verified        BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE churches IS '교회 디렉토리 - 등록된 교회 정보를 관리합니다';

-- ==========================================================================
-- 2. 사용자 프로필 (profiles)
-- ==========================================================================
CREATE TABLE profiles (
    id                      UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    display_name            TEXT NOT NULL DEFAULT '',
    church_id               UUID REFERENCES churches(id),
    faith_points            INT DEFAULT 0,
    current_level           INT DEFAULT 1,
    current_streak          INT DEFAULT 0,
    longest_streak          INT DEFAULT 0,
    last_study_date         DATE,
    dark_mode               BOOLEAN DEFAULT FALSE,
    notification_enabled    BOOLEAN DEFAULT TRUE,
    notification_time       TIME DEFAULT '08:00',
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    updated_at              TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE profiles IS '사용자 프로필 - auth.users와 1:1 연결된 사용자 정보';

-- ==========================================================================
-- 3. 학습 경로 (learning_paths)
-- ==========================================================================
CREATE TABLE learning_paths (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title           TEXT NOT NULL,
    description     TEXT NOT NULL,
    total_days      INT NOT NULL,
    difficulty      TEXT NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE learning_paths IS '학습 경로 - 성경 공부 트랙을 정의합니다';

-- ==========================================================================
-- 4. 개별 레슨 (lessons)
-- ==========================================================================
CREATE TABLE lessons (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    path_id                 UUID REFERENCES learning_paths(id) ON DELETE CASCADE NOT NULL,
    day_number              INT NOT NULL,
    title                   TEXT NOT NULL,
    bible_book              TEXT NOT NULL,
    bible_chapter           INT NOT NULL,
    bible_verse_start       INT NOT NULL,
    bible_verse_end         INT NOT NULL,
    bible_text              TEXT NOT NULL,
    background_explanation  TEXT NOT NULL,
    selah_question          TEXT NOT NULL,
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(path_id, day_number)
);

COMMENT ON TABLE lessons IS '개별 레슨 - 각 학습 경로의 일일 레슨 내용';

-- ==========================================================================
-- 5. 퀴즈 (quizzes)
-- ==========================================================================
CREATE TABLE quizzes (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lesson_id       UUID REFERENCES lessons(id) ON DELETE CASCADE NOT NULL,
    question        TEXT NOT NULL,
    options         JSONB NOT NULL,
    correct_index   INT NOT NULL,
    explanation     TEXT NOT NULL,
    order_index     INT DEFAULT 0,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE quizzes IS '퀴즈 - 각 레슨에 대한 퀴즈 문제';

-- ==========================================================================
-- 6. 사용자 진행도 (user_progress)
-- ==========================================================================
CREATE TABLE user_progress (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                 UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    lesson_id               UUID REFERENCES lessons(id) ON DELETE CASCADE NOT NULL,
    path_id                 UUID REFERENCES learning_paths(id) ON DELETE CASCADE NOT NULL,
    completed               BOOLEAN DEFAULT FALSE,
    quiz_score              INT DEFAULT 0,
    faith_points_earned     INT DEFAULT 0,
    selah_response          TEXT,
    mood                    TEXT,
    prayer_note             TEXT,
    completed_at            TIMESTAMPTZ,
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, lesson_id)
);

COMMENT ON TABLE user_progress IS '사용자 진행도 - 레슨 완료 및 퀴즈 결과 추적';

-- ==========================================================================
-- 7. 일일 기록 (daily_records)
-- ==========================================================================
CREATE TABLE daily_records (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                 UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    record_date             DATE NOT NULL,
    lessons_completed       INT DEFAULT 0,
    faith_points_earned     INT DEFAULT 0,
    created_at              TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, record_date)
);

COMMENT ON TABLE daily_records IS '일일 기록 - 사용자의 일일 활동 로그';

-- ==========================================================================
-- 8. 스트릭 (streaks) - 사용자별 연속 학습 상태
-- ==========================================================================
CREATE TABLE streaks (
    id                          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                     UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE NOT NULL,
    current_streak              INT DEFAULT 0,
    longest_streak              INT DEFAULT 0,
    total_study_days            INT DEFAULT 0,
    grace_days_remaining        INT DEFAULT 1,
    grace_day_last_recharged    DATE,
    last_study_date             DATE,
    streak_start_date           DATE,
    updated_at                  TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE streaks IS '스트릭 - 사용자별 연속 학습 상태 관리';

-- ==========================================================================
-- 9. 스트릭 캘린더 (streak_calendar) - 캘린더 히트맵용 일일 기록
-- ==========================================================================
CREATE TABLE streak_calendar (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id             UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    study_date          DATE NOT NULL,
    lessons_count       INT DEFAULT 1,
    grace_day_used      BOOLEAN DEFAULT FALSE,
    created_at          TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, study_date)
);

COMMENT ON TABLE streak_calendar IS '스트릭 캘린더 - 캘린더 히트맵을 위한 일일 학습 기록';

-- ==========================================================================
-- 10. 사용자 정원 (user_gardens)
-- ==========================================================================
CREATE TABLE user_gardens (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES auth.users(id) ON DELETE CASCADE UNIQUE NOT NULL,
    garden_level    INT DEFAULT 1,
    theme           TEXT DEFAULT 'default',
    items           JSONB DEFAULT '[]',
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE user_gardens IS '사용자 정원 - 사용자별 에덴 정원 상태';

-- ==========================================================================
-- 11. 정원 아이템 카탈로그 (garden_items)
-- ==========================================================================
CREATE TABLE garden_items (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                TEXT NOT NULL,
    description         TEXT,
    bible_reference     TEXT,
    bible_verse         TEXT,
    category            TEXT NOT NULL CHECK (category IN ('plant', 'tree', 'decoration', 'animal', 'water', 'structure')),
    rarity              TEXT DEFAULT 'common' CHECK (rarity IN ('common', 'rare', 'epic', 'legendary')),
    unlock_condition    TEXT,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE garden_items IS '정원 아이템 카탈로그 - 정원에 배치할 수 있는 아이템 목록';

-- ==========================================================================
-- 12. 퀘스트 정의 (quests)
-- ==========================================================================
CREATE TABLE quests (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title               TEXT NOT NULL,
    description         TEXT,
    type                TEXT NOT NULL CHECK (type IN ('daily', 'weekly', 'special', 'challenge')),
    condition_type      TEXT NOT NULL,
    condition_value     INT NOT NULL,
    reward_fp           INT DEFAULT 0,
    reward_item_id      UUID REFERENCES garden_items(id),
    is_active           BOOLEAN DEFAULT TRUE,
    season              TEXT,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE quests IS '퀘스트 정의 - 일일/주간/특별 퀘스트 정의';

-- ==========================================================================
-- 13. 사용자 퀘스트 진행 (user_quests)
-- ==========================================================================
CREATE TABLE user_quests (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    quest_id        UUID REFERENCES quests(id) ON DELETE CASCADE NOT NULL,
    progress        INT DEFAULT 0,
    completed       BOOLEAN DEFAULT FALSE,
    completed_at    TIMESTAMPTZ,
    assigned_date   DATE NOT NULL,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE user_quests IS '사용자 퀘스트 진행 - 사용자별 퀘스트 진행 상태';

-- ==========================================================================
-- 14. 업적/배지 정의 (achievements)
-- ==========================================================================
CREATE TABLE achievements (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title               TEXT NOT NULL,
    description         TEXT NOT NULL,
    icon_name           TEXT NOT NULL,
    condition_type      TEXT NOT NULL,
    condition_value     INT NOT NULL,
    reward_fp           INT DEFAULT 0,
    is_hidden           BOOLEAN DEFAULT FALSE,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE achievements IS '업적/배지 정의 - 달성 가능한 업적 목록';

-- ==========================================================================
-- 15. 사용자 업적 (user_achievements)
-- ==========================================================================
CREATE TABLE user_achievements (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id             UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    achievement_id      UUID REFERENCES achievements(id) ON DELETE CASCADE NOT NULL,
    unlocked_at         TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, achievement_id)
);

COMMENT ON TABLE user_achievements IS '사용자 업적 - 사용자가 달성한 업적 기록';


-- ============================================================================
-- 인덱스 (Indexes)
-- ============================================================================
-- 성능 최적화를 위한 복합 인덱스

CREATE INDEX idx_user_progress_user_path ON user_progress(user_id, path_id);
COMMENT ON INDEX idx_user_progress_user_path IS '사용자별 학습 경로 진행도 조회 최적화';

CREATE INDEX idx_daily_records_user_date ON daily_records(user_id, record_date);
COMMENT ON INDEX idx_daily_records_user_date IS '사용자별 날짜 기반 일일 기록 조회 최적화';

CREATE INDEX idx_streak_calendar_user_date ON streak_calendar(user_id, study_date);
COMMENT ON INDEX idx_streak_calendar_user_date IS '사용자별 스트릭 캘린더 조회 최적화';

CREATE INDEX idx_lessons_path_day ON lessons(path_id, day_number);
COMMENT ON INDEX idx_lessons_path_day IS '학습 경로별 레슨 순서 조회 최적화';


-- ============================================================================
-- Row Level Security (RLS) 정책
-- ============================================================================

-- --------------------------------------------------------------------------
-- 공개 읽기 테이블: churches, learning_paths, lessons, quizzes,
--                   garden_items, quests, achievements
-- --------------------------------------------------------------------------

-- churches: 누구나 읽기 가능
ALTER TABLE churches ENABLE ROW LEVEL SECURITY;

CREATE POLICY "churches_public_read"
    ON churches FOR SELECT
    USING (true);

-- learning_paths: 누구나 읽기 가능
ALTER TABLE learning_paths ENABLE ROW LEVEL SECURITY;

CREATE POLICY "learning_paths_public_read"
    ON learning_paths FOR SELECT
    USING (true);

-- lessons: 누구나 읽기 가능
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;

CREATE POLICY "lessons_public_read"
    ON lessons FOR SELECT
    USING (true);

-- quizzes: 누구나 읽기 가능
ALTER TABLE quizzes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "quizzes_public_read"
    ON quizzes FOR SELECT
    USING (true);

-- garden_items: 누구나 읽기 가능
ALTER TABLE garden_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "garden_items_public_read"
    ON garden_items FOR SELECT
    USING (true);

-- quests: 누구나 읽기 가능
ALTER TABLE quests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "quests_public_read"
    ON quests FOR SELECT
    USING (true);

-- achievements: 누구나 읽기 가능
ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "achievements_public_read"
    ON achievements FOR SELECT
    USING (true);

-- --------------------------------------------------------------------------
-- profiles: 본인 프로필만 읽기/수정 가능
-- --------------------------------------------------------------------------
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "profiles_select_own"
    ON profiles FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "profiles_update_own"
    ON profiles FOR UPDATE
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

-- 회원가입 트리거에서 INSERT 하므로 INSERT 정책도 필요
CREATE POLICY "profiles_insert_own"
    ON profiles FOR INSERT
    WITH CHECK (auth.uid() = id);

-- --------------------------------------------------------------------------
-- user_progress: 본인 진행도만 읽기/삽입/수정 가능
-- --------------------------------------------------------------------------
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_progress_select_own"
    ON user_progress FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "user_progress_insert_own"
    ON user_progress FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "user_progress_update_own"
    ON user_progress FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- --------------------------------------------------------------------------
-- daily_records: 본인 기록만 읽기/삽입 가능
-- --------------------------------------------------------------------------
ALTER TABLE daily_records ENABLE ROW LEVEL SECURITY;

CREATE POLICY "daily_records_select_own"
    ON daily_records FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "daily_records_insert_own"
    ON daily_records FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- --------------------------------------------------------------------------
-- streaks: 본인 스트릭만 읽기/수정 가능
-- --------------------------------------------------------------------------
ALTER TABLE streaks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "streaks_select_own"
    ON streaks FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "streaks_update_own"
    ON streaks FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- 회원가입 시 자동 생성을 위한 INSERT 정책
CREATE POLICY "streaks_insert_own"
    ON streaks FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- --------------------------------------------------------------------------
-- streak_calendar: 본인 캘린더만 읽기/삽입 가능
-- --------------------------------------------------------------------------
ALTER TABLE streak_calendar ENABLE ROW LEVEL SECURITY;

CREATE POLICY "streak_calendar_select_own"
    ON streak_calendar FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "streak_calendar_insert_own"
    ON streak_calendar FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- --------------------------------------------------------------------------
-- user_gardens: 본인 정원만 읽기/수정 가능
-- --------------------------------------------------------------------------
ALTER TABLE user_gardens ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_gardens_select_own"
    ON user_gardens FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "user_gardens_update_own"
    ON user_gardens FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- 회원가입 시 자동 생성을 위한 INSERT 정책
CREATE POLICY "user_gardens_insert_own"
    ON user_gardens FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- --------------------------------------------------------------------------
-- user_quests: 본인 퀘스트만 읽기/삽입/수정 가능
-- --------------------------------------------------------------------------
ALTER TABLE user_quests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_quests_select_own"
    ON user_quests FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "user_quests_insert_own"
    ON user_quests FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "user_quests_update_own"
    ON user_quests FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- --------------------------------------------------------------------------
-- user_achievements: 본인 업적만 읽기 가능 (삽입은 트리거/함수를 통해)
-- --------------------------------------------------------------------------
ALTER TABLE user_achievements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_achievements_select_own"
    ON user_achievements FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "user_achievements_insert_own"
    ON user_achievements FOR INSERT
    WITH CHECK (auth.uid() = user_id);


-- ============================================================================
-- 트리거: 회원가입 시 프로필 자동 생성
-- ============================================================================

-- 회원가입 시 profiles, streaks, user_gardens 행을 자동 생성하는 함수
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
    -- 프로필 생성
    INSERT INTO public.profiles (id, display_name)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data ->> 'display_name', '')
    );

    -- 스트릭 초기화
    INSERT INTO public.streaks (user_id)
    VALUES (NEW.id);

    -- 정원 초기화
    INSERT INTO public.user_gardens (user_id)
    VALUES (NEW.id);

    RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.handle_new_user() IS '회원가입 시 프로필, 스트릭, 정원을 자동 생성하는 트리거 함수';

-- auth.users에 새 행이 삽입될 때 트리거 실행
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();


-- ============================================================================
-- updated_at 자동 갱신 트리거
-- ============================================================================

CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.handle_updated_at() IS 'updated_at 컬럼을 자동으로 현재 시각으로 갱신하는 트리거 함수';

CREATE TRIGGER set_profiles_updated_at
    BEFORE UPDATE ON profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_streaks_updated_at
    BEFORE UPDATE ON streaks
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER set_user_gardens_updated_at
    BEFORE UPDATE ON user_gardens
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_updated_at();


-- ============================================================================
-- 시드 데이터 (Seed Data)
-- ============================================================================

-- --------------------------------------------------------------------------
-- 교회 시드 데이터 (5개)
-- --------------------------------------------------------------------------
INSERT INTO churches (name, denomination, address, city, district, member_count, verified) VALUES
    ('사랑의교회', '대한예수교장로회(합동)', '서울특별시 서초구 반포대로 121', '서울', '서초구', 70000, TRUE),
    ('온누리교회', '대한예수교장로회(합동)', '서울특별시 용산구 한남대로 10길 22', '서울', '용산구', 60000, TRUE),
    ('여의도순복음교회', '기독교대한하나님의성회', '서울특별시 영등포구 여의대방로 11', '서울', '영등포구', 480000, TRUE),
    ('명성교회', '대한예수교장로회(통합)', '서울특별시 강남구 선릉로 5길 16', '서울', '강남구', 80000, TRUE),
    ('충신교회', '대한예수교장로회(합동)', '서울특별시 중구 퇴계로 199', '서울', '중구', 15000, TRUE);

-- --------------------------------------------------------------------------
-- 학습 경로 시드 데이터 (2개)
-- --------------------------------------------------------------------------
INSERT INTO learning_paths (id, title, description, total_days, difficulty) VALUES
    (
        '11111111-1111-1111-1111-111111111111',
        '신앙의 첫걸음',
        '성경을 처음 접하는 분들을 위한 14일 입문 코스입니다. 요한복음을 중심으로 하나님의 사랑과 구원의 메시지를 배웁니다.',
        14,
        'beginner'
    ),
    (
        '22222222-2222-2222-2222-222222222222',
        '불안을 넘어 평안으로',
        '일상의 불안과 걱정을 하나님의 말씀으로 극복하는 14일 과정입니다. 시편과 빌립보서를 중심으로 참된 평안을 찾아갑니다.',
        14,
        'intermediate'
    );

-- --------------------------------------------------------------------------
-- 레슨 시드 데이터 (경로 1의 3개 레슨)
-- --------------------------------------------------------------------------
INSERT INTO lessons (id, path_id, day_number, title, bible_book, bible_chapter, bible_verse_start, bible_verse_end, bible_text, background_explanation, selah_question) VALUES
    (
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        '11111111-1111-1111-1111-111111111111',
        1,
        '하나님의 사랑',
        '요한복음',
        3,
        16,
        16,
        '하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니 이는 그를 믿는 자마다 멸망하지 않고 영생을 얻게 하려 하심이라',
        '요한복음 3장 16절은 성경 전체의 핵심을 한 문장으로 요약한 구절입니다. 이 말씀은 예수님께서 유대인의 지도자인 니고데모에게 하신 대화 속에서 나옵니다. ''세상''이라는 단어는 모든 민족, 모든 사람을 포함하며, ''독생자''는 하나님의 유일하신 아들 예수 그리스도를 가리킵니다. 이 구절은 하나님의 사랑이 얼마나 크고 넓은지를 보여줍니다.',
        '하나님이 세상을 사랑하신다는 것을 내 삶에서 어떻게 경험하고 있나요? 오늘 하루 동안 하나님의 사랑을 느낀 순간이 있었나요?'
    ),
    (
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        '11111111-1111-1111-1111-111111111111',
        2,
        '길이요 진리요 생명',
        '요한복음',
        14,
        6,
        6,
        '예수께서 이르시되 내가 곧 길이요 진리요 생명이니 나로 말미암지 않고는 아버지께로 올 자가 없느니라',
        '이 말씀은 예수님께서 제자들에게 하신 고별 설교의 일부입니다. 도마가 "주여 어디로 가시는지 우리가 알지 못하거늘 그 길을 어찌 알겠사옵나이까"라고 물었을 때 예수님께서 대답하신 내용입니다. ''길''은 하나님께 이르는 유일한 방법을, ''진리''는 참된 진리의 원천을, ''생명''은 영원한 생명의 근원을 의미합니다. 이 세 가지 표현을 통해 예수님은 자신이 구원의 유일한 중보자임을 선언하십니다.',
        '예수님이 길이요 진리요 생명이라는 말씀이 내 일상에 어떤 의미가 있을까요? 삶에서 방향을 잃었을 때 이 말씀을 어떻게 적용할 수 있을까요?'
    ),
    (
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        '11111111-1111-1111-1111-111111111111',
        3,
        '보혜사 성령',
        '요한복음',
        14,
        26,
        26,
        '보혜사 곧 아버지께서 내 이름으로 보내실 성령 그가 너희에게 모든 것을 가르치고 내가 너희에게 말한 모든 것을 생각나게 하리라',
        '보혜사(파라클레토스)는 ''곁에서 돕는 자'', ''위로자'', ''상담자''라는 뜻을 가진 헬라어입니다. 예수님은 자신이 떠나신 후에도 제자들이 홀로 남겨지지 않을 것임을 약속하셨습니다. 성령은 예수님의 가르침을 기억하게 하고, 진리를 깨닫게 하며, 신앙 생활에서 능력을 주시는 분입니다. 이 약속은 오늘날 모든 믿는 자에게도 동일하게 적용됩니다.',
        '일상에서 성령의 인도하심을 경험한 적이 있나요? 기도할 때나 성경을 읽을 때 마음에 와닿는 깨달음을 받은 적이 있다면 나눠주세요.'
    );

-- --------------------------------------------------------------------------
-- 퀴즈 시드 데이터 (레슨당 1개, 총 3개)
-- --------------------------------------------------------------------------
INSERT INTO quizzes (lesson_id, question, options, correct_index, explanation, order_index) VALUES
    (
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        '요한복음 3:16에서 하나님이 세상을 사랑하셔서 주신 것은 무엇인가요?',
        '["천사", "율법", "독생자", "성전"]',
        2,
        '하나님이 세상을 이처럼 사랑하사 "독생자"를 주셨습니다. 독생자는 하나님의 유일한 아들 예수 그리스도를 의미합니다.',
        0
    ),
    (
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        '예수님이 자신을 가리켜 말씀하신 세 가지는 무엇인가요?',
        '["빛과 소금과 열매", "길과 진리와 생명", "사랑과 평화와 기쁨", "믿음과 소망과 사랑"]',
        1,
        '예수님은 요한복음 14:6에서 "내가 곧 길이요 진리요 생명이니"라고 말씀하셨습니다.',
        0
    ),
    (
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        '"보혜사"의 뜻으로 가장 적절한 것은 무엇인가요?',
        '["심판자", "곁에서 돕는 자", "통치자", "예언자"]',
        1,
        '보혜사(파라클레토스)는 헬라어로 "곁에서 돕는 자", "위로자", "상담자"라는 뜻입니다. 성령을 가리키는 표현입니다.',
        0
    );

-- --------------------------------------------------------------------------
-- 업적 시드 데이터 (10개 히든 업적)
-- --------------------------------------------------------------------------
INSERT INTO achievements (title, description, icon_name, condition_type, condition_value, reward_fp, is_hidden) VALUES
    (
        '새벽 기도',
        '새벽 5시~7시 사이에 레슨을 완료하세요',
        'sunrise',
        'early_morning_study',
        1,
        50,
        TRUE
    ),
    (
        '밤의 묵상',
        '밤 10시~12시 사이에 레슨을 완료하세요',
        'moon',
        'late_night_study',
        1,
        50,
        TRUE
    ),
    (
        '첫 열매',
        '첫 번째 레슨을 완료하세요',
        'seedling',
        'lessons_completed',
        1,
        30,
        TRUE
    ),
    (
        '시편의 노래',
        '7일 연속으로 학습하세요',
        'music',
        'streak_days',
        7,
        100,
        TRUE
    ),
    (
        '에덴의 정원사',
        '정원에 아이템 5개를 배치하세요',
        'garden',
        'garden_items_placed',
        5,
        80,
        TRUE
    ),
    (
        '말씀의 전사',
        '퀴즈에서 연속 10회 만점을 받으세요',
        'shield',
        'perfect_quiz_streak',
        10,
        150,
        TRUE
    ),
    (
        '기도의 사람',
        '기도 노트를 10개 작성하세요',
        'pray',
        'prayer_notes_written',
        10,
        70,
        TRUE
    ),
    (
        '은혜의 날',
        '30일 연속으로 학습하세요',
        'calendar-check',
        'streak_days',
        30,
        300,
        TRUE
    ),
    (
        '함께하는 기쁨',
        '교회에 가입하세요',
        'church',
        'joined_church',
        1,
        40,
        TRUE
    ),
    (
        '에덴의 왕',
        '모든 학습 경로를 완료하세요',
        'crown',
        'all_paths_completed',
        1,
        500,
        TRUE
    );

-- --------------------------------------------------------------------------
-- 정원 아이템 시드 데이터 (9개)
-- --------------------------------------------------------------------------
INSERT INTO garden_items (name, description, bible_reference, bible_verse, category, rarity, unlock_condition) VALUES
    (
        '겨자씨 나무',
        '가장 작은 씨앗에서 자라나는 큰 나무. 작은 믿음이 큰 역사를 이룹니다.',
        '마태복음 17:20',
        '만일 너희에게 믿음이 겨자씨 한 알만큼만 있어도 이 산을 명하여 여기서 저기로 옮겨지라 하면 옮겨질 것이요',
        'tree',
        'common',
        '첫 레슨 완료'
    ),
    (
        '올리브 나무',
        '평화와 화해의 상징. 겟세마네 동산의 올리브 나무를 기억하세요.',
        '로마서 11:17',
        '또한 가지 얼마가 꺾이었는데 돌 올리브인 네가 그들 중에 접붙임이 되어 참 올리브 뿌리의 진액을 함께 받는 자가 되었은즉',
        'tree',
        'rare',
        '7일 연속 학습'
    ),
    (
        '무화과나무',
        '예수님께서 예루살렘에서 말씀하신 무화과나무의 비유를 담고 있습니다.',
        '마태복음 24:32',
        '무화과나무의 비유를 배우라 그 가지가 연하여지고 잎사귀를 내면 여름이 가까운 줄을 아나니',
        'tree',
        'rare',
        '3개 학습 경로 시작'
    ),
    (
        '백합화',
        '들의 백합화를 보라. 하나님의 돌보심을 상징하는 아름다운 꽃입니다.',
        '마태복음 6:28-29',
        '들의 백합화가 어떻게 자라는가 생각하여 보라 수고도 아니하고 길쌈도 아니하느니라',
        'plant',
        'common',
        '5개 셀라 응답 작성'
    ),
    (
        '포도나무',
        '예수님은 참 포도나무이시고 우리는 그 가지입니다.',
        '요한복음 15:5',
        '나는 포도나무요 너희는 가지라 그가 내 안에, 내가 그 안에 거하면 사람이 열매를 많이 맺나니',
        'plant',
        'epic',
        '첫 번째 학습 경로 완료'
    ),
    (
        '석류나무',
        '아가서에 등장하는 석류나무. 풍성한 열매의 상징입니다.',
        '아가 4:13',
        '네게서 나는 것은 석류 동산이요 귀한 열매와 고벨화와 나드와',
        'tree',
        'epic',
        '100일 총 학습일 달성'
    ),
    (
        '생명수 샘',
        '영원히 목마르지 않는 생명의 물. 정원에 생기를 불어넣습니다.',
        '요한계시록 22:1',
        '또 그가 수정 같이 맑은 생명수의 강을 내게 보이니 하나님과 및 어린 양의 보좌로부터 나와서',
        'water',
        'legendary',
        '30일 연속 학습 달성'
    ),
    (
        '돌제단',
        '하나님께 드리는 예배의 제단. 기도와 감사의 장소입니다.',
        '창세기 12:7',
        '여호와께서 아브람에게 나타나 이르시되 내가 이 땅을 네 자손에게 주리라 하신지라 그가 거기서 여호와를 위하여 제단을 쌓으니라',
        'structure',
        'rare',
        '기도 노트 20개 작성'
    ),
    (
        '무지개',
        '하나님의 언약의 상징. 정원 위에 펼쳐지는 아름다운 무지개입니다.',
        '창세기 9:13',
        '내가 내 무지개를 구름 속에 두었나니 이것이 나와 세상 사이의 언약의 증거니라',
        'decoration',
        'legendary',
        '모든 업적 달성'
    );


-- ============================================================================
-- 스키마 생성 완료
-- ============================================================================
-- 테이블: 15개
-- RLS 정책: 활성화 완료
-- 인덱스: 4개
-- 트리거: 3개 (회원가입 시 프로필 생성, updated_at 자동 갱신 x2)
-- 시드 데이터: 교회 5개, 학습 경로 2개, 레슨 3개, 퀴즈 3개, 업적 10개, 정원 아이템 9개
-- ============================================================================
