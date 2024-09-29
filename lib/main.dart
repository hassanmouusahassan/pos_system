import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/screens/login_screen.dart';
import 'cubits/auth_cubit.dart';
import 'cubits/cart_cubit.dart';
import 'cubits/inventory_cubit.dart';
import 'cubits/sales_cubit.dart';
import 'repositories/inventory_repository.dart';
import 'repositories/sales_repository.dart';
import 'screens/product_list_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/sales_history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final InventoryRepository _inventoryRepository = InventoryRepository();
  final SalesRepository _salesRepository = SalesRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<InventoryCubit>(create: (_) => InventoryCubit(_inventoryRepository)),
        BlocProvider<SalesCubit>(create: (_) => SalesCubit(_salesRepository)),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(
            _inventoryRepository,
            _salesRepository,
            BlocProvider.of<SalesCubit>(context),
          ),
        ),
      ],
      child: CupertinoApp(
        title: 'Simple POS',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.systemBlue,
          scaffoldBackgroundColor: CupertinoColors.systemGrey6,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              fontFamily: 'SF Pro Text',
              color: CupertinoColors.black, // Black text everywhere
            ),
          ),
        ),
        home: LoginScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ProductListScreen(),
    CartScreen(),
    SalesHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cube_box),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(CupertinoIcons.cart),
                Positioned(
                  right: 0,
                  top: -3,
                  child: BlocBuilder<CartCubit, List<dynamic>>(
                    builder: (context, cartItems) {
                      if (cartItems.isNotEmpty) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemRed,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cartItems.length}',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return Container(); // Return empty container when no items
                    },
                  ),
                ),
              ],
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'Sales',
          ),
        ],
        backgroundColor: CupertinoColors.systemGrey6,
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.inactiveGray,
        iconSize: 28.0,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return _screens[index];
          },
        );
      },
    );
  }
}
