import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_seller/view/screen/products/add_produts.dart';
import '../category/category_list_screen.dart';
import '../order/all_user_orders.dart';
import '../users/all_user_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFFD700),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(height: 35),
            _buildRow(
              context,
              [
                _buildDashboardItem(
                  onTap: () => Get.to(() => AllUsersScreen()),
                  color: Colors.blue,
                  icon: Icons.group,
                  title: 'Customers',
                ),
                _buildDashboardItem(
                  color: Colors.green,
                  icon: Icons.category,
                  title: 'Category',
                  onTap: () => Get.to(() => AllCategoryScreen()),
                ),
              ],
            ),
            SizedBox(height: 50),
            _buildRow(
              context,
              [
                _buildDashboardItem(
                  color: Colors.orange,
                  icon: Icons.inventory,
                  title: 'Products',
                  onTap: () => Get.to(() => AddProductScreen()),
                ),
                _buildDashboardItem(
                  onTap: () => Get.to(()=>AllOrdersScreen()),
                  color: Colors.pink,
                  icon: Icons.shopping_bag_rounded,
                  title: 'Orders',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, List<Widget> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((item) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: item,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDashboardItem({
    required Color color,
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF212F45),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: color,
                    radius: 24,
                    child: Icon(icon, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
