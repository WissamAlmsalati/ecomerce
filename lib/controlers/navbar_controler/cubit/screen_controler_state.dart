part of 'screen_controler_cubit.dart';

@immutable
sealed class ScreenControlerState {}

final class ScreenControlerInitial extends ScreenControlerState {}

final class ScreenChanged extends ScreenControlerState {
  final int index;
  ScreenChanged(this.index);
}
