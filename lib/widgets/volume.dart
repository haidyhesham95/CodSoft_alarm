import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Volume extends StatefulWidget {
  const Volume({super.key, this.alarmSettings});
  final AlarmSettings? alarmSettings;

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  late double? volume;
  late bool creating;



  void initState() {
    super.initState();
    creating = widget.alarmSettings == null;

    if (creating) {

      volume = null;
    } else {

      volume = widget.alarmSettings!.volume;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text("Volume level"),
          trailing: Switch(
            activeColor: Colors.blue,
            value: volume != null,
            onChanged: (value) =>
                setState(() => volume = value ? 0.5 : null),
          ),
        ),

        SizedBox(
          height: 30,
          child: volume != null
              ? Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  volume! > 0.7
                      ? Icons.volume_up_rounded
                      : volume! > 0.1
                      ? Icons.volume_down_rounded
                      : Icons.volume_mute_rounded,
                ),
                Expanded(
                  child: Slider(
                    activeColor: Colors.blue,

                    value: volume!,
                    onChanged: (value) {
                      setState(() => volume = value);
                    },
                  ),
                ),
              ],
            ),
          )
              : const SizedBox(),
        ),
      ],
    );
  }
}
