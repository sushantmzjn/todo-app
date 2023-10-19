class FootballLive {
  String event_date;
  String event_time;
  String event_home_team;
  String event_away_team;
  String event_final_result;
  String event_status;
  String league_name;
  String event_stadium;
  String home_team_logo;
  String away_team_logo;
  String event_home_formation;
  String event_away_formation;
  List<GoalScorers> goalscorers;
  List<Statistics> statistics;
  List<Cards> cards;
  String msg;

  FootballLive({
    required this.event_date,
    required this.event_time,
    required this.event_home_team,
    required this.event_away_team,
    required this.event_final_result,
    required this.event_status,
    required this.league_name,
    required this.event_stadium,
    required this.home_team_logo,
    required this.away_team_logo,
    required this.event_home_formation,
    required this.event_away_formation,
    required this.goalscorers,
    required this.statistics,
    required this.cards,
    required this.msg
  });

  factory FootballLive.fromJson(Map<String, dynamic> json) {
    return FootballLive(
      msg: json['msg'] ?? '',
      event_date: json['event_date'] ?? '',
      event_time: json['event_time'] ?? '',
      event_home_team: json['event_home_team'] ?? '',
      event_away_team: json['event_away_team'] ?? '',
      event_final_result: json['event_final_result'] ?? '',
      event_status: json['event_status'] ?? '',
      league_name: json['league_name'] ?? '',
      event_stadium: json['event_stadium'] ?? '',
      home_team_logo: json['home_team_logo'] ?? '',
      away_team_logo: json['away_team_logo'] ?? '',
      event_home_formation: json['event_home_formation'] ?? '',
      event_away_formation: json['event_away_formation'] ?? '',
      goalscorers: (json['goalscorers']) != null ?
      List<GoalScorers>.from(json['goalscorers'].map((e) => GoalScorers.fromJson(e))) : [],
      statistics: (json['statistics']) != null ?
      List<Statistics>.from(json['statistics'].map((e) => Statistics.fromJson(e))) : [],
      cards: (json['cards']) != null ?
      List<Cards>.from(json['cards'].map((e) => Cards.fromJson(e))) : [],
    );
  }
}

class GoalScorers {
  String time;
  String home_scorer;
  String away_scorer;
  String info;

  GoalScorers({
    required this.time,
    required this.home_scorer,
    required this.away_scorer,
    required this.info,
  });

  factory GoalScorers.fromJson(Map<String, dynamic> json) {
    return GoalScorers(
      time: json['time'] ?? '',
      home_scorer: json['home_scorer'] ?? '',
      away_scorer: json['away_scorer'] ?? '',
      info: json['info'] ?? '',
    );
  }
}

class Statistics {
  String type;
  String home;
  String away;

  Statistics({
    required this.type,
    required this.home,
    required this.away,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      type: json['type'] ?? '',
      home: json['home'] ?? '',
      away: json['away'] ?? '',
    );
  }
}

class Cards{
  String time;
  String home_fault;
  String away_fault;
  String card;

  Cards({
   required this.time,
   required this.home_fault,
   required this.away_fault,
   required this.card
  });

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
        time: json['time']??'',
        home_fault: json['home_fault']??'',
        away_fault: json['away_fault']??'',
        card: json['card']??''
    );
  }
}
