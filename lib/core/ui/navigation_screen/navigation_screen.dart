import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_inventory/core/ui/styles.dart';
import 'package:sale_inventory/core/ui/themes.dart';
import 'package:sale_inventory/features/items/ui/items_screen/items_screen.dart';
import 'package:sale_inventory/features/sale_events/ui/sale_events_screen/sale_events_screen.dart';

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
      appBar: AppBar(
        title: _buildPageTitle(context, _selectedPageIndex),
        leading: _buildLeadingMenu(context),
        actions: _buildAppBarActions(context),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: Themes.topBarDecoration,
        ),
        iconTheme: IconThemeData(
          color: Themes.colorTextLight,
        ),
        elevation: 6,
      ),
      floatingActionButton: _buildFloatingActionButton(context),
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

  Widget _buildPageTitle(BuildContext context, int index) {
    return Text(_getPageTitle(index),
        style: Styles.textStyleLargeBoldOnWidget());
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
          label: _getPageTitle(_itemsPageIndex), icon: const Icon(Icons.shop)),
      BottomNavigationBarItem(
          label: _getPageTitle(_saleEventsPageIndex),
          icon: const Icon(Icons.calendar_month)),
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
