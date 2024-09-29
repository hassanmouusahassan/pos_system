import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'product_list_screen.dart';
import 'sales_history_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('POS Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle("Manage Your Store"),
            SizedBox(height: 20),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2, // Responsive for tablets
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                children: [
                  _buildDashboardCard(
                      context, 'View Products', CupertinoIcons.cube_box_fill, ProductListScreen()),
                  _buildDashboardCard(
                      context, 'Cart', CupertinoIcons.cart_fill, CartScreen()),
                  _buildDashboardCard(
                      context, 'Sales History', CupertinoIcons.doc_text_fill, SalesHistoryScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: CupertinoColors.black,
      ),
    );
  }

  Widget _buildDashboardCard(
      BuildContext context, String title, IconData icon, Widget destinationScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => destinationScreen));
      },
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: CupertinoColors.systemBlue),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
