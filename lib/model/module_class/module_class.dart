class ModuleClass {
    String moduleClassId;
    String moduleClassName;
    int numOfTSession;
    int numOfPSession;
    int numOfCredit;
    String semester;
    String startDate;
    String endDate;
    String formattedEndDate;
    String formattedStartDate;
    String totalDay;
    ModuleClass(
        {this.moduleClassId,
            this.moduleClassName,
            this.numOfTSession,
            this.numOfPSession,
            this.numOfCredit,
            this.semester,
            this.startDate,
            this.endDate,
            this.formattedEndDate,
            this.formattedStartDate});

    ModuleClass.fromJson(Map<String, dynamic> json) {
        moduleClassId = json['moduleClassId'];
        moduleClassName = json['moduleClassName'];
        numOfTSession = json['numOfTSession'];
        numOfPSession = json['numOfPSession'];
        numOfCredit = json['numOfCredit'];
        semester = json['semester'];
        startDate = json['startDate'];
        endDate = json['endDate'];
        formattedEndDate = json['formattedEndDate'];
        formattedStartDate = json['formattedStartDate'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['moduleClassId'] = this.moduleClassId;
        data['moduleClassName'] = this.moduleClassName;
        data['numOfTSession'] = this.numOfTSession;
        data['numOfPSession'] = this.numOfPSession;
        data['numOfCredit'] = this.numOfCredit;
        data['semester'] = this.semester;
        data['startDate'] = this.startDate;
        data['endDate'] = this.endDate;
        data['formattedEndDate'] = this.formattedEndDate;
        data['formattedStartDate'] = this.formattedStartDate;
        return data;
    }
}