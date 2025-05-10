import 'package:shared_preferences/shared_preferences.dart';

class StepTracker {
// Current day's step count, displayed in the UI
int _todaySteps = 0;
// Baseline step count from the start of the day or last reset
int _baselineSteps = 0;
// Timestamp of the last daily reset
DateTime _lastReset = DateTime.now();

Future<void> initSteps() async {
  final prefs = await SharedPreferences.getInstance();//to load last baseline and today steps
  _baselineSteps = prefs.getInt('baseline_steps') ?? 0;
  _lastReset = DateTime.fromMillisecondsSinceEpoch(
      prefs.getInt('last_reset') ?? DateTime.now().millisecondsSinceEpoch);
  if (!_isSameDay(_lastReset, DateTime.now())) {
    _baselineSteps = 0;
    _lastReset = DateTime.now();
    await prefs.setInt('baseline_steps', _baselineSteps);
    await prefs.setInt('last_reset', _lastReset.millisecondsSinceEpoch);
  }
}


//will calculate the steps useing subtracting baseline and today steps
void updateSteps(int totalSteps) async {
  final prefs = await SharedPreferences.getInstance();//for data
  _todaySteps = totalSteps - _baselineSteps;
  if (_todaySteps < 0) _todaySteps = 0;
  await prefs.setInt('baseline_steps', totalSteps);
}

bool _isSameDay(DateTime a, DateTime b) { //tocheck tofay date and last reset
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
int get todaySteps => _todaySteps;
}