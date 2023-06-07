class Ships {
  String ship_name;
  String ship_type;
  List<String> roles;
  int weight_kg;
  int year_built;
  String home_port;
  String url;
  String image;
  List<Mission> missions;

  Ships({
    required this.ship_name,
    required this.ship_type,
    required this.roles,
    required this.weight_kg,
    required this.year_built,
    required this.home_port,
    required this.url,
    required this.image,
    required this.missions,
  });

  factory Ships.fromJson(Map<String, dynamic> json) {
    return Ships(
      ship_name: json['ship_name'] ?? '',
      ship_type: json['ship_type'] ?? '',
      roles: List<String>.from(json["roles"].map((x) => x)) ?? [],
      weight_kg: json['weight_kg'] ?? 0,
      year_built: json['year_built'] ?? 0,
      home_port: json['home_port'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
      missions: List<Mission>.from(
              json['missions'].map((e) => Mission.fromJson(e))) ??
          [],
    );
  }
}

class Mission {
  String name;
  int flight;

  Mission({
    required this.name,
    required this.flight,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      name: json['name'] ?? '',
      flight: json['flight'] ?? 0,
    );
  }
}
