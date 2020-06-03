import 'package:e2portal/api/repository/api_profile_repository.dart';
import 'package:e2portal/app_config.dart';
import 'package:e2portal/data/announcements_data.dart';
import 'package:e2portal/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/flutter_paginator.dart';

class AnnouncementScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AnnouncementState();
  }
}

class _AnnouncementState extends State<AnnouncementScreen> {
  ApiProfileRepository apiProfileRepository = new ApiProfileRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông báo"),
        backgroundColor: AppTheme.HEADLINE,
      ),
      body: Container(
        child: Center(
          child: Paginator.listView(
              pageLoadFuture: (page) {
                page = page - 1;
                return apiProfileRepository.getAnnouncements(page);
              },
              pageItemsGetter: listItemsGetter,
              listItemBuilder: listItemBuilder,
              loadingWidgetBuilder: loadingWidgetMaker,
              errorWidgetBuilder: errorWidgetMaker,
              emptyListWidgetBuilder: emptyListWidgetMaker,
              totalItemsGetter: totalPagesGetter,
              pageErrorChecker: pageErrorChecker,
              scrollPhysics: BouncingScrollPhysics()),
        ),
      ),
    );
  }

  List<dynamic> listItemsGetter(AnnouncementsData announcementsData) {
    List<dynamic> list = [];
    announcementsData.announcements.forEach((value) {
      list.add(value);
    });
    return list;
  }

  Widget listItemBuilder(value, int index) {
    return Card(
      child: ListTile(
        leading: Text(value.formattedCreatedDate),
        title: Text(value.title),
        subtitle: Text(value.summary),
        isThreeLine: true,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.topLeft,
                        child: Text(
                          value.formattedCreatedDate,
                          style: AppTheme.LabelTextStyle,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          value.title,
                          style: AppTheme.TextCardInfo,
                        ),
                      ),
                      Divider(),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          value.summary,
                          style: AppTheme.TextCardSubtitle,
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            value.contentDetail,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: FlatButton(
                              child: Text('Đóng'),
                              onPressed: () => {Navigator.pop(context)},
                            ),
                          )),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget errorWidgetMaker(AnnouncementsData announcementsData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(announcementsData.error),
        ),
        FlatButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, homeRoute);
          },
          child: Text('Thử lại'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(AnnouncementsData announcementsData) {
    return Center(
      child: Text('Không có thông báo'),
    );
  }

  int totalPagesGetter(AnnouncementsData announcementsData) {
    return announcementsData.total;
  }

  bool pageErrorChecker(AnnouncementsData announcementsData) {
    return announcementsData.statusCode != 200;
  }
}
