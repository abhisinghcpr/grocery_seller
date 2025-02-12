import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_seller/view/screen/category/update_category.dart';
import '../../../controller/category_controller.dart';
import '../../../model/category_model.dart';
import 'add_category_screen.dart';


class AllCategoryScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor:Color(0xFFFFD700),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCategoryScreen(),
              ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xFFF2F5FA),
      appBar: AppBar(
        backgroundColor:Color(0xFFFFD700),
        elevation: 0,
        title: Text(
          'All Category',
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching categories'));
          }

          final categories = snapshot.data?.docs ?? [];

          return ListView.builder(

            itemCount: categories.length,
            itemBuilder: (context, index) {
              final categoryData =
                  categories[index].data() as Map<String, dynamic>;

              final category = CategoriesModel.fromMap(categoryData);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                child: ProductItemCard(category: category),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductItemCard extends StatelessWidget {
  final CategoriesModel category;

  ProductItemCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: category.categoryImg,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.categoryName,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
          PopupMenuButton<String>(
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10,),
              
            ),
            color: Colors.white,
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteDialog(context, category.categoryId);
              } else if (value == 'update') {
                Get.to(UpdateCategoryScreen(
                  categoryId: category.categoryId,
                  initialCategoryName: category.categoryName,
                  initialCategoryImg: category.categoryImg,
                ));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'update',
                  child: Text('Update'),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  _showDeleteDialog(BuildContext context, String categoryId) {
    final CategoryController categoryController = Get.put(CategoryController());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Category'),
          content: Text('Are you sure you want to delete this category?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                categoryController.deleteCategory(categoryId);
                Get.back();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
