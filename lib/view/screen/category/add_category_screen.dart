import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/category_controller.dart';
import '../widgets/custom_button.dart';

class AddCategoryScreen extends StatelessWidget {
  final CategoryController controller = Get.put(CategoryController());
  final TextEditingController categoryNameController = TextEditingController();

  AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        backgroundColor:Color(0xFFFFD700),
        elevation: 0,
        title: Text(
          'Add New Category',
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 17),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
            Obx(
              () => GestureDetector(
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: controller.selectedImage.value.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 70,
                              color: Colors.blueGrey,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Add',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(controller.selectedImage.value),
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
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
              controller: categoryNameController,
              decoration: InputDecoration(
                hintText: 'Enter Category Name',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => CustomButton(
                  text: controller.isLoading.value ? 'Submitting...' : 'SUBMIT',
                  onPressed: controller.isLoading.value
                      ? () {
                          categoryNameController.clear();
                        }
                      : () {
                          if (categoryNameController.text.isNotEmpty) {
                            controller.addCategory(categoryNameController.text);
                          } else {
                            Get.snackbar('Error', 'Please enter category name');
                          }
                        },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
