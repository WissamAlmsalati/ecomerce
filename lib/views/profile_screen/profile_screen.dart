import 'package:flutter/material.dart';
import 'package:recipes/moudels/user/user_repository.dart';

import '../auth_screen/auth_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     UserController userRepository = UserController();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            userRepository.logout();
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()));
    }, child: const Text('Sign Out')
          )
        ],
      )
    );
  }
}
