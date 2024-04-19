import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes/moudels/user/user_repository.dart';

import '../auth_screen/auth_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            UserRepository.SignOut();
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
    }, child: const Text('Sign Out')
          )
        ],
      )
    );
  }
}
