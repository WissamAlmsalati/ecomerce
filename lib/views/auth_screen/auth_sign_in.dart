import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controlers/user_controler/cubit/user_contoler_cubit.dart';
import 'componets/sign_in_form.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body:  SingleChildScrollView(
        child: BlocProvider(create: (BuildContext context) {
          return UserContolerCubit();
        },
        child: const SignInForm()),
      ),
    );
  }
}