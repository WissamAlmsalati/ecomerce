import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/constance.dart';
import 'package:recipes/views/auth_screen/auth_sign_up.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Constans constans = Constans(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: constans.height * 0.44,
                  width: constans.width * 0.4,
                  decoration: BoxDecoration(
                      color: constans.brown.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(140)),
                ),
                Column(
                  children: [
                    Container(
                      height: constans.height * 0.25,
                      width: constans.width * 0.4,
                      decoration: BoxDecoration(
                        color: constans.brown.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(140),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: constans.height * 0.19,
                      width: constans.width * 0.4,
                      decoration: BoxDecoration(
                        color: constans.brown.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(140),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: constans.width * 0.06,
          ),
          Text.rich(
            textAlign: TextAlign.center, // Add this line
            TextSpan(
              text: 'The',
              style: TextStyle(
                fontSize: constans.width * 0.056,
                color: constans.black,
                fontWeight: FontWeight.w900,
              ),
              children: [
                TextSpan(
                  text: 'Fashion App',
                  style: TextStyle(
                    fontSize: constans.width * 0.06,
                    color: constans.brown,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: "That\n Makes You Look Your Best",
                  style: TextStyle(
                    fontSize: constans.width * 0.06,
                    color: constans.black,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur\nadipiscing elite sed do eiusmod tempor incididunt",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: constans.width * 0.026,
                color: constans.black.withOpacity(0.5)),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: constans.height * 0.42,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  const SignUp(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 390),
                  curve: Curves.easeInOutCubic,
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(constans.brown),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: constans.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text.rich(
            TextSpan(
              text: 'Already have an account?',
              style: TextStyle(
                fontSize: constans.width * 0.03,
                color: constans.black.withOpacity(0.5),
              ),
              children: [
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    fontSize: constans.width * 0.03,
                    color: constans.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OnBoardingScreens extends StatelessWidget {
  const OnBoardingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
