import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/route_name.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';

routeWriteBottomModalSheetScreen() {
    Get.bottomSheet(
      Container(
        // height: Get.width < 420 ? Get.height / 1.2 : Get.height / .15,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 216, 216, 216),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.images.robotIcon,
                      height: 45,
                      width: 45,
                      colorFilter:
                          const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                   const SizedBox(
                      // width: Get.width / 1.4,
                      child: Text(
                        'مطالب خود را با ما به  اشتراک بگذارید',
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '''
                 همچنین در رویداد کلیک آیکن استفاده کرده‌ایم: (اگر این کار را نکنیم کدها به درستی کار نخواهند کرد و لاگین انجام نمی‌شود.منظور حذف Get.to است.)
                ''',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.routeMangeArticleScreen);
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.icons.writer.path,
                            height: 30,
                            color: Colors.black,
                          ), 
                          const SizedBox(width: 5,),
                          const Text('مدیریت مقاله‌ها', style: TextStyle(fontFamily: 'yekan', fontSize: 20, color: Colors.black),)
                        ],
                      ),
                    ), 
                    Row(
                      children: [
                        Image.asset(
                          Assets.icons.podcast.path,
                          height: 30,
                          color: Colors.black,
                        ), 
                        const SizedBox(width: 5,),
                        const Text('مدیریت پادکست‌ها', style: TextStyle(fontFamily: 'yekan', fontSize: 20, color: Colors.black),)
                      ],
                    ), 
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }