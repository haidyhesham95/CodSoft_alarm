
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../manager/real_time/real_time_cubit.dart';



class Realtime extends StatelessWidget {
  const Realtime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RealtimeCubit(),
      child: Column(
        children: [
          BlocBuilder<RealtimeCubit, DateTime>(
            builder: (context, currentTime) {
              String formattedTime = DateFormat('hh:mm:ss a').format(currentTime);
              return Text(
                formattedTime,
                style: Theme.of(context).textTheme.headlineLarge,
              );
            },
          ),
        ],
      ),
    );
  }
}