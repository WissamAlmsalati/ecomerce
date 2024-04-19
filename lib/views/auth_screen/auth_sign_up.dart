// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'componets/sign_up_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: const SingleChildScrollView(
        child: SignUpForm(),
      ),
    );
  }
}
