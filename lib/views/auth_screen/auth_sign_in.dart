import 'package:flutter/material.dart';
import 'package:recipes/moudels/user/user_repository.dart';

import '../home_screen/home_screen.dart';
import 'auth_sign_up.dart';
import 'componets/coustome_text_filed.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    icon: Icons.lock,
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    valdatorText: 'Enter Your Password',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                          },
                          child: const Text("Sign Up"))
                    ],
                  ),

         ElevatedButton(
  onPressed: () async {
    try {
      await UserRepository.SignIn(
        emailController.text, passwordController.text
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign In Failed'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  },
  child: const Text("Sign In"),
)
                ],
              ))
        ],
      ),
    );
  }
}
