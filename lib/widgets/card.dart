// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class Card extends StatelessWidget {
//   const Card({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//      return GestureDetector(
//       onTap: () => navigateToAlarmScreen(alarms[index]),
//       child: Slidable(
//           closeOnScroll: true,
//           endActionPane: ActionPane(
//               extentRatio: 0.4,
//               motion: const ScrollMotion(),
//               children: [
//                 SlidableAction(
//                   onPressed: (context) {
//                     Alarm.stop(alarm.id);
//                     loadAlarms();
//                   },
//                   icon: Icons.delete_forever,
//                   backgroundColor: Colors.transparent,
//                   foregroundColor: Colors.red.shade400,
//                 )
//               ]),
//           child:
//           Card(
//             child: ListTile(
//               title: Text(
//                 "${_hour(time)[0]}:${time.minute.toString().padLeft(2, '0')} ${_hour(time)[1]}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               subtitle: Text(
//                 labelText + " , " + formattedDate.toString(),
//               ),
//               trailing: Switch(
//                 activeColor: Colors.blue,
//                 value: _alarmOnOff[index],
//                 onChanged: (bool value) {
//                   if (value == false) {
//                     Alarm.set(
//                         alarmSettings: alarm.copyWith(
//                             dateTime: alarm.dateTime.copyWith(year: 2050)));
//                   } else {
//                     Alarm.set(
//                         alarmSettings: alarm.copyWith(
//                             dateTime: alarm.dateTime
//                                 .copyWith(year: DateTime.now().year)));
//                   }
//                   setState(() {
//                     _alarmOnOff[index] = value;
//                   });
//                 },
//               ),
//             ),
//           )
//
//       ),
//
//     );
//   }
// }
