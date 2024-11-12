import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/components/route_name.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:haftsara_blog/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  routToHomeScreenAfterSplash(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((onValue) {
      if (context.mounted) {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
        // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) =>  const HomeScreen()));
        Get.offAndToNamed(RouteName.routeHomeScreen);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    routToHomeScreenAfterSplash(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image(
            image: Assets.images.logo.provider(),
            width: 110,
          )),
          const SizedBox(
            height: 25,
          ),
          const SpinKitFadingCircle(
            color: ColorsBlog.primaryColor,
            size: 120,
          ),
        ],
      )),
    );
  }
}
