import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class notification extends StatelessWidget {

  const notification({Key? key, required this.alarmSettings})
      : super(key: key);  final AlarmSettings alarmSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "You alarm is ringing...",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const RippleAnimation(
              color: Colors.black,
              delay: Duration(milliseconds: 300),
              repeat: true,
              minRadius: 75,
              ripplesCount: 6,
              duration: Duration(milliseconds: 6 * 300),
              child: Icon(Icons.alarm, color: Colors.blue, size: 150,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RawMaterialButton(
                  onPressed: () {
                    final now = DateTime.now();
                    Alarm.set(
                      alarmSettings: alarmSettings.copyWith(
                        dateTime: DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                          now.minute,
                          0,
                          0,
                        ).add(const Duration(minutes: 1)),
                      ),
                    ).then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "Snooze",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    Alarm.stop(alarmSettings.id)
                        .then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "Stop",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
