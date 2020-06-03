class Attendance {
  int attendanceId;
  String dateOff;
  bool allowed;
  String formattedDateOff;
  String moduleClassId;

  Attendance(
      {this.attendanceId,
        this.dateOff,
        this.allowed,
        this.formattedDateOff,
        this.moduleClassId});

  Attendance.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendanceId'];
    dateOff = json['dateOff'];
    allowed = json['allowed'];
    formattedDateOff = json['formattedDateOff'];
    moduleClassId = json['moduleClassId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendanceId'] = this.attendanceId;
    data['dateOff'] = this.dateOff;
    data['allowed'] = this.allowed;
    data['formattedDateOff'] = this.formattedDateOff;
    data['moduleClassId'] = this.moduleClassId;
    return data;
  }
}