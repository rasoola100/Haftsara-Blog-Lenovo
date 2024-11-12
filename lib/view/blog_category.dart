import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/components/strings_blog.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:haftsara_blog/model/fake_data.dart';

class BlogCategory extends StatefulWidget {
  const BlogCategory({super.key});

  @override
  State<BlogCategory> createState() => _BlogCategoryState();
}

class _BlogCategoryState extends State<BlogCategory> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    Assets.images.robotIcon,
                    colorFilter: const ColorFilter.mode(
                        ColorsBlog.secodaryColor, BlendMode.srcIn),
                  ),
                ),
                Text(
                  StringsBlog.txtOkRegister,
                  style: textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextField(
                      onChanged: (value) {},
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: 'نام و نام خانوادگی',
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ))),
                ),
                Text(
                  'انتخاب فهرست علاقه‌مندی‌ها ',
                  style: textTheme.titleSmall,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 14, 10, 25),
                  child: SizedBox(
                    height: screenSize.width < 480
                        ? screenSize.height / 5.5
                        : screenSize.height / 2.8,
                    width: double.infinity,
                    child: GridView.builder(
                      itemCount: categoryFakeList.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          childAspectRatio:
                              screenSize.width < 480 ? 0.5 : 0.37),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                             if(!categorySelectedFakeList.contains(categoryFakeList[index])) {
                               categorySelectedFakeList
                                  .add(categoryFakeList[index]);
                             }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(55),
                                gradient: const LinearGradient(
                                    colors:
                                        ColorsBlog.categorySelectGradientColor,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                            child: Center(
                                child: Text(
                              categoryFakeList[index].title,
                              style: textTheme.labelMedium,
                            )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SvgPicture.asset(
                  Assets.images.arrowBottom,
                  height: 70,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: screenSize.width < 480
                        ? screenSize.height / 5.5
                        : screenSize.height / 2.8,
                    child: GridView.builder(
                      itemCount: categorySelectedFakeList.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          childAspectRatio: screenSize.width < 480 ? 0.5 : 0.37),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const LinearGradient(
                                  colors: ColorsBlog.categorySelectGradientColor,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                categorySelectedFakeList[index].title,
                                style: textTheme.labelMedium,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    categorySelectedFakeList.removeAt(index);
                                  });
                                },
                                  child: const Icon(
                                Icons.delete,
                                color:  Color.fromARGB(255, 253, 120, 105),
                                size: 30,
                              ))
                            ],
                          )),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
