import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/helper.dart';
import 'package:haftsara_blog/controllers/manage_article_controller.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({super.key});
  final HtmlEditorController htmlEditorController = HtmlEditorController();
  final ManageArticleController manageSingleArticleController =
      Get.put(ManageArticleController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          htmlEditorController.clearFocus();
        }
      },
      child: Scaffold(
        appBar: appBar('نوشتن / ویرایش مقاله'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: HtmlEditor(
                  controller: htmlEditorController,
                  htmlEditorOptions: HtmlEditorOptions(
                    shouldEnsureVisible: true,
                    hint: 'متن خود را اینجا بنویسید ...',
                    initialText: manageSingleArticleController
                            .articleSingleModel.value.content ??
                        ' ',
                  ),
                  callbacks: Callbacks(onChangeContent: (updatedContent) {
                    // manageSingleArticleController.articleSingleModel.value.content = updatedContent;
                    manageSingleArticleController.articleSingleModel
                        .update((fn) {
                      fn?.content = updatedContent;
                    });
                  }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'ثبت',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }
}
