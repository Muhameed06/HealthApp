import 'package:health_app/models/user_health.dart';

class DataHelper {
  // Static method to generate mock data
  static List<UserHealthModel> generateMockData(int count) {
    return List.generate(count, (index) {
      return UserHealthModel(
        timestamp: DateTime.now().subtract(Duration(minutes: index)).toIso8601String(),
        heartRate: 60 + index % 40,
        steps: 5000 + index % 1000,
      );
    });
  }
}
