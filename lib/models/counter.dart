class Counter {
  final String title;
  final int counterStatus;
  final DateTime startTime;
  final DateTime finishTime;
  final Duration elapsedTime;
  final bool isIntermission;

  Counter(this.title,
      {this.counterStatus = 0,
      this.startTime,
      this.finishTime,
      this.elapsedTime,
      this.isIntermission = false});

  
  static Counter fromJson(Map<String, dynamic> json) => Counter(json['title'], isIntermission: json['isIntermission']);

  Map<String, dynamic> toJson() => 
  {
    'title': title,
    'isIntermission':isIntermission
  };

  @override
  String toString() {
    return '$title\n\tisPaus: $isIntermission\n';
  }
}
