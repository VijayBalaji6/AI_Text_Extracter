import 'package:ai_text_extracter/model/bussiness_card.dart';
import 'package:ai_text_extracter/modules/text_extracter/text_extracter_controller.dart';
import 'package:ai_text_extracter/modules/text_extracter/view/edit_extracted_text_screen.dart';
import 'package:ai_text_extracter/services/card_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class ExtractTextView extends StatelessWidget {
  const ExtractTextView({super.key});
// double x = 0.0, y = 0.0, w = 0.0, h = 0.0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextExtractorController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: controller.selectedImage == null
                  ? const Center(child: Text("Select a image"))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20),
                              child: Column(
                                children: [
                                  Stack(children: [
                                    Image(
                                      image:
                                          FileImage(controller.selectedImage!),
                                    ),
                                    // FutureBuilder(
                                    //     future: detectVisitingCard(),
                                    //     builder: (BuildContext context,
                                    //         AsyncSnapshot<dynamic> snapShot) {
                                    //       return Positioned(
                                    //         top: y * 700,
                                    //         right: x * 100,
                                    //         child: Container(
                                    //           height: h *
                                    //               100 *
                                    //               MediaQuery.of(context).size.height /
                                    //               100,
                                    //           width: w *
                                    //               100 *
                                    //               MediaQuery.of(context).size.width /
                                    //               100,
                                    //           decoration: BoxDecoration(
                                    //               borderRadius: BorderRadius.circular(5),
                                    //               border: Border.all(
                                    //                   color: Colors.green, width: 4)),
                                    //         ),
                                    //       );
                                    //     }),
                                  ]),
                                  // Text(detectedLabel),
                                  FutureBuilder<BusinessCard>(
                                    future: controller.processImage(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<BusinessCard> snapShot) {
                                      if (snapShot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapShot.hasError) {
                                        return const Text(
                                            'Error in extracting  text');
                                      } else if (snapShot.hasData) {
                                        final BusinessCard extractedData =
                                            snapShot.data!;
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Extracted Text',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            viewCardData(
                                                dataTitle: 'Name',
                                                cardData: extractedData.name),
                                            viewCardData(
                                                dataTitle: 'Email',
                                                cardData: extractedData.eMail),
                                            viewCardData(
                                                dataTitle: 'Phone',
                                                cardData:
                                                    extractedData.phoneNumber),
                                            viewCardData(
                                                dataTitle: 'Website',
                                                cardData:
                                                    extractedData.website),
                                            viewCardData(
                                                dataTitle: 'Address',
                                                cardData:
                                                    extractedData.address),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      await CardServices
                                                          .saveCard(
                                                              extractedData);
                                                      controller
                                                          .clearSelectedImage();
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Business card Saved");
                                                    },
                                                    child: const Text(
                                                        "Save Data")),
                                                ElevatedButton(
                                                    onPressed: () => Get.to(() =>
                                                        EditExtractedTextScreen(
                                                            editableBusinessCardData:
                                                                extractedData)),
                                                    child: const Text(
                                                        "Edit Data")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .clearSelectedImage();
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Business card cleared");
                                                    },
                                                    child: const Text(
                                                        "Clear Data"))
                                              ],
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const Text('No data');
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () => controller.pickImageFromGallery(),
                  child: const Icon(Icons.file_copy),
                ),
                const SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () => controller.pickImageFromCamera(),
                  child: const Icon(Icons.camera),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget viewCardData({required String dataTitle, required String cardData}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Text(
        '$dataTitle: $cardData',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
