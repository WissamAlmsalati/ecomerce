import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recipes/moudels/user/user_repository.dart';
import 'package:recipes/views/home_screen/home_screen.dart';

import '../../moudels/user/user_module.dart';
import 'auth_otp.dart';
import 'auth_sign_in.dart';
import 'componets/coustome_text_filed.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading : false,
      ),
      body: Column(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CoustomTextField(
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                    icon: Icons.mail,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    valdatorText: 'Enter Your Email',
                  ),
                  CoustomTextField(
                    labelText: 'Phone',
                    hintText: 'Enter Your Phone',
                    icon: Icons.phone,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    valdatorText: 'Enter Your Phone',
                  ),
                  CoustomTextField(
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    icon: Icons.lock,
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    valdatorText: 'Enter Your Password',
                  ),
                  CoustomTextField(
                    labelText: 'name',
                    hintText: 'Enter Your name',
                    icon: Icons.person,
                    obscureText: true,
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    valdatorText: 'Enter Your name',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                          TextSpan(text: 'Already have an account?', children: [
                        TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignIn()));
                              })
                      ]))
                    ],
                  ),
          ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      try {
        await UserRepository.SignUp(
          emailController.text,
          passwordController.text,
          phoneController.text,
          nameController.text
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen())
        );
        print("Validated");
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Sign Up Failed'),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  },
  child: const Text("Sign Up"),
)
                ],
              ))
        ],
      ),
    );
  }
}
