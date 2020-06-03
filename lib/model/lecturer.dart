class Lecturer {
  String id;
  String firstName;
  String lastName;
  bool gender;
  String dateOfBirth;
  String address;
  String numberPhone;
  String email;
  String imageProfile;
  String formatedDate;

  Lecturer(
      {this.id,
        this.firstName,
        this.lastName,
        this.gender,
        this.dateOfBirth,
        this.address,
        this.numberPhone,
        this.email,
        this.imageProfile,
        this.formatedDate,});

  Lecturer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    numberPhone = json['numberPhone'];
    email = json['email'];
    imageProfile = json['imageProfile'];
    formatedDate = json['formatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['numberPhone'] = this.numberPhone;
    data['email'] = this.email;
    data['imageProfile'] = this.imageProfile;
    data['formatedDate'] = this.formatedDate;
    return data;
  }
}
