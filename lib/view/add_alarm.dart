import 'package:alarm/alarm.dart';
import 'package:alarm_clock_app/constant/label.dart';
import 'package:alarm_clock_app/view/app_bar.dart';
import 'package:alarm_clock_app/view/label_text.dart';
import 'package:alarm_clock_app/view/sound.dart';
import 'package:alarm_clock_app/view/vibration.dart';
import 'package:alarm_clock_app/view/volume.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/alarm_cubit.dart';

class AddAlarm extends StatelessWidget {

  const AddAlarm({Key? key, this.alarmSettings, })
      : super(key: key);
 final   AlarmSettings? alarmSettings;

  @override
  Widget build(BuildContext context) {
  return  BlocProvider(
      create: (context)=>AlarmCubit(

      ),
      child: BlocConsumer<AlarmCubit, AlarmState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            AlarmCubit cubit = AlarmCubit.get(context);
    return Scaffold(
      appBar:
       appBarAlarm((){
        cubit.saveAlarm();
        Navigator.pop(context);
       }),
      body:
               Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: CupertinoPicker(
                        squeeze: 0.8,
                        diameterRatio: 5,
                        useMagnifier: true,
                        looping: true,
                        itemExtent: 100,
                        scrollController: cubit.hourController,
                        selectionOverlay:
                            const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                          capEndEdge: true,
                        ),
                        onSelectedItemChanged: ((value) {

                            cubit.hour = value + 1;

                          cubit.time();
                        }),
                        children: [
                          for (int i = 1; i <= 12; i++) ...[
                            Center(
                              child: Text(
                                '$i',
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(fontSize: 30),
                    ),
                    Flexible(
                      flex: 1,
                      child: CupertinoPicker(
                        squeeze: 0.8,
                        diameterRatio: 5,
                        looping: true,
                        itemExtent: 100,
                        scrollController: cubit.minuteController,
                        selectionOverlay:
                            const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                          capEndEdge: true,
                        ),
                        onSelectedItemChanged: ((value) {
                            cubit.minute = value;
                            cubit.time();
                        }),
                        children: [
                          for (int i = 0; i <= 59; i++) ...[
                            Center(
                              child: Text(
                                i.toString().padLeft(2, '0'),
                                style: const TextStyle(fontSize:30),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CupertinoPicker(
                        squeeze: 1,
                        diameterRatio: 15,
                        useMagnifier: true,
                        itemExtent: 100,
                        scrollController: cubit.ampmController,
                        selectionOverlay:
                            const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                        ),
                        onSelectedItemChanged: ((value) {
                          if (value == 0) {
                             cubit.amPm = "AM";
                          } else {

                              cubit.amPm = "PM";
                          }
                          cubit.time();
                        }),
                        children: [
                          for (var i in ['am', 'pm']) ...[
                            Center(
                              child: Text(
                                i,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Expanded(
                flex: 1,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          title: Text(cubit.getDay()),
                          trailing: IconButton(
                              onPressed: () => cubit.selectDate(context),
                              icon: const Icon(Icons.calendar_month_outlined)),
                        ),

                        LabelText(data: AppData.label, onChanged: (value) {
                            if (value.isEmpty) {
                              value = "Alarm";
                            }
                            AppData.label = value;
                        },),

                        const Divider(  indent: 10, endIndent: 10 ),

                        Sound(
                            value: cubit.assetAudio,
                            onChanged: (value) { cubit.updateAssetAudio(value); }
                        ),

                        const Divider(  indent: 10, endIndent: 10 ),

                        Vibration(
                            value: cubit.vibrate,
                       onChanged: (value) => cubit.updateVibrate(value) ),


                        const Divider(  indent: 10, endIndent: 10 ),

                        Volume(),

                        const SizedBox( height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

    );
  }));


  }
}
