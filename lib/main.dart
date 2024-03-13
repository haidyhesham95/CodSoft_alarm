

import 'package:alarm/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'manager/alarm_cubit.dart';
import 'view/alarm_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Alarm.init(showDebugLogs: true);

  runApp( MaterialApp(
             debugShowCheckedModeBanner: false,
                     darkTheme: ThemeData.dark(),
                 themeMode: ThemeMode.dark,
             theme: ThemeData(
                 useMaterial3: true,
                 colorScheme: ColorScheme.fromSeed(
                     seedColor: Colors.blue, brightness: Brightness.dark)),
             home: const AlarmPage(),
           ),

  );
}
