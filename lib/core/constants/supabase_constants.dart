/// Supabase 설정 상수
class SupabaseConstants {
  SupabaseConstants._();

  // ─── Supabase 연결 정보 ───
  // Supabase 대시보드 → Settings → API 에서 확인
  static const String supabaseUrl = 'https://seawgpunbrnvmxjaseoy.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlYXdncHVuYnJudm14amFzZW95Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA2NDMwOTMsImV4cCI6MjA4NjIxOTA5M30.Eh6mujmVehyNNjOivB1WoITQUHF6pWkMVybfQLQ-07I';

  // ─── 테이블 이름 ───
  static const String tableChurches = 'churches';
  static const String tableProfiles = 'profiles';
  static const String tableLearningPaths = 'learning_paths';
  static const String tableLessons = 'lessons';
  static const String tableQuizzes = 'quizzes';
  static const String tableUserProgress = 'user_progress';
  static const String tableDailyRecords = 'daily_records';
  static const String tableStreaks = 'streaks';
  static const String tableStreakCalendar = 'streak_calendar';
  static const String tableUserGardens = 'user_gardens';
  static const String tableGardenItems = 'garden_items';
  static const String tableQuests = 'quests';
  static const String tableUserQuests = 'user_quests';
  static const String tableAchievements = 'achievements';
  static const String tableUserAchievements = 'user_achievements';

  // ─── Storage 버킷 ───
  static const String bucketAvatars = 'avatars';
  static const String bucketShareCards = 'share_cards';
}
