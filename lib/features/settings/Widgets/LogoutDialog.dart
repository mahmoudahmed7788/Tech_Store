import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppStrings.logout(context),
      ),
      content: Text(
        AppStrings.logoutQuestion(context),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppStrings.cancel(context),
          ),
        ),

        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.go('/login');
          },
          child: Text(
            AppStrings.logout(context),
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
