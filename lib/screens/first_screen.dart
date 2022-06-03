import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constant/colors.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/model_class/api_model.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SafeArea(
          child: controller.isLoading.value
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 5),
                child: Text(
                  "Hi, ${controller.name}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Explore daily news here!",
                  style: TextStyle(color: lightTextColor, fontSize: 16),
                ),
              ),
              const Divider(
                color: lightTextColor,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: controller.object.articles?.length,
                    itemBuilder: (context, i) {
                      Articles articles = controller.object.articles![i];

                      return  GestureDetector(
                        onTap: () {
                          Get.to(() =>  DetailScreen(articles: articles,));
                        },
                        child: Card(
                          color: Colors.white12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              if (articles.urlToImage != null && (
                                  articles.urlToImage?.isNotEmpty ?? false
                              ))
                                Hero(
                                  tag: "openImage",
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: articles.urlToImage ?? "",
                                      ),
                                      Positioned(
                                        right: 10,
                                        child: IconButton(
                                          onPressed: (){
                                            if(controller.sp.containsKey(articles.title ?? "")){
                                              controller.sp.remove(articles.title ?? "");
                                            }else{
                                              controller.sp.setString(articles.title ??"", articles.description ?? "");
                                            }
                                            setState(() {

                                            });
                                          },
                                          icon: Icon(controller.sp.containsKey(articles.title ?? "")?Icons.star:Icons.star_border,color: buttonColor,size: 40,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                articles.title ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                articles.author ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
