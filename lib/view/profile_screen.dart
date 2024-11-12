import 'package:flutter/material.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: Assets.images.avatar.provider(),
                      height: 100,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage(Assets.icons.pen.path),
                      size: 30,
                      color: ColorsBlog.primaryColor,
                    ),
                    const SizedBox(width: 10,),
                    Text('ویرایش تصویر', style: textTheme.titleMedium,)
                  ],
                ),
                const SizedBox(height: 50,),
                Text('رسول امیری', style: textTheme.titleSmall,),
                Text('haftsara@gmail.com', style: textTheme.titleSmall,),

 const SizedBox(height: 30,),
                const Divider(
                  thickness: 1.2,
                  endIndent: 30,
                  indent: 30,
                ),
                 const SizedBox(height: 15,),
                 Text('مقالات مورد علاقه من', style: textTheme.headlineMedium,),
                 const SizedBox(height: 15,),
                  const Divider(
                  thickness: 1.2,
                  endIndent: 30,
                  indent: 30,
                ),
                 const SizedBox(height: 15,),
                 Text('پادکست‌های مورد علاقه من', style: textTheme.headlineMedium,), 
                 const SizedBox(height: 15,),
  
                  const Divider(
                  thickness: 1.2,
                  endIndent: 30,
                  indent: 30,
                ),
                 const SizedBox(height: 15,),
                 Text('خروج از حساب کاربری', style: textTheme.headlineMedium,),

                 const SizedBox(height: 150,),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
