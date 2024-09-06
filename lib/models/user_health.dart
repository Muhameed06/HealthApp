class UserHealthModel {
  final String timestamp;
  final int heartRate;
  final int steps;

  UserHealthModel({
    required this.timestamp,
    required this.heartRate,
    required this.steps,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'heart_rate': heartRate,
      'steps': steps,
    };
  }

  static UserHealthModel fromMap(Map<String, dynamic> map) {
    return UserHealthModel(
      timestamp: map['timestamp'],
      heartRate: map['heart_rate'],
      steps: map['steps'],
    );
  }
}