import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constant/colors.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/model_class/api_model.dart';
import 'package:news_app/screens/bookmark_screen.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:news_app/screens/first_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreference/sharedpreference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  PageController pageController =PageController();
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: PageView(
        controller: pageController,
        children: [
          FirstScreen(),
          BookmarkScreen()
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BottomNavigationBar(
          onTap: (value) {
            pageController.jumpToPage(value);
            selectedIndex=value;
            setState(() {

            });
          },
          currentIndex: selectedIndex,
          selectedItemColor: buttonColor,
          unselectedItemColor: lightTextColor,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.newspaper,
                ),
                label: 'News'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Bookmarked'),
          ],
        ),
      ),
    );
  }
}
