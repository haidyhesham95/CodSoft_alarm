part of 'alarm_cubit.dart';

@immutable
abstract class AlarmState {}

class AlarmInitial extends AlarmState {
  AlarmInitial() : super();
}
class GetDay extends AlarmState {}
class AlarmTimePicked extends AlarmState {}
class AlarmSaving extends AlarmState {}
class AlarmSaved extends AlarmState {}
class AlarmUpdated extends AlarmState {}
class AlarmSaveError extends AlarmState {

}


