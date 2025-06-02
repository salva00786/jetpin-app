// lib/utils/ad_frequency_manager.dart
import 'package:shared_preferences/shared_preferences.dart';

class AdFrequencyManager {
  // Per interstitial generici (es. dopo azioni come salvare recensione)
  static const String _lastGenericInterstitialShowTimeKey = 'last_generic_interstitial_show_time';
  static const int _minIntervalGenericMinutes = 5; // Mostra un ad generico max ogni 5 minuti

  // Per interstitial all'avvio dell'app
  static const String _lastAppLaunchInterstitialShowDateKey = 'last_app_launch_interstitial_show_date';

  /// Controlla se un interstitial generico può essere mostrato
  static Future<bool> canShowGenericInterstitial() async {
    final prefs = await SharedPreferences.getInstance();
    final lastShowTimeMillis = prefs.getInt(_lastGenericInterstitialShowTimeKey) ?? 0;
    final lastShowTime = DateTime.fromMillisecondsSinceEpoch(lastShowTimeMillis);
    
    final canShow = DateTime.now().difference(lastShowTime).inMinutes >= _minIntervalGenericMinutes;
    print("[AdFrequencyManager] Can show generic interstitial? $canShow (Last shown: $lastShowTime)");
    return canShow;
  }

  /// Registra che un interstitial generico è stato mostrato
  static Future<void> recordGenericInterstitialShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastGenericInterstitialShowTimeKey, DateTime.now().millisecondsSinceEpoch);
    print("[AdFrequencyManager] Generic interstitial shown time recorded.");
  }

  /// Controlla se un interstitial all'avvio dell'app può essere mostrato (max una volta al giorno)
  static Future<bool> canShowAppLaunchInterstitialToday() async {
    final prefs = await SharedPreferences.getInstance();
    final lastShowDateString = prefs.getString(_lastAppLaunchInterstitialShowDateKey);
    
    if (lastShowDateString == null) {
      print("[AdFrequencyManager] No record of app launch interstitial shown today. Can show.");
      return true; // Mai mostrato prima
    }
    
    final lastShowDate = DateTime.tryParse(lastShowDateString);
    if (lastShowDate == null) {
      print("[AdFrequencyManager] Invalid date format for app launch interstitial. Can show.");
      return true; // Formato data non valido, meglio mostrarlo
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastShownDay = DateTime(lastShowDate.year, lastShowDate.month, lastShowDate.day);

    final canShow = lastShownDay.isBefore(today);
    print("[AdFrequencyManager] Can show app launch interstitial today? $canShow (Last shown date: $lastShowDate)");
    return canShow;
  }

  /// Registra che un interstitial all'avvio dell'app è stato mostrato oggi
  static Future<void> recordAppLaunchInterstitialShownToday() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final todayDateString = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    await prefs.setString(_lastAppLaunchInterstitialShowDateKey, todayDateString);
    print("[AdFrequencyManager] App launch interstitial shown date recorded for: $todayDateString");
  }
}