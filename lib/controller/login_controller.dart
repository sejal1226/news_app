import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app/myutils/my_utils.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();

 String userEmail = "";

  saveDetails()async{
    DateTime now =DateTime.now();
    FirebaseFirestore.instance.collection('userDetails').add({
      'userName' : nameController.text,
      'mobile': mobileController.text,
      'created': now.millisecondsSinceEpoch,
      'enteredDate': now,
    }).whenComplete(() async{
      GetStorage storage = GetStorage();
      storage.write("name", nameController.text);
      Get.offAll(() => const HomeScreen());
    });
  }
  validateDetails()async{
    if(nameController.text.isEmpty){
      MyUtils.showErrorSnackBar("Please enter your name");
    }else if(mobileController.text.isEmpty){
      MyUtils.showErrorSnackBar("Please enter your mobile number");
    }else if(!mobileController.text.isPhoneNumber || mobileController.text.length !=10){
      MyUtils.showWarningSnackBar("Incorrect Mobile Number");
    }else {
      MyUtils.showLoading();
      await saveDetails();

    }
  }

  Future<bool> validateMobile() async {
    bool value;
    QuerySnapshot s = await FirebaseFirestore.instance
        .collection('userDetails')
        .where('mobile', isEqualTo: mobileController.text)
        .get();
    if (s.docs.isEmpty) {
      value = false;
    } else {
      value = true;
    }
    print(value);
    return value;
  }

  Future<void> insertOtp() async {
    FirebaseFirestore.instance.collection('Otp').add({
      'mobile': mobileController.text,
      'otp': '1234',
      'status': 'notVerified'
    });
  }
}