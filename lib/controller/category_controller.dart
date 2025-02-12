import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  RxString selectedImage = "".obs;
  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = pickedFile.path;
    }
  }

  Future<String?> uploadImage(String documentId) async {
    if (selectedImage.value.isEmpty) return null;

    final fileName = documentId;
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      cacheControl: 'public,max-age=3600',
    );

    try {
      final uploadTask = FirebaseStorage.instance
          .ref('category_images/$fileName')
          .putFile(File(selectedImage.value), metadata);

      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> addCategory(String name) async {
    isLoading.value = true;

    final categoryRef =
        FirebaseFirestore.instance.collection('categories').doc();

    final imageUrl = await uploadImage(categoryRef.id);

    if (imageUrl != null) {
      final category = CategoriesModel(
        categoryId: categoryRef.id,
        categoryImg: imageUrl,
        categoryName: name,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      try {
        await categoryRef.set(category.toMap());

        Get.snackbar('Success', 'Category added successfully!');
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to add category');
      }
    } else {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to upload image');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .delete();
      Get.snackbar('Success', 'Category deleted successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete category');
    }
  }

  Future<void> updateCategory(
      String categoryId, String name, String imageUrl) async {
    isLoading.value = true;

    String updatedImageUrl = imageUrl;

    // Upload the new image if a new one is selected
    if (selectedImage.value.isNotEmpty) {
      updatedImageUrl = await uploadImage(categoryId) ?? imageUrl;
    }

    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .update({
        'categoryName': name,
        'categoryImg': updatedImageUrl,
        'updatedAt': Timestamp.now(),
      });
      Get.snackbar('Success', 'Category updated successfully!');
      clearForm();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update category');
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    selectedImage.value = "";
  }
}
