class FootballLeagues {
  int league_key;
  String league_name;
  String country_name;
  String league_logo;
  String country_logo;

  FootballLeagues({
    required this.league_key,
    required this.league_name,
    required this.country_name,
    required this.league_logo,
    required this.country_logo,
  });

  factory FootballLeagues.fromJson(Map<String, dynamic> json) {
    return FootballLeagues(
      league_key: json['league_key'] ?? 0,
      league_name: json['league_name'] ?? '',
      country_name: json['country_name'] ?? '',
      league_logo: json['league_logo'] ?? '',
      country_logo: json['country_logo'] ?? '',
    );
  }
}
