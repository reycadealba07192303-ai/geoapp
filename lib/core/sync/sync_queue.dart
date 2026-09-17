/// Offline → online upload queue for [UserReports].
///
/// workmanager wiring lands when Supabase credentials exist.
class SyncQueue {
  const SyncQueue();

  /// Placeholder: scan unsynced reports and POST when connectivity allows.
  Future<int> flushPending() async {
    return 0;
  }
}
