class CollectionModel {
  double? today;
  double? week;
  double? month;

  get getToday => this.today;

  set setToday(double today) => this.today = today;

  get getWeek => this.week;

  set setWeek(week) => this.week = week;

  get getMonth => this.month;

  set setMonth(month) => this.month = month;

  CollectionModel.empty();

  CollectionModel.full({
    this.today,
    this.week,
    this.month,
  });

  CollectionModel.today({this.today});
  CollectionModel.week({this.week});
  CollectionModel.month({this.month});

  factory CollectionModel.fromJsonToday(Map<String, dynamic> json) {
    return CollectionModel.today(
      today: json["today"] as double,
    );
  }

  factory CollectionModel.fromJsonWeek(Map<String, dynamic> json) {
    return CollectionModel.week(
      week: json["week"] as double,
    );
  }

  factory CollectionModel.fromJsonMonth(Map<String, dynamic> json) {
    return CollectionModel.month(
      month: json["month"] as double,
    );
  }

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel.full(
      today: json["today"] as double,
      week: json["week"] as double,
      month: json["month"] as double,
    );
  }
}
