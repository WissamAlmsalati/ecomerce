import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constance.dart';

class CoustomAppBar extends StatelessWidget {
  const CoustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final constans = Constans(context);
    return Padding(
      padding:  EdgeInsets.only(
          left:constans.smallWidth, right:constans.smallWidth, top: 10.0, bottom: 10.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("User Name", style: TextStyle(fontSize: 20) )   ,
              Row(
                children: [
                  Icon(Iconsax.location5, color: constans.brown),
                  const Text("Location")
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
  }
}
