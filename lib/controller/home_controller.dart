import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app/model_class/api_model.dart';
import 'package:news_app/myutils/my_utils.dart';
import 'package:news_app/provider/provider.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController{

  late ApiModel object;
  String name="";
  RxBool isLoading=true.obs;
  late SharedPreferences sp;

  GetStorage storage = GetStorage();
  @override
  onInit()async{
    super.onInit();
    sp =await SharedPreferences.getInstance();
    name=storage.read("name");
    isLoading.value=true;
    await getApiData();
    isLoading.value=false;
  }

  Future<void> getApiData()async{
    try{
      Map<String, dynamic> map = await Provider().getCall("https://newsapi.org/v2/top-headlines?country=in&apiKey=b7ae980a0d5b48b7b569fba5cb25e531");
      print(map);
      object = ApiModel.fromJson(map);
    }catch(e){
      print(e);
    }
  }

}