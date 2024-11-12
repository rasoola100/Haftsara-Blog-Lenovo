import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/components/strings_blog.dart';
import 'package:haftsara_blog/controllers/register_controller.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:haftsara_blog/view/blog_category.dart';
import 'package:validators/validators.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  // final RegisterController registerController = Get.put(RegisterController());
  var registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    var email = '';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.robotIcon,
              colorFilter: const ColorFilter.mode(
                  ColorsBlog.secodaryColor, BlendMode.srcIn),
              height: 120,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: StringsBlog.txtWelcomeRegisterPage,
                    style: textTheme.titleSmall),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Container(
                          height: screenSize.width < 420
                              ? screenSize.height / 2.5
                              : screenSize.height / 2,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 8),
                                child: Text(
                                  'ایمیل خود را وارد کنید',
                                  style: textTheme.titleSmall,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextField(
                                  controller: registerController
                                      .eamilTextEditingCortroller,
                                  onChanged: (value) {
                                    debugPrint(
                                        '$value is Email = ${isEmail(value)}');
                                    // setState(() {
                                    //   email = value;
                                    // });
                                  },
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                      hintText: 'yourEmail@gmail.com',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.grey))),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    registerController.register();
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Container(
                                              height: screenSize.width < 480
                                                  ? screenSize.height / 2.5
                                                  : screenSize.height / 2,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        10, 20, 10, 8),
                                                    child: Text(
                                                      'کد فعالسازی را وارد کنید',
                                                      style:
                                                          textTheme.titleSmall,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: TextField(
                                                      controller: registerController
                                                          .activatedCodeEditingCortroller,
                                                      onChanged: null,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration: InputDecoration(
                                                          hintText: '- - - - - -',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              borderSide:
                                                                  const BorderSide(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .grey))),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      registerController
                                                          .verify();
                                                      // Navigator.of(context)
                                                      //     .pushReplacement(
                                                      //         MaterialPageRoute(
                                                      //             builder:
                                                      //                 (context) =>
                                                      //                     const BlogCategory()));
                                                    },
                                                    child: Text(
                                                      'تایید',
                                                      style:
                                                          textTheme.titleMedium,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    'ادامه',
                                    style: textTheme.titleMedium,
                                  ))
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ثبت‌نام',
                  style: textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
