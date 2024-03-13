import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm_clock_app/view/notification.dart';
import 'package:alarm_clock_app/view/real_time.dart';


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Model/Model.dart';
import 'add_alarm.dart';
import '../constant/label.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key, }) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late List<AlarmSettings> alarms;
  List<bool> _alarmOnOff = [];
  List<Model> modelist=[];
  String labelText = AppData.label;


  late TextEditingController controller;



  static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();
    if (Alarm.android) {
      checkAndroidNotificationPermission();
    }
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      for (int i = 0; i < alarms.length; i++) {
        if (alarms[i].dateTime.year == 2050) {
          _alarmOnOff.add(false);
        } else {
          _alarmOnOff.add(true);
        }
      }
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    });
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => notification(alarmSettings: alarmSettings),
        )
        );
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddAlarm(
                  alarmSettings: settings,
                )));

    if (res != null && res == true) loadAlarms();
  }

  Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      alarmPrint('Requesting notification permission...');
      final res = await Permission.notification.request();
      alarmPrint(
        'Notification permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }

  Future<void> checkAndroidExternalStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isDenied) {
      alarmPrint('Requesting external storage permission...');
      final res = await Permission.storage.request();
      alarmPrint(
        'External storage permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Alarm ' ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,

        shape: CircleBorder(),
        onPressed: () => navigateToAlarmScreen(null),

        child: const Icon(Icons.add),
      ),
      body: Column(
      children: [
        SizedBox(
          height: 5,
        ),
      Card(
        elevation: 10,
        color: Colors.black.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
        child: Lottie.asset(
          'assets/alarm.json',
          height: 250,
        ),
      ),

      const SizedBox(height: 15),
      const Center(child: Realtime()),
        SizedBox(
          height: 5,
        ),
        Text(
          DateFormat.yMEd().format(
            DateTime.now(),
          ),
          style: TextStyle(
            fontSize: 19,
          ),
        ),

      const SizedBox(height: 40),
      alarms.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  return _buildAlarmCard(alarms[index], index);
                },
              ),
            )
          : Expanded(
              child: Center(
                child: Text(
                  "No alarms set",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
      ],
      ),
    );
  }

  List<String> _hour(TimeOfDay time) {
    int hour = 0;
    String ampm = 'am';
    if (time.hour > 12) {
      hour = time.hour - 12;
      ampm = 'pm';
    } else if (time.hour == 0) {
      hour = 12;
    } else {
      hour = time.hour;
      ampm = 'am';
    }

    return [hour.toString().padLeft(2, '0'), ampm];
  }

  Widget _buildAlarmCard(AlarmSettings alarm, int index) {
    TimeOfDay time = TimeOfDay.fromDateTime(alarm.dateTime);
    String formattedDate = DateFormat('EEE, d MMM').format(alarm.dateTime);
    return GestureDetector(
      onTap: () => navigateToAlarmScreen(alarms[index]),
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
            extentRatio: 0.4,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Alarm.stop(alarm.id);
                  loadAlarms();
                },
                icon: Icons.delete_forever,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.red.shade400,
              )
            ]),
        child:
        Card(
            child: ListTile(
              title: Text(
                "${_hour(time)[0]}:${time.minute.toString().padLeft(2, '0')} ${_hour(time)[1]}",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                labelText + " , " + formattedDate.toString(),
              ),
                trailing: Switch(
                  activeColor: Colors.blue,
                  value: _alarmOnOff[index],
                  onChanged: (bool value) {
                    if (value == false) {
                      Alarm.set(
                          alarmSettings: alarm.copyWith(
                              dateTime: alarm.dateTime.copyWith(year: 2050)));
                    } else {
                      Alarm.set(
                          alarmSettings: alarm.copyWith(
                              dateTime: alarm.dateTime
                                  .copyWith(year: DateTime.now().year)));
                    }
                    setState(() {
                      _alarmOnOff[index] = value;
                    });
                  },
                ),
          ),
            )

        ),

    );
  }
}


