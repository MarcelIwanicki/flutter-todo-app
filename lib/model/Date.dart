import 'package:intl/intl.dart';

class Date {
  final int year;
  final int month;
  final int day;
  final String weekDay;

  Date(this.year, this.month, this.day, this.weekDay);

  bool equals(Date date) {
    if(date.year == year && date.month == month && date.day == day)
      return true;
    return false;
  }
}

class DateBuilder {
  int mYear;
  int mMonth;
  int mDay;
  String mWeekDay;

  DateBuilder from(DateTime dateTime) {
    mYear = dateTime.year;
    mMonth = dateTime.month;
    mDay = dateTime.day;
    mWeekDay = DateFormat('EEEE').format(dateTime);
    return this;
  }

  DateBuilder year(int year) {
    mYear = year;
    return this;
  }

  DateBuilder month(int month) {
    mMonth = month;
    return this;
  }

  DateBuilder day(int day) {
    mDay = day;
    return this;
  }

  DateBuilder weekDay(String weekDay) {
    mWeekDay = weekDay;
    return this;
  }

  Date build() {
    return Date(mYear, mMonth, mDay, mWeekDay);
  }
}