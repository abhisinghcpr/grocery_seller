import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_seller/view/screen/widgets/custom_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/product_controller.dart';
import '../../../model/category_model.dart';
import '../widgets/custom_button.dart';

class AddProductScreen extends StatelessWidget {
  final ProductController controller =
      Get.put(ProductController());

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:Color(0xFFFFD700),
        title: Text(
          "Add new Product",
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SERVICES PHOTO",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: screenHeight * 0.01),
              GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Obx(() {
                    return controller.selectedImage.value == null
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
                              controller.selectedImage.value!,
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          );
                  }),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomTextField(
                  label: "PRODUCT NAME",
                  hintText: "Enter Product Name",
                  inputType: TextInputType.text,
                  controller: controller.productNameController),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "CATEGORY",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: screenHeight * 0.01),
              Obx(() {
                return DropdownButtonFormField<CategoriesModel>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Select Category",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  items: controller.categories.map((category) {
                    return DropdownMenuItem<CategoriesModel>(
                      value: category,
                      child: Text(category.categoryName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedCategory.value = value;
                  },
                );
              }),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        label: "FULL PRICE",
                        hintText: "Enter full price",
                        inputType: TextInputType.number,
                        controller: controller.fullPriceController),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: CustomTextField(
                        label: "SALE PRICE",
                        hintText: "Enter sale price",
                        inputType: TextInputType.number,
                        controller: controller.salePriceController),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomTextField(
                  label: "SERVICES DESCRIPTION",
                  hintText: "Enter description",
                  maxLine: 4,
                  inputType: TextInputType.text,
                  controller: controller.productDescriptionController),
              Obx(() {
                return CheckboxListTile(
                  title: Text(
                    "ON SALE",
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  value: controller.isSale.value,
                  onChanged: (value) {
                    controller.isSale.value = value ?? false;
                  },
                );
              }),
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return CustomButton(
                    text:
                        controller.isLoading.value ? "Saving..." : 'SAVE NEXT',
                    onPressed: controller.isLoading.value
                        ? () {} // Provide an empty callback when loading
                        : () {
                            // Validation
                            if (controller.productNameController.text.isEmpty ||
                                controller.salePriceController.text.isEmpty ||
                                controller.fullPriceController.text.isEmpty ||
                                controller.productDescriptionController.text
                                    .isEmpty ||
                                controller.selectedCategory.value == null) {
                              Get.snackbar(
                                "Error",
                                "Please fill all the required fields",
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }

                            // Call the asynchronous function inside the synchronous callback
                            controller.saveProduct();
                          },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
