import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../moudels/user/user_module.dart';

part 'user_contoler_state.dart';

class UserContolerCubit extends Cubit<UserContolerState> {
  UserContolerCubit() : super(UserContolerInitial());
}
