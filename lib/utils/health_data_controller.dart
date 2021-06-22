import 'package:health/health.dart';

class HealthDataController {
  final HealthFactory healthFactory;

  HealthDataController(this.healthFactory);

  Future<List<HealthDataPoint>?> fetchHealthData() async {
    print('=============================================');
    print('[FUNC CALL] HealthDataController.fetchHealthData');
    print('=============================================');
    print('');

    // 가져올 데이터 타입을 리스트에 담습니다.
    final List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.DISTANCE_WALKING_RUNNING,
      HealthDataType.WATER,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_AWAKE,
    ];

    // 권한을 요청하고 `bool` 타입의 결과값을 반환받습니다.
    final bool isAccessGranted =
        await healthFactory.requestAuthorization(types);

    print('=============================================');
    print('1) [Health] Authorization Requested');
    print('* is Access Granted : $isAccessGranted');
    print('');

    if (!isAccessGranted) {
      print('2) [Health] Authorization Failed');
      print('=============================================');
      print('');
      return null;
    }

    try {
      // 데이터를 가져올 날짜 범위를 지정합니다. (어제 하루)
      final DateTime now = DateTime.now();
      final DateTime startDate =
          DateTime(now.year, now.month, now.day - 1, 0, 0, 0);
      final DateTime endDate =
          DateTime(now.year, now.month, now.day - 1, 23, 59, 59);

      print('2) [Health] DateTime Filtered with Yesterday 0:0:0 - 23:59:59');
      print('* Start Date : $startDate');
      print('* End Date : $endDate');
      print('');

      // 위에서 지정한 데이터들을 가져옵니다.
      List<HealthDataPoint> healthData =
          await healthFactory.getHealthDataFromTypes(startDate, endDate, types);

      print('3) [Health] Health Data List Fetched');
      print('* Fetched Total : ${healthData.length}');
      if (healthData.length > 0) print('* First Data : ${healthData[0]}');
      print('');

      // 중복을 제거합니다.
      healthData = HealthFactory.removeDuplicates(healthData);

      print('4) [Health] Health Data Duplicates Removed');
      print('* Left Total : ${healthData.length}');
      if (healthData.length > 0) print('* First Data : $healthData[0]');
      print('=============================================');
      print('');

      return healthData;
    } catch (e) {
      print('*********************************************');
      print(e);
      print('*********************************************');
      print('');

      return null;
    }
  }
}
