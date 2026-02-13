import 'package:design_task_1/constants/asset_names.dart';
import 'package:design_task_1/pages/store/store_finance_screen.dart';
import 'package:design_task_1/pages/store/store_home_screen.dart';
import 'package:design_task_1/pages/store/store_orders_screen.dart';
import 'package:design_task_1/pages/store/store_products_screen.dart';
import 'package:design_task_1/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    StoreHomeScreen(),
    StoreProductsScreen(),
    StoreFinanceScreen(),
    StoreOrdersScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: AppColors.bottomNavBarBg,
        selectedItemColor: AppColors.textButton,
        unselectedItemColor: AppColors.textHint,
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(width: 18, height: 20, AssetNames.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(width: 18, height: 20, AssetNames.products),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(width: 18, height: 20, AssetNames.finance),
            label: 'Finance',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(width: 18, height: 20, AssetNames.orders),
            label: 'Orders',
          ),
        ],
      ),
    );
  }
}
