class Faculty {
  String facultyId;
  String name;

  Faculty({this.facultyId, this.name});

  Faculty.fromJson(Map<String, dynamic> json) {
    facultyId = json['facultyId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facultyId'] = this.facultyId;
    data['name'] = this.name;
    return data;
  }
}