part of 'user_contoler_cubit.dart';

@immutable
sealed class UserContolerState {}

final class UserContolerInitial extends UserContolerState {}

final class UserContolerLoading extends UserContolerState {}

final class UserContolerSuccess extends UserContolerState {
  final AppUser userModule;

  UserContolerSuccess(this.userModule);
}

final class UserContolerFaild extends UserContolerState {
  final String error;

  UserContolerFaild(this.error);
}
