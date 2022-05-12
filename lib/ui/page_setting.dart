import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/scheduling_provider.dart';

class RestaurantSettingPage extends StatefulWidget {
  static const routeName = '/setting_page';
  const RestaurantSettingPage({Key? key}) : super(key: key);

  @override
  _RestaurantSettingPageState createState() => _RestaurantSettingPageState();
}

class _RestaurantSettingPageState extends State<RestaurantSettingPage> {
  String counterNumberPrefs = 'counterNumber';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      body: _buildList(context),
    );
  }


  Widget _buildList(BuildContext context){
    return ListTile(
        title: const Text('Notifications Restaurant'),
        trailing:
        Consumer<SchedulingProvider>(builder: (context, scheduled, _) {
          return Switch.adaptive(
            value: scheduled.isScheduled,
            onChanged: (value) async {
              scheduled.enableDailyRestaurant(value);
              scheduled.scheduledRestaurant(value);
            },
          );
        }));
  }
}
