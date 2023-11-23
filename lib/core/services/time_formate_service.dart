import 'package:intl/intl.dart';

class TimeFormatService {
  ///
  /// Get morning and evening start and end times
  ///
  int? moriningStartHours;
  int? eveningStartHours;
  int? morningEndHours;
  int? eveningEndHours;
  int? morningStartMins;
  int? eveningStartMins;
  int? morningEndMins;
  int? eveningEndMins;
  getMorningEventingStartEndTime(var morningTime, var eveningTime) {
    /// Morning Times
    ///
    /// Start time
    var splitMorningTime = morningTime.split('-');
    var morningStartHours = splitMorningTime[0].split(':');
    var morningStartMinutes = morningStartHours[1].split(' ');
    this.moriningStartHours = int.parse(morningStartHours[0]);
    this.morningStartMins = int.parse(morningStartMinutes[0]);

    /// End Times
    var morningEndHours = splitMorningTime[1].split(':');
    var morningEndMinutes = morningStartHours[1].split(' ');
    this.morningEndHours = int.parse(morningEndHours[0]);
    this.morningEndMins = int.parse(morningEndMinutes[0]);

    /// Evening Times
    ///
    /// Start time
    var splitEveningTime = eveningTime.split('-');
    var eveningStartHours = splitEveningTime[0].split(':');
    var eveningStartMinutes = morningStartHours[1].split(' ');
    this.eveningStartHours = int.parse(eveningStartHours[0]);
    this.eveningStartMins = int.parse(eveningStartMinutes[0]);

    /// End Times
    var eveningEndHours = splitEveningTime[1].split(':');
    var eveningEndMins = eveningStartHours[1].split(' ');
    this.eveningEndHours = int.parse(eveningEndHours[0]);
    this.eveningEndMins = int.parse(eveningEndMins[0]);
  }

  /// Get time slots for morning and evening
  List<String> getMorningAndEveningTimeSlots(
      int availableHours,
      String duration,
      String meridian,
      int hours,
      int mins,
      int index,
      int length,
      List<String> bookingTimes) {
    if (mins == 0) {
      if (meridian == "AM") {
        bookingTimes.add('$hours:${mins}0 ${hours >= 12 ? "PM" : "AM"}');
      } else {
        bookingTimes.add('$hours:${mins}0 ${hours >= 12 ? "AM" : "PM"}');
      }
    } else {
      if (meridian == "AM") {
        bookingTimes.add('$hours:$mins ${hours >= 12 ? "PM" : "AM"}');
      } else {
        bookingTimes.add('$hours:$mins ${hours >= 12 ? "AM" : "PM"}');
      }
    }
    int i = 0;
    while (availableHours > 1) {
      mins = mins + int.parse(duration);

      ///
      /// When duration is more than an hour then loop will run untill mins down below 60
      while (mins >= 60) {
        if (mins >= 60) {
          availableHours -= 1;
          mins = mins - 60;
          hours = hours + 1;
          if (mins < 60) {
            if (mins == 0) {
              if (meridian == "AM") {
                bookingTimes
                    .add('$hours:${mins}0 ${hours >= 12 ? "PM" : "AM"}');
              } else {
                bookingTimes
                    .add('$hours:${mins}0 ${hours >= 12 ? "AM" : "PM"}');
              }
            } else {
              if (meridian == "AM") {
                bookingTimes.add('$hours:$mins ${hours >= 12 ? "PM" : "AM"}');
              } else {
                bookingTimes.add('$hours:$mins ${hours >= 12 ? "AM" : "PM"}');
              }
            }
          }
        }
      }
      i = i++;
    }

    if (index == 0) {
      String presentHour = DateFormat('hh').format(DateTime.now());
      String presentMin = DateFormat('mm').format(DateTime.now());
      presentHour =
          presentHour == '12' ? '${int.parse(presentHour) - 12}' : presentHour;

      for (int i = 0; i < bookingTimes.length; i++) {
        // print('Hours => ${int.parse(bookingTimes[i].split(':')[0])}');
        // print(bookingTimes[i]);
        for (int j = 0; j < i; j++) {
          if (int.parse(bookingTimes[j].split(':')[0]) <=
              int.parse(presentHour)) {
            // print('Hours => ${int.parse(bookingTimes[1].split(':')[0])}');
            // print(
            //     '==>>minutes ${int.parse(bookingTimes[j].split(':')[1].split(' ')[0])}');
            if (int.parse(bookingTimes[j].split(':')[1].split(' ')[0]) <=
                int.parse(presentMin)) {
              bookingTimes.remove(bookingTimes[j]);
            } else {
              // print('Specific bookingTime => ${bookingTimes[i]}');
              bookingTimes.remove(bookingTimes[j]);
            }
          }
        }
      }
    }

    return bookingTimes;
  }

  
}
