import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/constant/colors.dart';
import 'package:news_app/controller/login_controller.dart';
import 'package:news_app/myutils/my_utils.dart';
import 'package:news_app/screens/otp_screen.dart';
import 'package:news_app/screens/registration_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 56.h,
                ),
                Text(
                  "Sign Up to Breaking News",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: lightTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const FillDetails());
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                getTextField(controller: controller.mobileController),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      color: lightTextColor,
                    )),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      "Or sign up via",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: lightTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    const Expanded(
                        child: Divider(
                      color: lightTextColor,
                    )),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () async {
                        await signInWithGoogle();
                        setState(() {});
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.redAccent)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/google.png",
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Text("Google"),
                        ],
                      )),
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: twitterColor)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(twitterColor),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/twitter.png",
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Text("Twitter"),
                        ],
                      )),
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: fbColor)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(fbColor),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/facebook.png",
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Text("Facebook"),
                        ],
                      )),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "By Signing up to Breaking News you agree to our ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: lightTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //policy page will be navigate here
                      },
                      child: Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () async {
                        MyUtils.showLoading();
                        Get.back();
                        await navigateToOtpScreen();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(buttonColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      ),
                      child: const Text("Login")),
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextField({required controller}) {
    return TextField(
      maxLength: 10,
      keyboardType: TextInputType.phone,
      controller: controller,
      decoration: InputDecoration(
          hintText: "Sign up with Mobile Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          filled: true,
          fillColor: textFieldColor,
          prefix: Text("+91 "),
          prefixStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: lightTextColor),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          )),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  navigateToOtpScreen() async {
    if (controller.mobileController.text.trim().isEmpty) {
      MyUtils.showErrorSnackBar('Please enter your mobile number');
    } else if (controller.mobileController.text.trim().length != 10 ||
        !controller.mobileController.text.isPhoneNumber) {
      MyUtils.showWarningSnackBar('Mobile Number is Invalid');
    } else if (!await controller.validateMobile()) {
      MyUtils.showInfoSnackBar('Mobile Does not Exist');
    } else {
      MyUtils.showLoading();
      controller.insertOtp().whenComplete(() {
        Get.back();
        Get.to(() => const OTPScreen(
              isLoginScreen: true,
            ));
      });
    }
  }
}
