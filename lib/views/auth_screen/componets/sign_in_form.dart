import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:recipes/views/auth_screen/auth_sign_up.dart';
import 'package:recipes/views/screens_body.dart';
import '../../../constance.dart';
import '../../../moudels/user/user_repository.dart';
import 'coustome_text_filed.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Constans constans = Constans(context);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(children: [
          Text("Sign in", style:  TextStyle(fontSize: constans.width * 0.06)),
          const SizedBox(height: 10),
          Text(
              "Fill your information below or \nlogin with social media",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: constans.width*0.025, color: constans.black.withOpacity(0.7))),
          const SizedBox(
            height: 40,
          ),
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

          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: constans.height * 0.06,
            width: constans.width * 0.9,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(constans.brown),
                // change this color to your desired color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await UserRepository.SignIn(
                      emailController.text,
                      passwordController.text,

                    );
                    if (kDebugMode) {
                      print("Validated");
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreensBody()));
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text('Sign Up Failed'),
                          content: Text("email or password is incorrect"),
                        );
                      },
                    );
                  }
                }
              },
              child: Text(
                "Log in ",
                style: TextStyle(color: constans.white,fontSize: constans.width * 0.03),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.2),
                    height: 50,
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'or log in with',
                    style: TextStyle(color: Colors.black,fontSize: constans.width * 0.03),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.2),
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlutterSocialButton(
                  onTap: () {},
                  mini: true, //just pass true for mini circle buttons
                  buttonType: ButtonType
                      .apple, // Button type for different type buttons
                ),
                FlutterSocialButton(
                  onTap: () {},
                  mini: true, //just pass true for mini circle buttons
                  buttonType: ButtonType
                      .google, // Button type for different type buttons
                ),
                FlutterSocialButton(
                  onTap: () {},
                  mini: true, //just pass true for mini circle buttons
                  buttonType: ButtonType
                      .facebook, // Button type for different type buttons
                ),
              ],
            ),

          ),

          const SizedBox(
            height: 30,
          ),


          Text.rich(TextSpan(
            style: TextStyle(fontSize: constans.width*0.03),
            text: 'Dont have an account? ',
            children: [
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(fontSize: constans.width*0.03,color: constans.brown ,decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
              ),
            ],
          )),
        ]),
      ),
    );
  }
}
