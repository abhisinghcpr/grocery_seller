import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../model/category_model.dart';

class ProductController extends GetxController {
  var selectedImage = Rxn<File>();
  var categories = <CategoriesModel>[].obs;
  var selectedCategory = Rxn<CategoriesModel>();

  var productNameController = TextEditingController();
  var salePriceController = TextEditingController();
  var fullPriceController = TextEditingController();
  var deliveryTimeController = TextEditingController();
  var productDescriptionController = TextEditingController();

  var isSale = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCategories();  // Fetch categories when the controller is initialized
  }

  Future<void> _fetchCategories() async {
    final categoryQuery = await FirebaseFirestore.instance
        .collection('categories')
        .get();

    categories.assignAll(categoryQuery.docs
        .map((e) => CategoriesModel.fromMap(e.data()))
        .toList());
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<String?> uploadImage() async {
    if (selectedImage.value == null) return null;

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();  // Unique file name
      final uploadTask = FirebaseStorage.instance
          .ref('products_images/$fileName')
          .putFile(selectedImage.value!);

      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> saveProduct() async {
    isLoading.value = true;

    final productId = FirebaseFirestore.instance.collection('products').doc().id;
    final downloadUrl = await uploadImage();

    final newProduct = {
      'productId': productId,
      'categoryId': selectedCategory.value?.categoryId,
      'categoryName': selectedCategory.value?.categoryName,
      'productName': productNameController.text,
      'salePrice': salePriceController.text,
      'fullPrice': fullPriceController.text,
      'productImages': downloadUrl != null ? [downloadUrl] : [],
      'deliveryTime': deliveryTimeController.text,
      'isSale': isSale.value,
      'productDescription': productDescriptionController.text,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).set(newProduct);
      Get.snackbar("Success", "Product added successfully", snackPosition: SnackPosition.TOP);
      clearForm();
    } catch (e) {
      Get.snackbar("Error", "There was an issue saving the product. Please try again.", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    productNameController.clear();
    salePriceController.clear();
    fullPriceController.clear();
    deliveryTimeController.clear();
    productDescriptionController.clear();
    selectedImage.value = null;
    selectedCategory.value = null;
    isSale.value = false;  // Reset isSale
  }
}
