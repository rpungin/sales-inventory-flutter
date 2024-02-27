import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_inventory/ui/items_screen/items_screen.dart';
import 'package:sale_inventory/ui/sale_events_screen/sale_events_screen.dart';
import 'package:sale_inventory/ui/shared/themes.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedPageIndex = 0;
  static const _itemsPageIndex = 0;
  static const _saleEventsPageIndex = 1;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(context),
      appBar: AppBar(
          title: Text(_getPageTitle(_selectedPageIndex)),
          leading: _buildLeadingMenu(context),
          actions: _buildAppBarActions(context)),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          if (index != _selectedPageIndex) {
            setState(() => _selectedPageIndex = index);
          }
        },
        children: _buildPages(context),
      ),
    );
  }

  String _getPageTitle(int index) {
    final String pageTitle;
    switch (index) {
      case _itemsPageIndex:
        pageTitle = "Items";
      case _saleEventsPageIndex:
        pageTitle = "Sale Events";
      default:
        pageTitle = "";
    }
    return pageTitle;
  }

  Widget? _buildLeadingMenu(BuildContext context) {
    return null;
  }

  List<Widget>? _buildAppBarActions(BuildContext context) {
    return null;
  }

  Widget? _buildBottomNavigationBar(BuildContext context) {
    return DecoratedBox(
      decoration: Themes.bottomBarDecoration,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedPageIndex,
        onTap: (index) => setState(() {
          if (index != _selectedPageIndex) {
            //_pageController.jumpToPage(index);
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }
        }),
        items: _buildNavBarItems(context),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavBarItems(BuildContext context) {
    final items = [
      BottomNavigationBarItem(
          label: _getPageTitle(_itemsPageIndex),
          icon: const Icon(Icons.shop_2)),
      BottomNavigationBarItem(
          label: _getPageTitle(_saleEventsPageIndex),
          icon: const Icon(Icons.money)),
    ];

    return items;
  }

  List<Widget> _buildPages(BuildContext context) {
    final pages = [
      const ItemsScreen(),
      const SaleEventsScreen(),
    ];
    return pages;
  }

  Widget? _buildFloatingActionButton(BuildContext context) {
    if (_selectedPageIndex == _itemsPageIndex) {
      return FloatingActionButton(
        onPressed: () async {
          await context.pushNamed("manage-item");
        },
        backgroundColor: Themes.colorPrimary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    }
    return null;
  }
}
