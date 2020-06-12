import 'package:e2portal/api/repository/api_auth_repository.dart';
import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/bloc/blocs.dart';
import 'package:e2portal/utilities/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_config.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiAuthRepository apiAuthRepository = ApiAuthRepository();
  final ApiProfileRepository apiProfileRepository = ApiProfileRepository();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _globalKey = new GlobalKey();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Thông tin cá nhân"),
        backgroundColor: AppTheme.HEADLINE,
      ),
      body: BlocProvider<ProfileBloc>(
        create: (context) {
          return ProfileBloc(
              apiProfileRepository: apiProfileRepository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))
            ..add(ProfileRequest());
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) CardLoading();
            if (state is ProfileLoaded) {
              return Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(color: AppTheme.HOME_BACKGROUND),
                child: Container(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/default-user-image.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      Flexible(
                        flex: 12,
                        child: Column(
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CardInfo(
                                      label: "Giới tính",
                                      textInfo: state.student.gender ? "Nam" : "Nữ",
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CardInfo(
                                      label: "Họ và tên",
                                      textInfo: state.student.lastName + " " + state.student.firstName,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CardInfo(
                                      label: 'Năm Học',
                                      textInfo: state.student.mainClass.year,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CardInfo(
                                      label: 'Ngày sinh',
                                      textInfo: state.student.formatedDate,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CardInfo(
                                      label: 'MSSV',
                                      textInfo: state.student.id,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CardInfo(
                                      label: 'Lớp',
                                      textInfo: state.student.mainClass.classId,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CardInfo(
                                      label: 'Bậc đào tạo',
                                      textInfo: state.student.mainClass.level,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CardInfo(
                                      label: 'Khoa',
                                      textInfo: state.student.mainClass.faculty.facultyId,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CardInfo(
                                      label: 'Số điện thoại',
                                      textInfo: state.student.numberPhone,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CardInfo(
                                      label: 'Chuyên ngành',
                                      textInfo: state.student.mainClass.speciality,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CardInfo(
                                      label: 'Địa chỉ',
                                      textInfo: state.student.address,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          child: CustomButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(
                                    "Đổi mật khẩu",
                                    style: AppTheme.LabelTextStyle,
                                  ),
                                  content: Form(
                                    key: _globalKey,
                                    autovalidate: _validate,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: _newPasswordController,
                                          obscureText: true,
                                          validator: validatePassword,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Mật khẩu mới',
                                          ),
                                        ),
                                        Divider(),
                                        TextFormField(
                                          controller: _confirmPasswordController,
                                          obscureText: true,
                                          validator: checkConfirmPassword,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Nhập lại mật khẩu',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text('Hủy'),
                                      onPressed: () {
                                        _newPasswordController.clear();
                                        _confirmPasswordController.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Đổi mật khẩu'),
                                      onPressed: () {
                                        if (_globalKey.currentState.validate()) {
                                          _globalKey.currentState.save();
                                          String newPassword = _newPasswordController.text.toString().trim();
                                          apiAuthRepository.changePassword(newPassword).then((value) {
                                            if (value) {
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text("Đổi thành công"),
                                                backgroundColor: Colors.green,
                                              ));
                                              _newPasswordController.clear();
                                              _confirmPasswordController.clear();
                                              Navigator.pop(context);
                                            }
                                          });
                                        } else {
                                          setState(() {
                                            _newPasswordController.clear();
                                            _confirmPasswordController.clear();
                                            _validate = true;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            text: 'Đổi mật khẩu',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  String validatePassword(String password) {
    if (password.isEmpty) return 'Mật khẩu không được để trống';
    if (password.length < 6) return 'Mật khẩu ít nhất 6 số';
    return null;
  }

  String checkConfirmPassword(String password) {
    return password.compareTo(_newPasswordController.text.toString().trim()) == 0
        ? null
        : "Xác nhận mật khẩu không đúng";
  }
}
