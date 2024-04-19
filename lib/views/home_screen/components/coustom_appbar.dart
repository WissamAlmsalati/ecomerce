import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipes/moudels/user/user_module.dart';
import 'package:recipes/moudels/user/user_repository.dart';
import '../../../constance.dart';

class CoustomAppBar extends StatelessWidget {
  const CoustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final constans = Constans(context);
    return FutureBuilder<AppUser?>(
      future: UserRepository.getCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.only(
                left: constans.smallWidth, right: constans.smallWidth, top: 10.0, bottom: 10.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${snapshot.data!.name}", style: TextStyle(fontSize: constans.height * 0.02)),
                    Row(
                      children: [
                        Icon(Iconsax.location5, color: constans.brown,size: constans.height*0.02,),
                         Text("Location",style: TextStyle(fontSize: constans.height*0.01),)
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  width: 45.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: constans.white,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.notification1),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('No user found');
        }
      },
    );
  }
}