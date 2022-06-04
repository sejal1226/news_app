import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constant/colors.dart';
import 'package:news_app/controller/login_controller.dart';
import 'package:news_app/myutils/my_utils.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/registration_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.isLoginScreen}) : super(key: key);

  final bool isLoginScreen;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  LoginController controller = Get.find();

  TextEditingController mobileController = TextEditingController();
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: buttonColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 10),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back,color: Colors.white,)),
              ),
              const Padding(
                 padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                 child: Text('Verify your phone number',style: TextStyle(color: Colors.white),),
               ),
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child:  Text('We sent you a code to verify \nyour phone number',style: TextStyle(color: Colors.white),),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Text(
                  "Sent to +91${controller.mobileController.text}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ),
              _otpField(),
              const Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 120,
                ),
                child: Text('I didn’t receive a code',style: TextStyle(color: Colors.white),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ButtonTheme(
            minWidth: 200,
            height: 50.0,
            buttonColor: buttonColor,
            child: ElevatedButton(
              onPressed: () {
                signIn();
              },
              child: Text("Verify"),
            )),
      ),
    );
  }

  Widget _otpField() {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: PinPut(
          textStyle: TextStyle(color: Colors.white),
          eachFieldHeight: 55,
          eachFieldWidth: 55,
          fieldsCount: 4,
          // onSubmit: (String pin) => _showSnackBar(pin, context),
          focusNode: pinPutFocusNode,
          controller: pinPutController,
          submittedFieldDecoration: _pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(1.0),
          ),

          selectedFieldDecoration: _pinPutDecoration,
          followingFieldDecoration: _pinPutDecoration.copyWith(
            borderRadius: BorderRadius.circular(1.0),
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  signIn() async {
    if (pinPutController.text.trim().length != 4) {
      MyUtils.showErrorSnackBar('Please Enter OTP');
    }
    // else if (await _validateMobile()) {
    //   Get.back();
    //   MyUtils.showInfoSnackBar('Info', 'Mobile Already Exist');
    // }
    else {
      MyUtils.showLoading();
      FirebaseFirestore.instance
          .collection('userOtp')
          .where('mobile', isEqualTo: controller.mobileController.text)
          .where('otp', isEqualTo: pinPutController.text)
          .where('status', isEqualTo: 'notVerified')
          .get()
          .then((QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          Get.back();
          MyUtils.showWarningSnackBar('OTP not matched');
        } else {
          for (var element in snapshot.docs) {
            element.reference
                .update({'status': 'verified'}).whenComplete(() async {
              if (widget.isLoginScreen) {
                QuerySnapshot s = await FirebaseFirestore.instance
                    .collection('userDetails')
                    .where('mobile',
                        isEqualTo: controller.mobileController.text)
                    .get();
                s.docs.forEach((element) async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.setString('name', element.get('name'));
                  sp.setString('mobile', element.get('mobile'));
                  Get.back();
                  Get.delete<LoginController>(force: true);
                  Get.offAll(() => const HomeScreen());
                });
              } else {
                Get.to(() => const FillDetails());
              }
            });
          }
        }
      });
    }
  }
}
