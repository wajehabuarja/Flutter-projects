import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/chache_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Expanded(
          child: Text(
            'Settings Screen',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        defaultButton(
          function: () {
            Signout(context);
          },
          text: 'Sign Out',
        )
      ],
    ));
  }
}
