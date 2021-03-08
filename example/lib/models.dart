class City {
  String name;

  City({required this.name});

  /// must.
  City.fromJson(Map<String, dynamic> json) : name = json['name'];

  /// must.
  Map<String, dynamic> toJson() => {
        'name': name,
      };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"name\":\"$name\"");
    sb.write('}');
    return sb.toString();
  }
}
