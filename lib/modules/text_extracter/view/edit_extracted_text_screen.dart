import 'package:ai_text_extracter/model/bussiness_card.dart';
import 'package:ai_text_extracter/modules/text_extracter/text_extracter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditExtractedTextScreen extends StatelessWidget {
  EditExtractedTextScreen({super.key, required this.editableBusinessCardData});

  final BusinessCard editableBusinessCardData;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _webSiteController = TextEditingController();
  final TextExtractorController textExtractorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Business Card Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Hero(
              tag: 'tagImage$_nameController',
              child: Image.memory(
                editableBusinessCardData.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            _buildStyledTextField(
              controller: _nameController..text = editableBusinessCardData.name,
              labelText: 'Name',
              icon: Icons.person,
            ),
            _buildStyledTextField(
              controller: _emailController
                ..text = editableBusinessCardData.eMail,
              labelText: 'Email',
              icon: Icons.email,
            ),
            _buildStyledTextField(
              controller: _phoneNumberController
                ..text = editableBusinessCardData.phoneNumber,
              labelText: 'Phone Number',
              icon: Icons.phone,
            ),
            _buildStyledTextField(
              controller: _webSiteController
                ..text = editableBusinessCardData.website,
              labelText: 'Website',
              icon: Icons.web,
            ),
            _buildStyledTextField(
              controller: _addressController
                ..text = editableBusinessCardData.address,
              labelText: 'Address',
              icon: Icons.location_on,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                textExtractorController.saveExtractedCardData(BusinessCard(
                    name: _nameController.text,
                    eMail: _emailController.text,
                    phoneNumber: _phoneNumberController.text,
                    address: _addressController.text,
                    website: _webSiteController.text,
                    image: editableBusinessCardData.image));
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build a styled TextField
  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.teal, fontSize: 16),
          prefixIcon: Icon(icon, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.teal),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
      ),
    );
  }
}
