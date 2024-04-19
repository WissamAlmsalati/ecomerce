import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:recipes/views/screens_body.dart';
import '../../../constance.dart';
import '../../../moudels/user/terms&conditions.dart';
import '../../../moudels/user/user_repository.dart';
import '../../../preferences.dart';
import '../auth_sign_in.dart';
import 'coustome_text_filed.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Constans constant = Constans(context);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(children: [
          Text("Create Account",
              style: TextStyle(fontSize: constant.width * 0.07)),
          const SizedBox(height: 10),
          Text("Fill your information below or \nregister with social media",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: constant.width * 0.025,
                  color: constant.black.withOpacity(0.7))),
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
            controller: nameController,
            keyboardType: TextInputType.name,
            valdatorText: 'Enter Your name',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: true,
                  activeColor: constant.brown,
                  checkColor: constant.white,
                  onChanged: (value) {}),
              Text.rich(TextSpan(
                text: 'Agree With ',
                style: TextStyle(
                  fontSize: constant.width * 0.03,
                  color: constant.black,
                ),
                children: [
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: TextStyle(
                        fontSize: constant.width * 0.03,
                        color: constant.brown,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsConditions(),
                          ),
                        );
                      },
                  ),
                ],
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: constant.height * 0.06,
            width: constant.width * 0.9,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(constant.brown),
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
                    await UserRepository.SignUp(
                      emailController.text,
                      passwordController.text,
                      phoneController.text,
                      nameController.text,
                      context,
                    );
                    UserPreferences().saveUserLoggedIn(true);
                    Get.to(
                      () => const ScreensBody(),
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Sign Up Failed'),
                          content: Text("email or password is incorrect"),
                        );
                      },
                    );
                  }
                }
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: constant.white,
                  fontSize: constant.width * 0.03,
                ),
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
                    'or sign up with',
                    style: TextStyle(
                        color: Colors.black, fontSize: constant.width * 0.03),
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
            text: 'Already Have Account? ',
            style: TextStyle(
              fontSize: constant.width * 0.03,
              color: constant.black,
            ),
            children: [
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                    fontSize: constant.width * 0.03,
                    color: constant.brown,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.to(
                      () => const SignIn(),
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
