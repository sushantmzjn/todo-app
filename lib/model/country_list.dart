class CountryList {
  final int id;
  final String countryName;
  final String countryCode;

  CountryList({
   required this.id,
   required this.countryName,
   required this.countryCode,
  });

  static List<CountryList> countryList(){
    return <CountryList>[
      CountryList(id: 1, countryName: 'Nepal', countryCode: 'NP'),
      CountryList(id: 2, countryName: 'USA', countryCode: 'US'),
    ];
  }
}
