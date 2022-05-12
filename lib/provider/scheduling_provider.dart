import 'package:flutter/cupertino.dart';
import 'package:restaurantapp/utils/date_time_restaurant.dart';
import 'package:restaurantapp/utils/background_service_restaurant.dart';
import 'package:restaurantapp/utils/preferences_helper_restaurant.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = true;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Restaurant is Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurant is Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  PreferencesHelper preferencesHelper;

  SchedulingProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreference();
  }

  void _getDailyRestaurantPreference() async {
    _isScheduled = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    scheduledRestaurant(value);
    _getDailyRestaurantPreference();
  }
}
