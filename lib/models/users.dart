class Users {
  String firstname;
  String lastname;
  String email;
  String passwords;
  String type;

  Users({this.firstname, this.lastname, this.email, this.passwords, this.type});

  Users.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    passwords = json['passwords'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['passwords'] = this.passwords;
    data['type'] = this.type;
    return data;
  }
}