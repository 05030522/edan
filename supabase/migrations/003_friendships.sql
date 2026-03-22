-- =============================================
-- 친구 시스템 테이블
-- =============================================

CREATE TABLE friendships (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    requester_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    receiver_id     UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    status          TEXT NOT NULL DEFAULT 'pending'
                    CHECK (status IN ('pending', 'accepted', 'rejected')),
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),

    -- 같은 사람에게 중복 요청 방지
    UNIQUE (requester_id, receiver_id),
    -- 자기 자신에게 요청 방지
    CHECK (requester_id != receiver_id)
);

-- 인덱스
CREATE INDEX idx_friendships_requester ON friendships(requester_id);
CREATE INDEX idx_friendships_receiver ON friendships(receiver_id);
CREATE INDEX idx_friendships_status ON friendships(status);

-- RLS 활성화
ALTER TABLE friendships ENABLE ROW LEVEL SECURITY;

-- 본인이 관련된 친구 관계만 조회 가능
CREATE POLICY "friendships_select_own"
    ON friendships FOR SELECT
    USING (
        requester_id = auth.uid() OR receiver_id = auth.uid()
    );

-- 본인이 요청자인 경우만 생성 가능
CREATE POLICY "friendships_insert_own"
    ON friendships FOR INSERT
    WITH CHECK (
        requester_id = auth.uid()
    );

-- 본인이 수신자인 경우 상태 변경 가능 (수락/거절)
CREATE POLICY "friendships_update_receiver"
    ON friendships FOR UPDATE
    USING (
        receiver_id = auth.uid()
    );

-- 본인이 요청자인 경우 삭제 가능 (요청 취소)
CREATE POLICY "friendships_delete_requester"
    ON friendships FOR DELETE
    USING (
        requester_id = auth.uid()
    );

-- 본인이 수신자인 경우에도 삭제 가능 (친구 삭제)
CREATE POLICY "friendships_delete_receiver"
    ON friendships FOR DELETE
    USING (
        receiver_id = auth.uid()
    );
