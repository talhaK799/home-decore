import 'package:get/get.dart';

List months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

int getMonthIndex(String month) {
  return months.indexOf(month);
}

String getMonth(int month) {
  if (month > 12) {
    month = month - 12;
  }
  return months[month - 1];
}

String getMonthDayAndYear(int day, int month, int year) {
  if (day > 31) {
    month = month + 1;
    day = day - 31;
    if (month > 12) {
      year = year + 1;
      month = month - 12;
    }
    return Get.locale!.languageCode == 'en'
        ? '$day ${months[month - 1]} $year'
        : '${months[month - 1]} $day $year';
  } else if (month > 12) {
    year = year + 1;
    month = month - 12;
    return Get.locale!.languageCode == 'en'
        ? '$day ${months[month - 1]} $year'
        : '${months[month - 1]} $day $year';
  } else {
    return Get.locale!.languageCode == 'en'
        ? '$day ${months[month - 1]} $year'
        : '${months[month - 1]} $day $year';
  }
}

String getMonthAndYear(int currentMonth) {
  if (currentMonth > 12) {
    return '${getMonth(currentMonth)} ${DateTime.now().year + 1}';
  } else {
    return '${getMonth(currentMonth)} ${DateTime.now().year}';
  }
}
