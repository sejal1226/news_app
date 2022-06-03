import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/model_class/api_model.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: controller.sp.getKeys().isEmpty?Center(
        child: Text("Kucho nh hai ",style: TextStyle(color: Colors.white),),
      ):ListView.builder(
        itemCount: controller.object.articles?.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context,i){
          Articles articles=controller.object.articles![i];
          if(controller.sp.containsKey(controller.object.articles![i].title ?? "")){
            return Card(
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
                          // Positioned(
                          //   right: 10,
                          //   child: IconButton(
                          //     onPressed: (){
                          //       if(controller.sp.containsKey(controller.object.articles!.title ?? "")){
                          //         controller.sp.remove(articles.title ?? "");
                          //       }else{
                          //         controller.sp.setString(articles.title ??"", articles.description ?? "");
                          //       }
                          //       setState(() {
                          //
                          //       });
                          //     },
                          //     icon: Icon(controller.sp.containsKey(articles.title ?? "")?Icons.star:Icons.star_border,color: buttonColor,size: 40,),
                          //   ),
                          // )
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
            );
          }
          else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
