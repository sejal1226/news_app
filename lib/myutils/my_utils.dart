import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constant/colors.dart';

class MyUtils {
  static void showLoading(){
    Get.defaultDialog(
        title: 'Please Wait',
        radius: 15,
        titleStyle: const TextStyle(
            color: buttonColor,
            fontWeight: FontWeight.bold
        ),
        content: Row(
          children: const [
            CircularProgressIndicator(
              strokeWidth: 2,
              color: buttonColor,),
            SizedBox(width: 20,),
            Text('Loading...',
              style: TextStyle(
                  fontWeight: FontWeight.w600
              ),)
          ],
        ));
  }

  static void showErrorSnackBar( String message){
    Get.snackbar("Error", message,backgroundColor: Colors.white);
  }

  static void showInfoSnackBar( String message){
    Get.snackbar("Info" ,message,backgroundColor: Colors.white);
  }

  static void showWarningSnackBar( String message){
    Get.snackbar("Warning", message,backgroundColor: Colors.white);
  }

  static void showSuccessSnackBar( String message){
    Get.snackbar("Success" , message,backgroundColor: Colors.white);
  }
}