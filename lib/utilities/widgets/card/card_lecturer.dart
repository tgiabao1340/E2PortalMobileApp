import 'package:e2portal/app_config.dart';
import 'package:e2portal/model/lecturer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardLecturer extends StatelessWidget {
  final Lecturer lecturer;
  final bool isMainClass;

  CardLecturer({this.lecturer, this.isMainClass});

  _buildTagMainClass() {
    return isMainClass
        ? Container(
            child: Center(
              child: Text(
                "Chủ nhiệm",
                style: AppTheme.TextCardLabel,
              ),
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: Container(
                            width: 80,
                            height: 80,
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
                        Flexible(
                          child: Text(lecturer.lastName + " " + lecturer.firstName),
                        ),
                        _buildTagMainClass(),
                        Divider(),
                        Flexible(
                          child: Text("Thông tin liên lạc", style: AppTheme.TextCardInfo,),
                        ),
                        Flexible(
                          child: Text("Email : " + (lecturer.email != null ? lecturer.email : "Không có")),
                        ),
                        Flexible(
                          child: Text("Số điện thoại : " + (lecturer.numberPhone != null ? lecturer.numberPhone : "Không có")),
                        ),
                      ],
                    ),
                  ),
                ))
      },
      child: Card(
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          padding: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: _buildTagMainClass(),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  child: Text(lecturer.lastName + " " + lecturer.firstName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
