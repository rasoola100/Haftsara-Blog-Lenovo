import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haftsara_blog/route_manager/binding.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/route_manager/route_name.dart';
import 'package:haftsara_blog/route_manager/pages.dart';
import 'package:haftsara_blog/view/articles/article_manage_screen.dart';
import 'package:haftsara_blog/view/articles/article_single_screen.dart';
import 'package:haftsara_blog/view/articles/single_manage_article_screen.dart';
import 'package:haftsara_blog/view/home_screen.dart';
import 'package:haftsara_blog/view/podcasts/podcast_list_screen.dart';
import 'package:haftsara_blog/view/podcasts/podcast_single_screen.dart';
import 'package:haftsara_blog/view/splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: ColorsBlog.primaryColor));
  await GetStorage.init();
  runApp(const HaftsaraBlog());
}

class HaftsaraBlog extends StatelessWidget {
  const HaftsaraBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('fa'),
      debugShowCheckedModeBanner: false,
      // initialBinding: RegisterBinding(),
      initialRoute: RouteName.routeInitialRoute,
      getPages: Pages.pages,
      // theme: ThemeData(primaryColor: Colors.green),
      home: const SplashScreen(),
      // home: PodcastSingleScreen(),
      // home:  ArticleListScreen(title: 'فهرست مقالات',),
      theme: ThemeData(
        // appBarTheme: Theme.of(context).appBarTheme.copyWith(color: Colors.purple),
        appBarTheme: const AppBarTheme(
          shadowColor: Color.fromARGB(255, 206, 205, 205),
          surfaceTintColor: ColorsBlog.primaryColor,
          //  systemOverlayStyle: SystemUiOverlayStyle.dark
        ),
        fontFamily: 'bNazanin',
        textTheme: const TextTheme(
          labelSmall: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            fontSize: 19,
            color: Color.fromARGB(255, 54, 54, 54),
          ),
          labelMedium:
              TextStyle(fontFamily: 'yekan', fontSize: 20, color: Colors.white),
          titleMedium: TextStyle(
              fontFamily: 'yekan',
              color: ColorsBlog.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w700),
          titleSmall: TextStyle(
              fontFamily: 'yekan',
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: 20,
              fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(
              fontFamily: 'yekan',
              color: Color.fromARGB(255, 71, 70, 70),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color.fromARGB(255, 179, 179, 179);
              }
              return const Color.fromARGB(255, 207, 207, 207);
            }),
            shape: WidgetStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
      ),
    );
  }
}
