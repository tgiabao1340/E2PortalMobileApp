import 'package:e2portal/app_config.dart';
import 'package:e2portal/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTimetableDetail extends StatelessWidget {
  final String dayOfWeek;
  final String date;
  final bool isToday;
  final List list;

  const CardTimetableDetail({@required this.dayOfWeek, @required this.date, this.isToday = false, this.list});

  _buildPeriodCard(String period) {
    var fPeriod = period.split('.')[0];
    var lPeriod = period.split('.')[1];
    return Column(
      children: [
        SizedBox(
          width: 100,
          child: Center(
            child: Text("Tiết"),
          ),
        ),
        Row(
          children: [
            Text(fPeriod),
            SizedBox(
              width: 5,
            ),
            Text(lPeriod)
          ],
        )
      ],
    );
  }
  _buildRomTag(String room){
    return Column(
      children: <Widget>[
        Text("Phòng"),
        Text(room)
      ],
    );
  }
  _buildTodayTag() {
    return isToday
        ? Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
              child: FittedBox(
                child: Text(
                  "Hôm nay",
                  style: AppTheme.TextToday,
                ),
              ),
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildTodayTag(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                      child: Text(
                        dayOfWeek,
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                      child: Text(
                        date,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: Scrollbar(
                      child: ListView.builder(
                        primary: false,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(list[index].moduleClass.moduleClassName),
                                  ),
                                  _buildPeriodCard(list[index].timeTable.period),
                                  _buildRomTag(list[index].timeTable.classRoom),
                                ],
                              ),
                              Divider(),
                            ],
                          );
                        },
                        itemCount: list.length,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2.0,
          ),
        ],
      ),
    );
  }
}
