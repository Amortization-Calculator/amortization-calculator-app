import 'package:flutter/material.dart';
import '../features/auth/services/logout_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLogout;
  final bool showTabs;
  final TabController? tabController;

  const CustomAppBar({
    super.key,
    this.showLogout = true,
    this.showTabs = true,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: Colors.white,
      elevation: 0.5,
      shadowColor: Colors.black,
      centerTitle: true,
      title: Image.asset(
        'lib/assets/logo-transparent-png.png',
        height: 60.0,
      ),
      bottom: showTabs && tabController != null
          ? TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.white,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'By Unit Price'),
          Tab(text: 'By Salary'),
        ],
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
        ),
      )
          : null,
      actions: showLogout
          ? [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              LogoutService logoutService = LogoutService();
              await logoutService.logout();
            },
          ),
        ),
      ]
          : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight +
        (showTabs && tabController != null ? kTextTabBarHeight : 0.0),
  );
}
