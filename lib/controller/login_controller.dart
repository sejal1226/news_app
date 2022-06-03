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



  saveDetails()async{
    DateTime now =DateTime.now();
    FirebaseFirestore.instance.collection('userDetails').add({
      'userName' : nameController.text,
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
    }else {
      MyUtils.showLoading();
      await saveDetails();

    }
  }
}