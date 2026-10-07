// ignore_for_file: must_be_immutable

import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Controllers/celeb/celeb_controller.dart';
import 'package:e_learning/Models/magazine_model.dart';
import 'package:e_learning/Widgets/custom_nav_bar.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/core/helpers/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Magazine extends StatefulWidget {
  const Magazine({Key? key}) : super(key: key);

  @override
  State<Magazine> createState() => _MagazineState();
}

class _MagazineState extends State<Magazine> {
  SizeConfig sizeConfig = SizeConfig();

  bool? isSelected;

  final CelebController controller = Get.put(CelebController());

  int pages = 0;

  int currentPage = 0;

  bool isReady = false;

  String errorMessage = '';

  final PdfViewerController _pdfViewerController = PdfViewerController();
  void showErrorDialog(BuildContext context, String error, String description) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(error),
            content: Text(' مجلة بادئة قصتك لم تنتهي بعد'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerController.previousPage();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerController.nextPage();
            },
          )
        ],
        title: const Text('المجله',
            style: TextStyle(
                color: accentColor,
                fontFamily: 'Janna LT Regular',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        leading: const Icon(
          Icons.arrow_back,
          color: accentColor,
        ),
        backgroundColor: buttonTextColor,
      ),
      body: FutureBuilder<MagazineResponseModel?>(
        future: ContentController().getMagazine(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return SfPdfViewer.network(
              "${snapshot.data!.magazine}",
              controller: _pdfViewerController,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                print(details.document.pages.count);
              },
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                showErrorDialog(context, details.error, details.description);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // bottomNavigationBar: CustomNavigationBar(
      //   index: 5,
      // ),
    );
  }
}
