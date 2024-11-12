
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

// launch url
blogLauncherUrl(String url) async{
  var uri = Uri.parse(url);
  if(await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    log('Could not launch $uri');
  }
}

// appBar
PreferredSize appBar(String title) {
    return PreferredSize(
        preferredSize: const Size.fromRadius(40),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text(title, style: appBarTextStyle,),
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: Container(
                // height: 50,
                // width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsBlog.primaryColor.withAlpha(40),
                ),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.keyboard_arrow_right)),
              ),
            ),
          ),
        ),
      );
  }