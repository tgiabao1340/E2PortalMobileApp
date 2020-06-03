import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/app_config.dart';
import 'package:e2portal/bloc/blocs.dart';
import 'package:e2portal/router.dart';
import 'package:e2portal/utilities/utilities.dart';
import 'package:e2portal/utilities/widgets/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiProfileRepository apiProfileRepository = ApiProfileRepository();
  DateTime currentBackTime;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackTime == null || now.difference(currentBackTime) > Duration(seconds: 2)) {
      currentBackTime = now;
      Fluttertoast.showToast(msg: "Nhấn lần nữa để thoát");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
        }
      },
      child: BlocProvider<HomeBloc>(
          create: (context) {
            return HomeBloc(
                authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                apiProfileRepository: apiProfileRepository)
              ..add(HomeRequest());
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) return CardLoading();
              if (state is HomeLoaded)
                return WillPopScope(
                  onWillPop: onWillPop,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Home"),
                      backgroundColor: AppTheme.HEADLINE,
                    ),
                    drawer: DrawerMenu(student: state.student,),
                    body: Container(
                      color: AppTheme.HOME_BACKGROUND,
                      child: GridView.count(crossAxisCount: 2, padding: EdgeInsets.all(4.0), children: <Widget>[
                        HomeButton(
                          text: 'Thông tin',
                          icon: Icons.person,
                          onPressed: () => {Navigator.of(context).pushNamed(profileRoute)},
                        ),
                        HomeButton(
                          text: 'Thông báo',
                          icon: Icons.notifications,
                          onPressed: () => {Navigator.of(context).pushNamed(announcementRoute)},
                        ),
                        HomeButton(
                          text: 'Kết quả học tập',
                          icon: Icons.account_balance_wallet,
                          onPressed: () => {Navigator.of(context).pushNamed(gradingRoute, arguments: state.student)},
                        ),
                        HomeButton(
                          text: 'Điểm danh',
                          icon: Icons.assignment,
                          onPressed: () => {Navigator.of(context).pushNamed(attendanceRoute, arguments: state.student)},
                        ),
                        HomeButton(
                          text: 'Thời khóa biểu',
                          icon: Icons.schedule,
                          onPressed: () => {Navigator.of(context).pushNamed(timetableRoute, arguments: state.student.moduleClasses)},
                        ),
                        HomeButton(
                          text: 'Giảng viên',
                          icon: Icons.school,
                          onPressed: () => {Navigator.of(context).pushNamed(lectureRoute, arguments: state.student)},
                        ),
                        HomeButton(
                            text: 'Đăng Xuất',
                            icon: Icons.exit_to_app,
                            onPressed: () {
                              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                            }),
                      ]),
                    ),
                  ),
                );
              return Container(
                child: Center(
                  child: Text("Lỗi"),
                ),
              );
            },
          ),
        ),
    );
  }
}
