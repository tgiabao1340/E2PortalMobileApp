import 'package:e2portal/app_config.dart';
import 'package:e2portal/bloc/authenticate/authenticate_bloc.dart';
import 'package:e2portal/model/model.dart';
import 'package:e2portal/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerMenu extends StatelessWidget {
  final Student student;

  const DrawerMenu({@required this.student});
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
            ListTile(
              title: Text("Thông tin sinh viên", style: AppTheme.TextCardLabel,),
              leading: IconButton(
                icon: Icon(Icons.person,
                  color: AppTheme.STROKE,),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, profileRoute);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Thông báo", style: AppTheme.TextCardLabel,),
              leading: IconButton(
                icon: Icon(Icons.notifications,
                  color: AppTheme.STROKE,),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, announcementRoute);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Kết quả học tập", style: AppTheme.TextCardLabel,),
              leading: IconButton(
                icon: Icon(
                    Icons.account_balance_wallet,
                  color: AppTheme.STROKE,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, gradingRoute, arguments: student);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Điểm danh", style: AppTheme.TextCardLabel,),
              leading: IconButton(
                icon: Icon(Icons.assignment,
                  color: AppTheme.STROKE,),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, attendanceRoute, arguments: student);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Thời khóa biểu", style: AppTheme.TextCardLabel,),
              leading: IconButton(
                icon: Icon(Icons.schedule,
                  color: AppTheme.STROKE,),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, timetableRoute, arguments: student.moduleClasses);
              },
            ),
            Divider(),
            ListTile(
              title: Text("Giảng viên", style: AppTheme.TextCardLabel,),
              leading: IconButton(
                icon: Icon(Icons.school,
                  color: AppTheme.STROKE,),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, lectureRoute, arguments: student);
              },
            ),
            Divider(),
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
