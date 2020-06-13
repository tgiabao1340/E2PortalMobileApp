import 'package:e2portal/app_config.dart';
import 'package:e2portal/bloc/authenticate/authenticate_bloc.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerMenuParent extends StatelessWidget {

  const DrawerMenuParent();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppTheme.BACKGROUND,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppTheme.STROKE),
              child: Center(
                child: Text("E2Portal", style: AppTheme.LogoDrawerStyle),
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Tra cứu thông tin", style: AppTheme.TextCardLabel,),
              leading: IconButton(
                icon: Icon(
                    Icons.account_balance_wallet,
                  color: AppTheme.STROKE,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, studentListRoute);
              },
            ),
            ListTile(
              title: Text("Đăng Xuất", style: AppTheme.TextCardLabel,),
              leading: IconButton(
                icon: Icon(Icons.exit_to_app,
                  color: AppTheme.STROKE,),
              ),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
