import 'package:flutter/material.dart';
import '../features/auth/services/logout_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

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
      actions: [
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
