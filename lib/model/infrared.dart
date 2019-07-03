class Infrared {
  final int id;
  final String name;
  final String key;

  Infrared({this.id, this.name, this.key});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'key': key,
    };
  }
}
