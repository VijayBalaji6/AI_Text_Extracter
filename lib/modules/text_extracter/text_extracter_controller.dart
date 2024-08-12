import 'dart:io';
import 'dart:typed_data';

import 'package:ai_text_extracter/model/bussiness_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class TextExtractorController extends GetxController {
  File? selectedImage;
  BusinessCard? extractedBusinessCardData;

  void clearSelectedImage() {
    selectedImage = null;
    update();
    Fluttertoast.showToast(msg: "Image Cleared");
  }

  void saveExtractedCardData(BusinessCard extractedData) {}

  Future<CroppedFile> cropImage(String imagePath) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
        ],
      );
      if (croppedFile != null) {
        return croppedFile;
      } else {
        throw Exception("Error in cropping");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final loadedImage = File(pickedImage.path);
      CroppedFile croppedImage = await cropImage(loadedImage.path);
      selectedImage = File(croppedImage.path);
    }
    update();
  }

  Future<void> pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      final loadedImage = File(pickedImage.path);
      CroppedFile croppedImage = await cropImage(loadedImage.path);
      selectedImage = File(croppedImage.path);
    }
    update();
  }

  Future<BusinessCard> processImage() async {
    try {
      final imageInput = InputImage.fromFile(selectedImage!);
      final textRecognizer = TextRecognizer();
      final recognizedText = await textRecognizer.processImage(imageInput);
      await textRecognizer.close();
      String scannedText = '';
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          scannedText = "$scannedText${line.text}\n";
        }
      }

      final BusinessCard extractedData = await extractData(scannedText);

      return extractedData;
    } catch (e) {
      rethrow;
    }
  }

  Future<BusinessCard> extractData(String extractedText) async {
    try {
      // String infoText = text.replaceAll('\n', ' ');
      // final Gemini gemini = Gemini.instance;
      // Candidates? data = await gemini.text(
      //     "$infoText Extract company_name,person_name,eMail,website,phone_number,address(In single string) in json object");
      // if (data != null && data.output != null && data.finishReason != "STOP") {
      //   return BusinessCard.fromJson(data.output!);
      // } else {
      //   throw Exception("Something went wrong in text extraction");
      // }

      // Regex patterns
      final emailRegex = RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b',
          caseSensitive: false);
      final phoneRegex = RegExp(
          r'\b(?:\+?(\d{1,3})?[-.\s()]*)?(\d{3})[-.\s()]*(\d{3})[-.\s()]*(\d{4})\b');
      final websiteRegex = RegExp(
          r'\b(?:https?://)?(?:www\.)?[A-Z0-9.-]+\.[A-Z]{2,4}\b',
          caseSensitive: false);

      String email = '';
      String phoneNumber = '';
      String website = '';
      String name = '';
      String address = '';

      List<String> lines = extractedText.split('\n');

      for (var line in lines) {
        line = line.trim();

        if (email.isEmpty && emailRegex.hasMatch(line)) {
          email = emailRegex.firstMatch(line)!.group(0)!;
        }

        if (phoneNumber.isEmpty && phoneRegex.hasMatch(line)) {
          phoneNumber = phoneRegex.firstMatch(line)!.group(0)!;
        }

        if (website.isEmpty && websiteRegex.hasMatch(line)) {
          website = websiteRegex.firstMatch(line)!.group(0)!;
        }

        if (name.isEmpty &&
            line
                    .split(' ')
                    .where((word) => word[0].toUpperCase() == word[0])
                    .length >=
                2) {
          name = line;
        }

        if (address.isEmpty && line.contains(RegExp(r'\d'))) {
          address = line;
        }
      }

      if (name.isEmpty) {
        name = lines.firstWhere(
          (line) =>
              line
                  .split(' ')
                  .where((word) => word[0].toUpperCase() == word[0])
                  .length >=
              2,
          orElse: () => 'Name not found',
        );
      }

      if (address.isEmpty) {
        address = lines.lastWhere(
          (line) => line.contains(RegExp(r'\d')),
          orElse: () => 'Address not found',
        );
      }
      Uint8List imageData = await fileToUint8List(selectedImage!);
      final BusinessCard extractedData = BusinessCard(
          image: imageData,
          name: name,
          eMail: email,
          phoneNumber: phoneNumber,
          address: address,
          website: website);

      return extractedData;
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> fileToUint8List(File file) async {
    // Read the file as bytes
    Uint8List bytes = await file.readAsBytes();
    return bytes;
  }
}
