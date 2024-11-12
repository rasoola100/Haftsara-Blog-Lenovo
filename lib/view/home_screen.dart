import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/components/helper.dart';
import 'package:haftsara_blog/components/strings_blog.dart';
import 'package:haftsara_blog/controllers/register_controller.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:haftsara_blog/view/home_body_screen.dart';
import 'package:haftsara_blog/view/profile_screen.dart';
import 'package:haftsara_blog/view/users/register_screen.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

RegisterController registerController = Get.put(RegisterController());

class _HomeScreenState extends State<HomeScreen> {
final GlobalKey<ScaffoldState> _key = GlobalKey();
  RxInt selectedPageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 5,
        title: Container(
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _key.currentState?.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  size: 40,
                ),
              ),
              Image(
                image: Assets.images.logo.provider(),
                height: 35,
              ),
              const Icon(
                Icons.search,
                size: 35,
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            SizedBox(
              height: screenSize.width < 480
                  ? screenSize.height / 3.3
                  : screenSize.height / 1.8,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: ColorsBlog.primaryColor,
                  ),
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: ColorsBlog.primaryColor,
                    ),
                    accountName: Text(
                      'رسول امیری',
                      style: textTheme.labelSmall,
                    ),
                    accountEmail: Text(
                      'rasoola20@gmail.com',
                      style: textTheme.labelSmall,
                    ),
                    currentAccountPictureSize: const Size.square(60),
                    currentAccountPicture: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(
                            "R",
                            style: textTheme.titleSmall,
                          )),
                    ),
                  )),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                size: 32,
              ),
              title: Text(
                'پروفایل من',
                style: textTheme.titleSmall,
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.article,
                size: 32,
              ),
              title: Text(
                'مقالات محبوب',
                style: textTheme.titleSmall,
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.mic,
                size: 32,
              ),
              title: Text(
                ' پادکست‌های محبوب',
                style: textTheme.titleSmall,
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add,
                size: 32,
              ),
              title: Text(
                'دعوت دوستان',
                style: textTheme.titleSmall,
              ),
              onTap: () async{
                await Share.share(StringsBlog.txtShareBlog);
                
              } 
            ),
            ListTile(
              leading: const Icon(
                Icons.code,
                size: 32,
              ),
              title: Text(
                'گیت‌هاب',
                style: textTheme.titleSmall,
              ),
              onTap: () => blogLauncherUrl('https://www.haftsara.ir'),
            ),
            ListTile(
              leading: const Icon(
                Icons.assignment_late,
                size: 32,
              ),
              title: Text(
                'درباره ما',
                style: textTheme.titleSmall,
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 32,
              ),
              title: Text(
                'خروج از برنامه',
                style: textTheme.titleSmall,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Stack(children: [
        Obx(
          () => IndexedStack(
            index: selectedPageIndex.value,
            children: [
              HomeBodyScreen(screenSize: screenSize, textTheme: textTheme),
              const ProfileScreen(),
               RegisterScreen()
            ],
          ),
        ),

        // bottom navigation-------------------------------
        Positioned(
          left: 0,
          right: 0,
          bottom: 5,
          child: Container(
            height: 80,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: ColorsBlog.bottomNavBgGradientColor,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
              child: Container(
                // height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                        colors: ColorsBlog.bottomNavGradientColor,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => {
                        selectedPageIndex.value = 0,
                      },
                      child: ImageIcon(
                        AssetImage(Assets.icons.homeIcon.path),
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // selectedPageIndex.value = 1;
                        // TODO check login user
                        registerController.checkLogin();
                        // Get.find<RegisterController>().checkLogin();

                        // Get.to(() =>  RegisterScreen());
                        },
                      child: ImageIcon(
                        AssetImage(Assets.icons.pen.path),
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        selectedPageIndex.value = 2,
                      },
                      child: ImageIcon(
                        AssetImage(Assets.icons.user.path),
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
