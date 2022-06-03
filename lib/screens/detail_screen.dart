import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constant/colors.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/model_class/api_model.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.articles}) : super(key: key);

  final Articles articles;
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  HomeController controller = Get.find();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: buttonColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: (){
                launch(widget.articles.url ?? "");
              },
                child: const Icon(Icons.open_in_browser)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "openImage",
                child: CachedNetworkImage(
                    imageUrl: widget.articles.urlToImage ?? "" ),
              ),
              const SizedBox(height: 10,),
              Text(widget.articles.publishedAt ?? "",
                style: const TextStyle(
                    color: Colors.white
                ),),
              const SizedBox(height: 10,),
              Text(widget.articles.author ?? "",
                style: const TextStyle(
                    color: Colors.white,
                  fontWeight: FontWeight.bold
                ),),
              const SizedBox(height: 10,),
              Text(widget.articles.title ?? "",
                style: const TextStyle(
                    color: Colors.white
                ),),
              const SizedBox(height: 10,),
              Text(widget.articles.description ?? "",
              style: const TextStyle(
                color: Colors.white
              ),),
              const SizedBox(height: 10,),
              Text(widget.articles.content ?? "",
                style: const TextStyle(
                    color: Colors.white
                ),),
              const SizedBox(height: 10,),
              Text(widget.articles.source?.name ?? "",
                style: const TextStyle(
                    color: Colors.white,
                  fontWeight: FontWeight.bold
                ),),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  launch(widget.articles.url ?? "");
                },
                child: Text(widget.articles.url ?? "",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
