class Provinces {
  final int id;
  final String name;

  Provinces({this.id, this.name});

  factory Provinces.fromJson(Map<String, dynamic> json) {
    return Provinces(
      id: json['id'],
      name: json['name'],
    );
  }
}
