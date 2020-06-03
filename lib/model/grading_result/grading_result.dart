class GradingResult {
  double quiz1;
  double quiz2;
  double quiz3;
  double quiz4;
  double quiz5;
  double midScore;
  double endScore;
  double averageScore;
  double practiceScore1;
  double practiceScore2;
  double practiceScore3;
  double practiceScore4;
  double practiceScore5;
  String moduleClassId;
  String studentId;

  GradingResult(
      {this.quiz1,
        this.quiz2,
        this.quiz3,
        this.quiz4,
        this.quiz5,
        this.midScore,
        this.endScore,
        this.averageScore,
        this.practiceScore1,
        this.practiceScore2,
        this.practiceScore3,
        this.practiceScore4,
        this.practiceScore5,
        this.moduleClassId,
        this.studentId});

  GradingResult.fromJson(Map<String, dynamic> json) {
    quiz1 = json['quiz1'];
    quiz2 = json['quiz2'];
    quiz3 = json['quiz3'];
    quiz4 = json['quiz4'];
    quiz5 = json['quiz5'];
    midScore = json['midScore'];
    endScore = json['endScore'];
    averageScore = json['averageScore'];
    practiceScore1 = json['practiceScore1'];
    practiceScore2 = json['practiceScore2'];
    practiceScore3 = json['practiceScore3'];
    practiceScore4 = json['practiceScore4'];
    practiceScore5 = json['practiceScore5'];
    moduleClassId = json['moduleClassId'];
    studentId = json['studentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quiz1'] = this.quiz1;
    data['quiz2'] = this.quiz2;
    data['quiz3'] = this.quiz3;
    data['quiz4'] = this.quiz4;
    data['quiz5'] = this.quiz5;
    data['midScore'] = this.midScore;
    data['endScore'] = this.endScore;
    data['averageScore'] = this.averageScore;
    data['practiceScore1'] = this.practiceScore1;
    data['practiceScore2'] = this.practiceScore2;
    data['practiceScore3'] = this.practiceScore3;
    data['practiceScore4'] = this.practiceScore4;
    data['practiceScore5'] = this.practiceScore5;
    data['moduleClassId'] = this.moduleClassId;
    data['studentId'] = this.studentId;
    return data;
  }
}