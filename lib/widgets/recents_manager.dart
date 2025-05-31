import '../models/recent_call.dart';

class RecentsManager {
  static final RecentsManager _instance = RecentsManager._internal();
  factory RecentsManager() => _instance;
  RecentsManager._internal();

  final List<RecentCall> _recentCalls = [];

  List<RecentCall> get recentCalls => _recentCalls;

  void addCall(RecentCall call) {
    _recentCalls.insert(0, call); // most recent at top
  }
  void addRawNumber(String number) {
  final rawCall = RecentCall(
    name: 'Unknown',
    number: number,
    imagePath: 'assets/default_avatar.png',
    time: DateTime.now(),
  );
  addCall(rawCall);
}

  void clear() {
    _recentCalls.clear();
  }
}
