import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app/constant/colors.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/controller/login_controller.dart';
import 'package:news_app/screens/home_screen.dart';

class FillDetails extends StatefulWidget {
  const FillDetails({Key? key}) : super(key: key);

  @override
  _FillDetailsState createState() => _FillDetailsState();
}

class _FillDetailsState extends State<FillDetails> {

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Expanded(
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      child: Text(
                        "Details",
                        style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Name"),
                    ),
                    getTextField(
                        hintText: "Enter your Name",
                    controller: controller.nameController),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: ButtonTheme(
                        buttonColor: buttonColor,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.validateDetails();
                            },
                            child: const Text("Log In")),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextField({required hintText, required controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
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
}
