import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/category_controller.dart';
import '../widgets/custom_button.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String initialCategoryName;
  final String initialCategoryImg;

  UpdateCategoryScreen({
    required this.categoryId,
    required this.initialCategoryName,
    required this.initialCategoryImg,
  });

  @override
  _UpdateCategoryScreenState createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final categoryController = Get.put(CategoryController());
  File? _selectedImage;
  final cateNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cateNameController.text = widget.initialCategoryName;
  }

  Future<void> _pickImage() async {
    final pickedImage = await categoryController.picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      categoryController.selectedImage.value = pickedImage.path;
    }
  }

  Future<void> _submitUpdate() async {
    String categoryName = cateNameController.text.trim();

    if (categoryName.isEmpty) {
      Get.snackbar('Error', 'Category name cannot be empty');
      return;
    }

    await categoryController.updateCategory(widget.categoryId, categoryName, widget.initialCategoryImg);

    if (!categoryController.isLoading.value) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        backgroundColor:Color(0xFFFFD700),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 17),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'Update Category',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CATEGORY IMAGE',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: _selectedImage == null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.initialCategoryImg.isNotEmpty
                      ? Image.network(widget.initialCategoryImg, fit: BoxFit.cover)
                      : Center(child: Text('No image selected')),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'CATEGORY NAME',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cateNameController,
              decoration: InputDecoration(
                hintText: 'Enter Category Name',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "UPDATE",
                onPressed: _submitUpdate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
