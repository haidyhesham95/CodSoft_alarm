
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../generated/assets.dart';
import '../view/add_alarm.dart';





part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit() : super(AlarmInitial());


  static AlarmCubit get(context) => BlocProvider.of(context);


  DateTime selectedDateTime = DateTime.now();


  late TextEditingController controller;

  bool loading = false;



  bool ? creating;
    AlarmSettings? alarmSettings;


   bool loopAudio = true;
  bool vibrate = true;
    double? volume;
   String assetAudio = Assets.arabian;
  int hour = 0;
  int minute = 0;
  String amPm = 'AM';
  FixedExtentScrollController minuteController = FixedExtentScrollController();
  FixedExtentScrollController hourController = FixedExtentScrollController();
  FixedExtentScrollController ampmController = FixedExtentScrollController();

  void updateAssetAudio(String value) {
    assetAudio = value;
    emit(AlarmUpdated());
  }
  void updateVibrate(bool value) {
    vibrate = value;
    emit(AlarmUpdated());
  }

  void updateLoopAudio(bool value) {
    loopAudio = value;
    emit(AlarmUpdated());
  }

  void init() {
    if (alarmSettings == null) {
      creating = true;
      selectedDateTime = DateTime.now().add(const Duration(minutes: 1))
          .copyWith(second: 0, millisecond: 0);
      loopAudio = true;
      vibrate = true;
      volume = null;
      assetAudio = 'assets/arabian.wav';
    } else {
      creating = false;
      selectedDateTime = alarmSettings!.dateTime;
      loopAudio = alarmSettings!.loopAudio;
      vibrate = alarmSettings!.vibrate;
      volume = alarmSettings!.volume;
      assetAudio = alarmSettings!.assetAudioPath;
    }

    int initialMinute = 30;
    minuteController = FixedExtentScrollController(initialItem: selectedDateTime.minute);
    hourController = FixedExtentScrollController(initialItem: selectedDateTime.hour - 1);
    if (selectedDateTime.hour > 12) {
      ampmController = FixedExtentScrollController(initialItem: 1);
    }
  }


  String getDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = selectedDateTime.difference(today).inDays;

    switch (difference) {
      case 0:
        return 'Today - ${DateFormat('EEE, d MMM').format(selectedDateTime)}';
      case 1:
        return 'Tomorrow - ${DateFormat('EEE, d MMM').format(selectedDateTime)}';
      default:
        return DateFormat('EEE, d MMM').format(selectedDateTime);
    }
  }

  Future<void> pickTime(context) async {
    final res = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      context: context,
    );

    if (res != null) {

        final DateTime now = DateTime.now();
        selectedDateTime = now.copyWith(
            hour: res.hour,
            minute: res.minute,
            second: 0,
            millisecond: 0,
            microsecond: 0);
        if (selectedDateTime.isBefore(now)) {
          selectedDateTime = selectedDateTime.add(const Duration(days: 1));
        }
    }
  }

  AlarmSettings buildAlarmSettings() {
    final id = creating == null || creating == true
        ? DateTime.now().millisecondsSinceEpoch % 10000
        : alarmSettings!.id;

     alarmSettings = AlarmSettings(
      id: id,
      dateTime: selectedDateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volume: volume,
      assetAudioPath: assetAudio,
      notificationTitle: 'Alarm example',
      notificationBody: 'Your alarm ($id) is ringing',
    );
    return alarmSettings!;
  }


  void saveAlarm() {
    if (loading) return;
    loading = true;
    Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
      if (res) {
        // Navigator.pop(context);
      }
      loading = false;
    }).catchError((error) {
      print("Error: $error");
      loading = false;
    });
  }

  void time() {
    String timeString =
        "$hour:$minute $amPm"; // Replace this with your time string

    DateTime dateTime = convertStringToDateTime(timeString);

      selectedDateTime = dateTime;
      if (selectedDateTime.isBefore(DateTime.now())) {
        selectedDateTime = selectedDateTime.add(const Duration(days: 1));
      }
     emit(GetDay()) ;
  }

  DateTime convertStringToDateTime(String timeString) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime dateTime = format.parse(timeString);

    DateTime today = DateTime.now();
    dateTime = DateTime(
        today.year, today.month, today.day, dateTime.hour, dateTime.minute);

    return dateTime;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? now = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      currentDate: selectedDateTime,
      lastDate: DateTime(2030, 12, 31),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (now != null) {


        selectedDateTime = now;
        if (selectedDateTime.isBefore(DateTime.now())) {
          selectedDateTime = selectedDateTime.add(const Duration(days: 1));
        }
        emit(GetDay());

    }
  }

}
